class Language {
  static String toPersian(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }
    return input;
  }

  static Duration convertStringToDuration(String time) {
    List<String> parts = time.split(":");
    int minutes = int.parse(parts[0]);
    int seconds = int.parse(parts[1]);

    return Duration(minutes: minutes, seconds: seconds);
  }

  static String convertDurationToString(Duration time) {
    return "0${time.inMinutes}:${time.inSeconds.remainder(60)}";
  }

  static String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
}
