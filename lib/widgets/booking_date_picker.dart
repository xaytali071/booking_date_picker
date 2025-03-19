import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'calendar_item.dart';
import 'custom_button.dart';

class BookingDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onChanged;
  final CustomButtonStyle? buttonStyle;
  final TextStyle? weekDayStyle;
  final Icon seekIcon;
  final Icon previousIcon;
  final double? height;
  final double width;
  final TextStyle? monthStyle;
  final String locale;
  final Color selectItemColor;
  final Color itemColor;
  final Color itemBorderColor;
  final double itemRadius;
  final double borderRadius;

  const BookingDatePicker({
    super.key,
    required this.onChanged,
    this.buttonStyle,
    this.weekDayStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.seekIcon = const Icon(Icons.arrow_back_ios),
    this.previousIcon = const Icon(Icons.arrow_forward_ios_sharp),
    this.height,
    this.width = 400,
    this.monthStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.locale = "en_EN",
    this.selectItemColor = Colors.green,
    this.itemColor = Colors.white,
    this.itemBorderColor = Colors.grey,
    this.itemRadius = 12,
    this.borderRadius = 12,
  });

  @override
  State<BookingDatePicker> createState() => _BookingDatePickerState();
}

class _BookingDatePickerState extends State<BookingDatePicker> {
  static int year = DateTime.now().year;
  static int monthNumber = DateTime.now().month;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeDateFormatting('en_EN', null);
      buildCalendar(DateTime.now().year, DateTime.now().month);
      getMonthName(widget.locale);
      getWeekDaysName();
    });
    super.initState();
  }


  List<String> weekDays = [];

  getWeekDaysName() {
    for (int i = 1; i <= 7; i++) {
      DateTime date = DateTime(year, monthNumber, i + 2);
      weekDays.add(DateFormat.E(widget.locale).format(date));
    }
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    seekMonth();
                    getMonthName(widget.locale);
                  },
                  icon: widget.seekIcon,
                ),
                Text(
                  monthName,
                  style:
                      widget.monthStyle ??
                      TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    nextMonth();
                    getMonthName(widget.locale);

                  },
                  icon: widget.previousIcon,
                ),
                SizedBox(width: 20),
                Text(
                  selectedDate.year.toString(),
                  style:
                      widget.monthStyle ??
                      TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < weekDays.length; i++)
                  Text(weekDays[i], style: widget.weekDayStyle ?? TextStyle()),
              ],
            ),
            SizedBox(height: 10),
            GridView.builder(
              itemCount: days.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return days[index].toString().isEmpty
                    ? SizedBox.shrink()
                    : CalendarItem(
                      itemColor: widget.itemColor,
                      itemBorderColor: widget.itemBorderColor,
                      selectItemColor: widget.selectItemColor,
                      borderRadius: widget.itemRadius,
                      onTap: () {
                        selectDay(days[index], monthNumber, selectedDate.year);
                      },
                      day: days[index].toString(),
                      isSelectDate:
                          selectDateDay == days[index] &&
                          selectDateMonth == monthNumber &&
                          selectDateYear == selectedDate.year,

                      isThisDay:
                          days[index] == DateTime.now().day &&
                          selectedDate.month == DateTime.now().month &&
                          selectedDate.year == DateTime.now().year,
                    );
              },
            ),
            SizedBox(height: 10),
            CustomButton(
              buttonStyle: widget.buttonStyle ?? CustomButtonStyle(),
              onTap: () {
                widget.onChanged.call(
                  DateTime(
                    selectDateYear ?? 0,
                    selectDateMonth ?? 0,
                    selectDateDay ?? 0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String monthName = DateFormat.MMMM().format(DateTime(year, monthNumber));
  List days = [];

  int? selectDateDay;
  int? selectDateMonth;
  int? selectDateYear;

  getMonthName(String locale) {
    monthName = DateFormat.MMMM(
      locale,
    ).format(DateTime(selectedDate.year, selectedDate.month));
    setState(() {});
  }

  buildCalendar(int year, int month) {
    days.clear();
    int firstWeekday = DateTime(year, month, 1).weekday;
    int daysInMonth = DateTime(year, month + 1, 0).day;
    for (int i = 1; i < firstWeekday; i++) {
      days.add("");
    }
    for (int day = 1; day <= daysInMonth; day++) {
      days.add(day);
    }
    setState(() {});
  }

  nextMonth() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
    buildCalendar(selectedDate.year, selectedDate.month);
    monthNumber = selectedDate.month;
    setState(() {});
  }

  seekMonth() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, 1);
    buildCalendar(selectedDate.year, selectedDate.month);
    monthNumber = selectedDate.month;
    setState(() {});
  }

  selectDay(int dateDay, int dateMonth, int dateYear) {
    if (dateDay == selectDateDay &&
        dateMonth == selectDateMonth &&
        dateYear == selectDateYear) {
      selectDateDay = null;
      selectDateMonth = null;
      selectDateYear = null;
    } else {
      selectDateDay = dateDay;
      selectDateMonth = dateMonth;
      selectDateYear = dateYear;
    }
    setState(() {});
  }
}
