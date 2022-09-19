extension DateTimeHelper on DateTime {
  String get dateString {
    return '${this.day}/${this.month}/${this.year}';
  }

  String get dateStringWithMonthName {
    Map<int, String> monthMap = {
      1: 'January',
      2: 'February',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December',
    };

    return '${this.day.toString().padLeft(2, '0')} ${monthMap[this.month]} ${this.year}';
  }

  String get dateTimeString {
    return '${this.day.toString().padLeft(2, '0')}/${this.month.toString().padLeft(2, '0')}/${this.year} ${this.hour.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')}';
  }

  String get dateTimeStringWithMonthName {
    Map<int, String> monthNames = {
      1: 'January',
      2: 'February',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December',
    };

    return '${this.day.toString().padLeft(2, '0')} ${monthNames[this.month]} ${this.year} ${this.hour.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')}';
  }

  String get dateTimeStringWithMonthNameAndAmPm {
    Map<int, String> monthNames = {
      1: 'January',
      2: 'February',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December',
    };

    return '${this.day} ${monthNames[this.month]} ${this.year} ${this.hour == 12 ? 12 : this.hour % 12}:${this.minute.toString().padLeft(2, '0')} ${this.hour >= 12 ? 'PM' : 'AM'}';
  }
}
