package uab.lupasdecisionaid2

import android.app.Application

class TurboApplication : Application() {

    override fun onCreate() {
        super.onCreate()
    }

    companion object {
        // Change this to your production URL when deploying
        // For localhost testing on physical device:
        const val BASE_URL = "https://managemylupus.com"

        // For emulator use: "http://10.0.2.2:3000"
        // http://192.168.1.194:3000
        // For production use: "https://managemylupus.com"
    }
}
