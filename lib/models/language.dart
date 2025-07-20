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

  static String trimTextWithZWNJ(String text) {
    String result = text.trim();
    result = String.fromCharCodes(
      result.runes.where((char) => char != 8204),
    );
    return result;
  }

  static String getPersianOrdinal(int number) {
    switch (number) {
      case 0:
        return 'معارفه';
      case 1:
        return 'اول';
      case 2:
        return 'دوم';
      case 3:
        return 'سوم';
      case 4:
        return 'چهارم';
      case 5:
        return 'پنجم';
      case 6:
        return 'ششم';
      case 7:
        return 'هفتم';
      case 8:
        return 'هشتم';
      case 9:
        return 'نهم';
      case 10:
        return 'دهم';
      default:
        return 'not enough';
    }
  }

  static String getPersianNumberWord(int number) {
    switch (number) {
      case 1:
        return 'یک';
      case 2:
        return 'دو';
      case 3:
        return 'سه';
      case 4:
        return 'چهار';
      case 5:
        return 'پنج';
      case 6:
        return 'شش';
      case 7:
        return 'هفت';
      case 8:
        return 'هشت';
      case 9:
        return 'نه';
      case 10:
        return 'ده';
      default:
        return 'بیش از حد';
    }
  }
}
