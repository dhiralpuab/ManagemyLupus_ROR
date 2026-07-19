package com.managemylupus.app

import android.app.Application
import dev.hotwire.turbo.config.TurboPathConfiguration

class TurboApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        // Configure path configuration
        TurboPathConfiguration.configure(
            context = this,
            location = TurboPathConfiguration.Location(
                assetFilePath = "path_configuration.json",
                remoteFileUrl = "$BASE_URL/turbo/native/configuration"
            )
        )
    }

    companion object {
        // TODO: Update this to your production Rails app URL
        const val BASE_URL = "https://your-rails-app.com"
    }
}
