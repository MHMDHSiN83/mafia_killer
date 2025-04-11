import 'package:tapsell_plus/tapsell_plus.dart';

class AdManager {
  static final String appId = "alsoatsrtrotpqacegkehkaiieckldhrgsbspqtgqnbrrfccrtbdomgjtahflchkqtqosa";
  static final String zoneId = "5cfaa942e8d17f0001ffb292";
  static String response = "";

  static void initialize() {
    TapsellPlus.instance.initialize(appId);
    TapsellPlus.instance.setGDPRConsent(true);
    TapsellPlus.instance.setDebugMode(LogLevel.Debug);
  }

  static void prepareAd() {
    TapsellPlus.instance.requestInterstitialAd(zoneId).then((responseId) {
      response = responseId;
    });
  }

  static void showAd() {
    TapsellPlus.instance.showInterstitialAd(response,
        onOpened: (map) {
          // Ad opened
        }, onError: (map) {
          // Ad had error - map contains `error_message`
        }, onClosed: (map) {
          // Ad closed
        });
  }
}
