package com.jgeek00.adguard_home_manager

import android.app.LocaleManager
import android.os.Build
import android.os.LocaleList
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/** Exposes the per-app language preference, available from Android 13 on. */
class MainActivity: FlutterActivity() {
    private val channelName = "com.jgeek00.adguard_home_manager/locale"

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
