import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static String appName = '';
  static String packageName = '';
  static String versionName = '';
  static String versionCode = '';
  static String fullVersion = '';
  static Future<void> loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    versionName = packageInfo.version;
    versionCode = packageInfo.buildNumber;
    fullVersion = '$versionName+$versionCode';
  }
}
