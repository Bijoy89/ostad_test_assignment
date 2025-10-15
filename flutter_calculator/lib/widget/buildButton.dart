import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  final String text;
  final Color ? color;
  final Color textColor;
  final VoidCallback onClick;
  final double flex;
  final double fontSize;

   const BuildButton({
    super.key,
    required this.text,
    required this.color,
     this.textColor=Colors.white,
    required this.onClick,
     this.flex=1,
     this.fontSize=30,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 80,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
            ),
            onPressed:onClick,
            child: Text(
              text,
            style: TextStyle(
              color: textColor,
              fontSize: text.length > 1 ? 24 : fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          ),
        ),
      ),
    );
  }
}
