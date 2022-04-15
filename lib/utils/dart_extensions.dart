extension ListExtensions on List {
  bool isSameWith(List other) {
    if (this.length != other.length) {
      return false;
    }
    for (int i = 0; i < this.length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }
}

extension StringExtension on String {
  String initCap() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String removeUnicode() {
    return this.replaceAll("&#038;", "&").replaceAll("&#8211;", "-");
  }
}

extension DateWeekExtensions on DateTime {
  int get weekOfYear {
    final woy = ((ordinalDate - weekday + 10) ~/ 7);

    if (woy == 0) {
      // The 28th of December is always in the last week of the year
      return DateTime(year - 1, 12, 28).weekOfYear;
    }

    if (woy == 53 &&
        DateTime(year, 1, 1).weekday != DateTime.thursday &&
        DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return 1;
    }

    return woy;
  }

  int get ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
  }

  bool get isLeapYear {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month
        && this.day == other.day;
  }
}

extension DoublePrecision on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}