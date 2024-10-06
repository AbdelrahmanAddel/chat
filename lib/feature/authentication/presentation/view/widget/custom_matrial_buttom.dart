import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.color = const Color.fromARGB(255, 173, 12, 0),
    this.textColor = Colors.white,
    this.minWidth = double.infinity,
  });

  final Function()? onPressed;
  final String buttonText;
  final Color color;
  final Color textColor;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const StadiumBorder(),
      minWidth: minWidth,
      color: color,
      textColor: textColor,
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 16), 
      ),
    );
  }
}
