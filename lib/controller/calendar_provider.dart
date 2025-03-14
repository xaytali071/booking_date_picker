import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CalendarProvider extends ChangeNotifier {
  static int year = DateTime.now().year;
  static int month = DateTime.now().month;
  List<String> weekDays = [];
  String thisDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  String monthName = DateFormat.MMMM().format(DateTime(year, month));
  List days = [];

  int? selectDateDay;
  String? selectDateMonth;


  getMonthName(String locale) {
    monthName = DateFormat.MMMM(locale).format(
      DateTime(selectedDate.year, selectedDate.month),
    );
    notifyListeners();
  }

  buildCalendar(int year, int month) {
    days.clear();
    notifyListeners();
    int firstWeekday = DateTime(year, month, 1).weekday;
    int daysInMonth = DateTime(year, month + 1, 0).day;
    for (int i = 1; i < firstWeekday; i++) {
      days.add("");
    }
    for (int day = 1; day <= daysInMonth; day++) {
      days.add(day);
    }
    notifyListeners();
  }

  nextMonth() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
    buildCalendar(selectedDate.year, selectedDate.month);
    notifyListeners();
  }

  seekMonth() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, 1);
    buildCalendar(selectedDate.year, selectedDate.month);
    notifyListeners();
  }

  selectDay(int dateDay, String dateMonth) {
    if (dateDay == selectDateDay && dateMonth == selectDateMonth) {
      selectDateDay = null;
      selectDateMonth = null;
      notifyListeners();
    } else {
      selectDateDay = dateDay;
      selectDateMonth = dateMonth;
      notifyListeners();
    }
  }
}
