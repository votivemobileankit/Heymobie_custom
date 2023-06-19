bool isEnteredDateValid(String dayText, String monthText, String yearText) {
  bool isValid = false;
  int day = dayText.length > 0 ? int.parse(dayText) : 1;
  int month = monthText.length > 0 ? int.parse(monthText) : 1;
  int year = yearText.length > 0 ? int.parse(yearText) : 2000;
  day = day == 0 ? 1 : day;
  month = month == 0 ? 1 : month;
  String dateStr = getFormattedStrForDate(day, month, year);
  DateTime? parsedDate = DateTime.tryParse(dateStr);
  if (parsedDate != null) {
    String parsedDateStr = getFormattedStrForDate(
        parsedDate.day, parsedDate.month, parsedDate.year);
    if (dateStr == parsedDateStr &&
        isYearValid(year) &&
        isMonthEntryValid(monthText) &&
        isDayEntryValid(dayText)) {
      isValid = true;
    }
    // }
  }
  return isValid;
}

bool isMonthEntryValid(String monthText) {
  bool isValid = false;
  if (monthText.length > 0) {
    int month = int.parse(monthText);
    if ((monthText.length == 1 && (month == 0 || month == 1)) ||
        (monthText.length == 2 && monthText != '00')) {
      isValid = true;
    }
  } else {
    isValid = true;
  }
  return isValid;
}

bool isDayEntryValid(String dayText) {
  bool isValid = false;
  if (dayText.length > 0) {
    int day = int.parse(dayText);
    if ((dayText.length == 1 && (day >= 0 && day <= 3)) ||
        (dayText.length == 2 && dayText != '00')) {
      isValid = true;
    }
  } else {
    isValid = true;
  }
  return isValid;
}

bool isYearValid(int year) {
  int maxYear = DateTime.now().year;
  int minYear = maxYear - 100;

  return year == 1 ||
      year == 2 ||
      year == 19 ||
      year == 20 ||
      (year >= minYear / 10 && year <= maxYear / 10) ||
      (year >= minYear && year <= maxYear);
}

int calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

String getFormattedStrForDate(int day, int month, int year) {
  String dayStr = '$day'.padLeft(2, '0');
  String monthStr = '$month'.padLeft(2, '0');
  String yearStr = '$year'.padLeft(4, '0');
  return '$yearStr-$monthStr-$dayStr';
}
