import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Возвращает строку устройства, например "iPhone 15" или "Samsung Galaxy S24"
Future<String> getDeviceString() async {
  final deviceInfo = DeviceInfoPlugin();
  try {
    if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      return '${ios.name} ${ios.model}';
    } else if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      return '${android.manufacturer} ${android.model}';
    }
  } catch (_) {}
  return Platform.operatingSystem;
}

/// Возвращает версию приложения из pubspec (например "0.2.2")
Future<String> getAppVersion() async {
  try {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  } catch (_) {
    return '0.0.0';
  }
}
