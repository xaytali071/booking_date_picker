import 'package:flutter/material.dart';

class CalendarItem extends StatelessWidget {
  final String day;
  final bool? isThisDay;
  final VoidCallback? onTap;
  final bool? isSelectDate;
  final Color? selectItemColor;
  final Color thisDayItemColor;
  final Color itemColor;
  final Color itemBorderColor;
  final double borderRadius;

  const CalendarItem({
    super.key,
    required this.day,
    this.isThisDay,
    this.onTap,
    this.isSelectDate,
    this.selectItemColor = Colors.green,
    this.thisDayItemColor = Colors.black,
    this.itemColor = Colors.white,
    this.itemBorderColor = Colors.grey,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color:
              (isSelectDate ?? false)
                  ? selectItemColor
                  : (isThisDay ?? false)
                  ? thisDayItemColor
                  : itemColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color:
                (isSelectDate ?? false) ? Colors.transparent : itemBorderColor,
          ),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: (isThisDay ?? false) ? Colors.white : (isSelectDate ?? false) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
