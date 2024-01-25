<h1 align="center">
  <img src="https://github.com/JGeek00/adguard-home-manager/raw/master/assets/other/banner.png" />
</h1>

<h5 align="center">
  <b>
    AdGuard Home Manager is an 
    <a href="https://adguard.com/es/adguard-home/overview.html" target="_blank" rel="noopener noreferrer">
      AdGuard Home
    </a> 
    unofficial client developed with Flutter.</b>
</h5>

<p align="center">
  <a href="https://play.google.com/store/apps/details?id=com.jgeek00.adguard_home_manager" target="_blank" rel="noopener noreferrer">
    <img src="/assets/other/get_google_play.png" width="300px">
  </a>
  <a href="https://github.com/JGeek00/adguard-home-manager/releases" target="_blank" rel="noopener noreferrer">
    <img src="/assets/other/get-github.png" width="300px">
  </a>
</p>

## Main features
<p>▶ Manage your AdGuard Home server on an easy way.</p>
<p>▶ Supports HTTP and HTTPS connections.</p>
<p>▶ Enable and disable the different protections with only one switch.</p>
<p>▶ Add multiple servers to the app, and manage all of them from here.</p>
<p>▶ See and filter the query logs.</p>
<p>▶ Manage your filtering lists.</p>
<p>▶ See the clients list and create a custom configuration for a client.</p>
<p>▶ Configure the allowed devices, DHCP, DNS or rewrites among others.</p>
<p>▶ Material You interface with dynamic theming (only Android 12+).</p>
<p>▶ Full desktop support with builds for macOS, Linux and Windows.</p>
<p>▶ Responsive UI adapted for landscape displays.</p>

## Privacy policy
Check the privacy policy [here](https://github.com/JGeek00/adguard-home-manager/wiki/Privacy-policy).

## Disclaimer
This is an unofficial application. The AdGuard Home team and the development of the AdGuard Home software is not related in any way with this application.

## Recommended configuration and lists
On [this repository](https://github.com/JuanRodenas/Pihole_list) you can find a recommended configuration for AdGuard Home and some lists. Thanks to [JuanRodenas](https://github.com/JuanRodenas).

## Generate production build
<ul>
  <li>
    <b>Prerequisites</b>
    <ol>
      <li>Open <code>pubspec.yaml</code> and change the version name and the version number.</li>
      <li>Run <code>flutter clean</code>.</li>
      <li>Run <code>flutter pub get</code>.</li>
    </ol>
  </li>
  <li>
    <b>Android</b>
    <ol>  
      <li>Make sure you have your <code>key.properties</code> file at <code>android/</code>, with all the required values of your signing key correctly set up.</li>
      <li>Make sure you have your keystore file at <code>android/app</code>.</li>
      <li>Run <code>flutter build apk --release</code> to compile the APK.</li>
      <li>The .apk package is located at <code>build/app/outputs/flutter-apk/app-release.apk</code>.</li>
    </ol>
  </li>
  <li>
    <b>macOS</b>
    <ol>  
      <li>Run <code>flutter build macos --release</code> to compile the production build.</li>
      <li>The .app package is located at <code>build/macos/Build/Products/Release/AdGuard Home Manager.app</code>.</li>
    </ol>
  </li>
  <li>
    <b>Linux</b>
    <ul>
      <b>Prerequisites</b>
      <ol>
        <li>Install rps by running <code>dart pub global activate rps --version 0.7.0-dev.6</code></li>
      </ol>
      <b>Build</b>
      <ol>
        <li>Open <code>debian.yaml</code> file inside debian/ and update the version number</li>
        <li>run <code>rps build linux</code></li>
        <li>The .tar.gz is at <code>build/linux/x64/release/bundle</code></li>
        <li>The .deb package is at <code>build/linux/x64/release/debian/</code></li>
      </ol>
    </ul>
  </li>
  <li>
    <b>Windows</b>
    <ol>
      <li>Run <code>flutter build windows --release</code>.</li>
      <li>Open Inno Setup Compiler application and load the script</li>
      <li>The script is located at <code>windows/innosetup_installer_builder.iss</code></li>
      <li>Update the version number and save the changes</li>
      <li>Click on the Compile button</li>
      <li>The installer will be generated at <code>build/windows/aghm_installer.exe</code>.</li>
    </ol>
  </li>
</ul>

## Third party libraries
- [provider](https://pub.dev/packages/provider)
- [sqflite](https://pub.dev/packages/sqflite)
- [http](https://pub.dev/packages/http)
- [expandable](https://pub.dev/packages/expandable)
- [package info plus](https://pub.dev/packages/package_info_plus)
- [flutter phoenix](https://pub.dev/packages/flutter_phoenix)
- [flutter displaymode](https://pub.dev/packages/flutter_displaymode)
- [flutter launcher icons](https://pub.dev/packages/flutter_launcher_icons)
- [flutter native splash](https://pub.dev/packages/flutter_native_splash)
- [intl](https://pub.dev/packages/intl)
- [animations](https://pub.dev/packages/animations)
- [dynamic color](https://pub.dev/packages/dynamic_color)
- [device info](https://pub.dev/packages/device_info)
- [fl chart](https://pub.dev/packages/fl_chart)
- [flutter web browser](https://pub.dev/packages/flutter_web_browser)
- [flutter svg](https://pub.dev/packages/flutter_svg)
- [percent indicator](https://pub.dev/packages/percent_indicator)
- [store checker](https://pub.dev/packages/store_checker)
- [flutter markdown](https://pub.dev/packages/flutter_markdown)
- [markdown](https://pub.dev/packages/markdown)
- [html](https://pub.dev/packages/html)
- [flutter html](https://pub.dev/packages/flutter_html)
- [sqlite3 flutter libs](https://pub.dev/packages/sqlite3_flutter_libs)
- [sqflite common ffi](https://pub.dev/packages/sqflite_common_ffi)
- [window size](https://github.com/google/flutter-desktop-embedding)
- [flutter split view](https://github.com/JGeek00/flutter_split_view) (forked from [here](https://pub.dev/packages/flutter_split_view))
- [async](https://pub.dev/packages/async)
- [sentry flutter](https://pub.dev/packages/sentry_flutter)
- [flutter dotenv](https://pub.dev/packages/flutter_dotenv)
- [flutter reorderable list](https://pub.dev/packages/flutter_reorderable_list)
- [pie chart](https://pub.dev/packages/pie_chart)
- [segmented button slide](https://pub.dev/packages/segmented_button_slide)
- [timezone](https://pub.dev/packages/timezone)

<br>

##### Created by JGeek00
