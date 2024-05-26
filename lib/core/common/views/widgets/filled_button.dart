import 'package:flutter/material.dart';
import 'package:flutter_task_1/core/extensions/context_ext.dart';

class ButtonFilled extends StatelessWidget {
  const ButtonFilled({super.key, required this.onPressed, required this.label});
  final Function onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: ElevatedButton(
          onPressed: () {
            onPressed();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          child: Text(
            label,
            style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black),
          )),
    );
  }
}
