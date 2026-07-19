package com.managemylupus.app

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.webkit.CookieManager
import android.webkit.WebSettings
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import dev.hotwire.turbo.config.TurboPathConfiguration
import dev.hotwire.turbo.session.TurboSessionNavHostFragment
import kotlin.reflect.KClass

class MainSessionNavHostFragment : TurboSessionNavHostFragment() {

    override val sessionName = "main"

    override val startLocation = TurboApplication.BASE_URL

    override val registeredFragments: List<KClass<out Fragment>> = listOf(
        WebFragment::class,
        WebBottomSheetDialogFragment::class
    )

    override val registeredActivities: List<KClass<out AppCompatActivity>> = listOf()

    override val pathConfigurationLocation: TurboPathConfiguration.Location
        get() = TurboPathConfiguration.Location(
            assetFilePath = "path_configuration.json",
            remoteFileUrl = "${TurboApplication.BASE_URL}/turbo/native/configuration"
        )

    private var networkCallback: ConnectivityManager.NetworkCallback? = null

    override fun onSessionCreated() {
        super.onSessionCreated()

        // Configure WebView settings
        session.webView.apply {
            settings.apply {
                userAgentString = "${settings.userAgentString} Turbo Native Android"
                domStorageEnabled = true
                javaScriptEnabled = true

                // Enable offline caching
                cacheMode = WebSettings.LOAD_DEFAULT
                databaseEnabled = true

                // Allow service workers
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                    setServiceWorkerClient(android.webkit.ServiceWorkerClient())
                }
            }
        }

        // Enable cookies for session persistence
        CookieManager.getInstance().apply {
            setAcceptCookie(true)
            setAcceptThirdPartyCookies(session.webView, true)
        }

        // Start network monitoring
        startNetworkMonitoring()
    }

    private fun startNetworkMonitoring() {
        val connectivityManager = requireContext().getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        networkCallback = object : ConnectivityManager.NetworkCallback() {
            override fun onAvailable(network: Network) {
                // Back online - reload if needed
                activity?.runOnUiThread {
                    session.webView.reload()
                }
            }

            override fun onLost(network: Network) {
                // Went offline - service worker will handle cached content
            }
        }

        val networkRequest = NetworkRequest.Builder()
            .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            .build()

        connectivityManager.registerNetworkCallback(networkRequest, networkCallback!!)
    }

    override fun onDestroyView() {
        super.onDestroyView()

        // Unregister network callback
        networkCallback?.let {
            val connectivityManager = requireContext().getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            connectivityManager.unregisterNetworkCallback(it)
        }
    }

    fun navigateToUrl(url: String) {
        navigate(url)
    }

    fun isOnline(): Boolean {
        val connectivityManager = requireContext().getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val network = connectivityManager.activeNetwork ?: return false
        val capabilities = connectivityManager.getNetworkCapabilities(network) ?: return false
        return capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
    }
}
