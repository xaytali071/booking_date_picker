import 'package:booking_date_picker/controller/calendar_provider.dart';
import 'package:booking_date_picker/view/widgets/calendar_item.dart';
import 'package:booking_date_picker/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalendarView extends StatefulWidget {
  final VoidCallback onTap;
  final ValueChanged? onChanged;
  final CustomButtonStyle? buttonStyle;
  final Color selectColor;
  final TextStyle weekDayStyle;
  final Icon seekIcon;
  final Icon previousIcon;
  final double? height;
  final double width;
  final TextStyle monthStyle;
  final String locale;
  const CalendarView({
    super.key,
    required this.onTap,
    this.onChanged,
    this.buttonStyle,
    this.selectColor = Colors.green,
    this.weekDayStyle = const TextStyle(fontWeight: FontWeight.bold),
     this.seekIcon=const Icon(Icons.arrow_back_ios),
     this.previousIcon=const Icon(Icons.arrow_forward_ios_sharp),
     this.height,
     this.width=400,
    this.monthStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.locale="uz_UZ",
  });

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  int year = DateTime.now().year;
  int month = DateTime.now().month;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalendarProvider>().buildCalendar(year, month);
      getWeekDaysName();
    });
    super.initState();
  }

  List<String> weekDays = [];

  getWeekDaysName() {
    for (int i = 1; i <= 7; i++) {
      initializeDateFormatting(widget.locale, null);
      DateTime date = DateTime(year, month, i + 2);
      weekDays.add(DateFormat.E().format(date),);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CalendarProvider>();
    final event = context.read<CalendarProvider>();
    return Provider<CalendarProvider>(
      create: (_) => CalendarProvider(),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
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
                      event
                        ..seekMonth()
                        ..getMonthName();
                    },
                    icon: widget.seekIcon,
                  ),
                  Text(state.monthName, style: widget.monthStyle),
                  IconButton(
                    onPressed: () {
                      event
                        ..nextMonth()
                        ..getMonthName();
                    },
                    icon: widget.previousIcon,
                  ),
                  SizedBox(width: 20,),
                  Text(
                    state.selectedDate.year.toString(),
                    style: widget.monthStyle,
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < weekDays.length; i++)
                    Text(
                      weekDays[i],
                      style: widget.weekDayStyle,
                    ),
                ],
              ),
        SizedBox(height: 10,),
              GridView.builder(
                itemCount: state.days.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                ),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return state.days[index].toString().isEmpty
                      ? SizedBox.shrink()
                      : CalendarItem(
                        onTap: () {
                          widget.onChanged?.call(
                            "${state.selectDateDay}-${state.selectDateMonth}",
                          );
                          event.selectDay(state.days[index], state.monthName);
                        },
                        day: state.days[index].toString(),
                        isSelectDate:
                            state.selectDateDay == state.days[index] &&
                            state.selectDateMonth == state.monthName,
                        isThisDay:
                            state.days[index] == DateTime.now().day &&
                            state.selectedDate.month == DateTime.now().month &&
                            state.selectedDate.year == DateTime.now().year,
                      );
                },
              ),
              SizedBox(height: 10,),
              CustomButton(
                buttonStyle: widget.buttonStyle ?? CustomButtonStyle(),
                onTap: widget.onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
