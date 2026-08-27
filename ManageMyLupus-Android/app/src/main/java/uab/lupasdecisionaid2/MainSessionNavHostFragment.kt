package uab.lupasdecisionaid2

import android.webkit.CookieManager
import android.webkit.WebSettings
import android.webkit.WebView
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import dev.hotwire.turbo.config.TurboPathConfiguration
import dev.hotwire.turbo.session.TurboSessionNavHostFragment
import kotlin.reflect.KClass

class MainSessionNavHostFragment : TurboSessionNavHostFragment() {

    override val sessionName = "main"

    override val startLocation: String
        get() = TurboApplication.BASE_URL

    override val registeredActivities: List<KClass<out AppCompatActivity>>
        get() = listOf()

    override val registeredFragments: List<KClass<out Fragment>>
        get() = listOf(
            WebFragment::class,
            WebBottomSheetDialogFragment::class
        )

    override val pathConfigurationLocation: TurboPathConfiguration.Location
        get() = TurboPathConfiguration.Location(
            assetFilePath = "json/path_configuration.json"
        )

    override fun onSessionCreated() {
        super.onSessionCreated()

        // Clear cached data to fix stale 500 error pages
        session.webView.clearCache(true)

        // Enable debugging for WebView in debug builds
        WebView.setWebContentsDebuggingEnabled(true)

        // Enable cookies for session persistence
        val cookieManager = CookieManager.getInstance()
        cookieManager.setAcceptCookie(true)
        cookieManager.setAcceptThirdPartyCookies(session.webView, true)

        session.webView.settings.apply {
            userAgentString = "$userAgentString Turbo Native Android"

            // Use default caching - respects server cache headers
            cacheMode = WebSettings.LOAD_DEFAULT
            domStorageEnabled = true
            databaseEnabled = true

            // Allow local storage for offline data
            javaScriptEnabled = true

            // Ensure cookies work properly
            mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
        }
    }
}
