import 'package:booking_date_picker/view/widgets/button_effect.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
final CustomButtonStyle buttonStyle;
final VoidCallback onTap;

  const CustomButton({
    super.key,
   required this.buttonStyle,
    required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: buttonStyle.height,
          width: buttonStyle.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: buttonStyle.color,
          ),
          child: Center(child: Text(buttonStyle.title, style: buttonStyle.textStyle)),
        ),
      ),
    );
  }
}

class CustomButtonStyle{
  final String title;
  final Color color;
  final double? width;
  final double height;
  final TextStyle textStyle;

  CustomButtonStyle({
    this.title = "Select",
    this.color = Colors.black,
    this.width,
    this.height = 45,
    this.textStyle = const TextStyle(color: Colors.white),
  });
}
