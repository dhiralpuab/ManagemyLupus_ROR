package uab.lupasdecisionaid2

import android.os.Bundle
import android.view.View
import android.webkit.WebSettings
import dev.hotwire.turbo.fragments.TurboWebFragment
import dev.hotwire.turbo.nav.TurboNavGraphDestination

@TurboNavGraphDestination(uri = "turbo://fragment/web")
class WebFragment : TurboWebFragment() {

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // Configure WebView for offline caching when view is created
        try {
            session.webView.settings.apply {
                cacheMode = WebSettings.LOAD_DEFAULT
                domStorageEnabled = true
                databaseEnabled = true
            }
        } catch (e: Exception) {
            // WebView not ready yet, will be configured in MainSessionNavHostFragment
        }
    }
}
