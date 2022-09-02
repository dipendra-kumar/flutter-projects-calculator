import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  final dynamic color;
  final dynamic textColor;
  final String buttonText;
  final dynamic buttonTapped;

  MyButton({this.color, this.textColor, required this.buttonText, this.buttonTapped});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child:Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
        child:Container(
          color: color,
          child: Center(child: Text(buttonText, style: TextStyle(color: textColor,fontSize: 28),),),
        )
      ),
    )
    );
  }
}
