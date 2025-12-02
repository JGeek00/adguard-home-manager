<h1 align="center">
  AdGuard Private DNS Client
</h1>

<h5 align="center">
  <b>
    Cliente no oficial para <a href="https://adguard-dns.io/es/" target="_blank" rel="noopener noreferrer">AdGuard Private DNS</a> desarrollado con Flutter.
  </b>
</h5>

<p align="center">
  <img src="https://via.placeholder.com/300x100?text=Disponible+pronto+en+Google+Play" width="300px">
  <img src="https://via.placeholder.com/300x100?text=Descargar+APK" width="300px">
</p>

<br>
<div>
  <div align="center">
    <b>ℹ️ INFORMACIÓN IMPORTANTE ℹ️</b>
  </div>
  <br>
  Esta aplicación es un <b>fork</b> de <a href="https://github.com/JGeek00/adguard-home-manager">AdGuard Home Manager</a>, transformada para funcionar exclusivamente con la API de <b>AdGuard Private DNS</b>. No es compatible con servidores AdGuard Home autoalojados.
</div>
<br>

## Características principales
<p>▶ Gestiona tu cuenta de AdGuard Private DNS de forma sencilla.</p>
<p>▶ Soporte para autenticación mediante API Key.</p>
<p>▶ Panel de control con estadísticas de uso y límites de la cuenta.</p>
<p>▶ Gestión de Perfiles (Servidores DNS).</p>
<p>▶ Gestión de Dispositivos (Crear, Editar, Eliminar).</p>
<p>▶ Visualización de Registros de Consultas (Query Logs).</p>
<p>▶ Gestión de Listas de Filtros.</p>
<p>▶ Interfaz Material You con temas dinámicos (solo Android 12+).</p>
<p>▶ Soporte completo de escritorio para macOS, Linux y Windows.</p>
<p>▶ UI responsiva adaptada a pantallas horizontales.</p>

## Política de privacidad
Consulta la política de privacidad [aquí](PRIVACY_POLICY.md).

## Descargo de responsabilidad
Esta es una aplicación no oficial. El equipo de AdGuard y el desarrollo del software AdGuard DNS no están relacionados de ninguna manera con esta aplicación.

## Generar versión de producción
<ul>
  <li>
    <b>Prerrequisitos</b>
    <ol>
      <li>Abre <code>pubspec.yaml</code> y cambia el nombre de la versión y el número de versión.</li>
      <li>Ejecuta <code>flutter clean</code>.</li>
      <li>Ejecuta <code>flutter pub get</code>.</li>
    </ol>
  </li>
  <li>
    <b>Android</b>
    <ol>  
      <li>Asegúrate de tener tu archivo <code>key.properties</code> en <code>android/</code>, con todos los valores requeridos de tu clave de firma configurados correctamente.</li>
      <li>Asegúrate de tener tu archivo keystore en <code>android/app</code>.</li>
      <li>Ejecuta <code>flutter build apk --release</code> para compilar el APK.</li>
      <li>El paquete .apk se encuentra en <code>build/app/outputs/flutter-apk/app-release.apk</code>.</li>
    </ol>
  </li>
  <li>
    <b>macOS</b>
    <ol>  
      <li>Ejecuta <code>flutter build macos --release</code> para compilar la versión de producción.</li>
      <li>El paquete .app se encuentra en <code>build/macos/Build/Products/Release/AdGuard Private DNS Client.app</code>.</li>
    </ol>
  </li>
  <li>
    <b>Linux</b>
    <ul>
      <b>Prerrequisitos</b>
      <ol>
        <li>Instala rps ejecutando <code>dart pub global activate rps --version 0.7.0-dev.6</code></li>
      </ol>
      <b>Compilación</b>
      <ol>
        <li>Abre el archivo <code>debian.yaml</code> dentro de debian/ y actualiza el número de versión</li>
        <li>Ejecuta <code>rps build linux</code></li>
        <li>El .tar.gz está en <code>build/linux/x64/release/bundle</code></li>
        <li>El paquete .deb está en <code>build/linux/x64/release/debian/</code></li>
      </ol>
    </ul>
  </li>
  <li>
    <b>Windows</b>
    <ol>
      <li>Ejecuta <code>flutter build windows --release</code>.</li>
      <li>Abre la aplicación Inno Setup Compiler y carga el script</li>
      <li>El script se encuentra en <code>windows/innosetup_installer_builder.iss</code></li>
      <li>Actualiza el número de versión y guarda los cambios</li>
      <li>Haz clic en el botón Compilar</li>
      <li>El instalador se generará en <code>build/windows/aghm_installer.exe</code>.</li>
    </ol>
  </li>
</ul>

## Bibliotecas de terceros
- [provider](https://pub.dev/packages/provider)
- [sqflite](https://pub.dev/packages/sqflite)
- [http](https://pub.dev/packages/http)
- [expandable](https://pub.dev/packages/expandable)
- [package info plus](https://pub.dev/packages/package_info_plus)
- [flutter phoenix](https://pub.dev/packages/flutter_phoenix)
- [flutter launcher icons](https://pub.dev/packages/flutter_launcher_icons)
- [flutter native splash](https://pub.dev/packages/flutter_native_splash)
- [intl](https://pub.dev/packages/intl)
- [animations](https://pub.dev/packages/animations)
- [dynamic color](https://pub.dev/packages/dynamic_color)
- [device info](https://pub.dev/packages/device_info)
- [fl chart](https://pub.dev/packages/fl_chart)
- [flutter svg](https://pub.dev/packages/flutter_svg)
- [percent indicator](https://pub.dev/packages/percent_indicator)
- [flutter markdown](https://pub.dev/packages/flutter_markdown)
- [markdown](https://pub.dev/packages/markdown)
- [html](https://pub.dev/packages/html)
- [flutter html](https://pub.dev/packages/flutter_html)
- [sqlite3 flutter libs](https://pub.dev/packages/sqlite3_flutter_libs)
- [sqflite common ffi](https://pub.dev/packages/sqflite_common_ffi)
- [window size](https://github.com/google/flutter-desktop-embedding)
- [flutter split view](https://github.com/JGeek00/flutter_split_view) (fork de [aquí](https://pub.dev/packages/flutter_split_view))
- [async](https://pub.dev/packages/async)
- [sentry flutter](https://pub.dev/packages/sentry_flutter)
- [flutter dotenv](https://pub.dev/packages/flutter_dotenv)
- [flutter reorderable list](https://pub.dev/packages/flutter_reorderable_list)
- [pie chart](https://pub.dev/packages/pie_chart)
- [segmented button slide](https://pub.dev/packages/segmented_button_slide)
- [timezone](https://pub.dev/packages/timezone)
- [url launcher](https://pub.dev/packages/url_launcher)
- [flutter custom tabs](https://pub.dev/packages/flutter_custom_tabs)
- [shared preferences](https://pub.dev/packages/shared_preferences)
- [window manager](https://pub.dev/packages/window_manager)

<br>

##### Basado en el trabajo de JGeek00
