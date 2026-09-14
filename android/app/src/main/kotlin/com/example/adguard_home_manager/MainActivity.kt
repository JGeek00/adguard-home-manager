package com.jgeek00.adguard_home_manager

import android.app.LocaleManager
import android.content.pm.PackageManager
import android.os.Build
import android.os.LocaleList
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/** Exposes the per-app language preference, available from Android 13 on. */
class MainActivity: FlutterActivity() {
    private val channelName = "com.jgeek00.adguard_home_manager/locale"
    private val localNetworkChannelName = "com.jgeek00.adguard_home_manager/local_network"

    // String literal on purpose: the constant only exists in API 37 SDK and
    // the project compiles with 36.
    private val localNetworkPermission = "android.permission.ACCESS_LOCAL_NETWORK"
    private val localNetworkRequestCode = 0x4C4E
    private var localNetworkResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channelName
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getApplicationLocale" -> result.success(getApplicationLocale())
                "setApplicationLocale" -> {
                    setApplicationLocale(call.argument<String>("tag"))
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            localNetworkChannelName
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "isGranted" -> result.success(isLocalNetworkGranted())
                "request" -> requestLocalNetworkPermission(result)
                else -> result.notImplemented()
            }
        }
    }

    /** Local Network Protection is only enforced on Android 16+, and the
        ACCESS_LOCAL_NETWORK runtime permission only exists on Android 17+ for
        apps targeting SDK 37. Below that, INTERNET implicitly covers the LAN. */
    private fun isLocalNetworkGranted(): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.BAKLAVA) return true
        return ContextCompat.checkSelfPermission(this, localNetworkPermission) ==
            PackageManager.PERMISSION_GRANTED
    }

    private fun requestLocalNetworkPermission(result: MethodChannel.Result) {
        if (isLocalNetworkGranted()) {
            result.success(true)
            return
        }
        // System shows the dialog at most a couple of times; extra calls
        // just resolve as denied, so never suspend the Dart side on this.
        localNetworkResult?.success(false)
        localNetworkResult = result
        ActivityCompat.requestPermissions(
            this, arrayOf(localNetworkPermission), localNetworkRequestCode
        )
    }

    override fun onRequestPermissionsResult(
        requestCode: Int, permissions: Array<out String>, grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == localNetworkRequestCode) {
            localNetworkResult?.success(
                grantResults.isNotEmpty() &&
                    grantResults[0] == PackageManager.PERMISSION_GRANTED
            )
            localNetworkResult = null
        }
    }

    private fun getApplicationLocale(): String? {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) return null

        val localeManager = getSystemService(LocaleManager::class.java) ?: return null
        val locales = localeManager.applicationLocales
        if (locales.isEmpty) return null
        return locales.get(0)?.toLanguageTag()
    }

    private fun setApplicationLocale(tag: String?) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) return

        val localeManager = getSystemService(LocaleManager::class.java) ?: return
        localeManager.applicationLocales = if (tag.isNullOrEmpty()) {
            LocaleList.getEmptyLocaleList()
        } else {
            LocaleList.forLanguageTags(tag)
        }
    }
}
