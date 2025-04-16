import 'package:tapsell_plus/tapsell_plus.dart';

class AdManager {
  // static final String appId = "alsoatsrtrotpqacegkehkaiieckldhrgsbspqtgqnbrrfccrtbdomgjtahflchkqtqosa";
  static final String appId = "msqitnpjphtfimfqgpagsslegimfajmkbfpliciekakkpjnhpgqngjfkfdmmjkfsdaqhla";
  // static final String zoneId = "5cfaa942e8d17f0001ffb292";
  static final String zoneId = "67ffc2e563943b49f700b750";
  static String response = "";

  static void initialize() {
    TapsellPlus.instance.initialize(appId);
    TapsellPlus.instance.setGDPRConsent(true);
    TapsellPlus.instance.setDebugMode(LogLevel.Debug);
  }

  static void prepareAd() {
    TapsellPlus.instance.requestRewardedVideoAd(zoneId).then((responseId) {
      response = responseId;
    });
  }

  static void showAd() {
    TapsellPlus.instance.showRewardedVideoAd(response,
        onOpened: (map) {
          // Ad opened
        }, onError: (map) {
          // Ad had error - map contains `error_message`
        }, onClosed: (map) {
          // Ad closed
        });
  }
}
