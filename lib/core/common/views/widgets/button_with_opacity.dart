import 'package:flutter/material.dart';
import 'package:flutter_task_1/core/constants/colors.dart';
import 'package:flutter_task_1/core/extensions/context_ext.dart';

class ButtonWithOpacity extends StatelessWidget {
  const ButtonWithOpacity({super.key, this.onPressed, required this.label});
  final Function? onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
          onPressed: () {
            onPressed!();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.4),
            elevation: 5,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colours.greyColor),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          child: Text(
            label,
            style:
                context.textTheme.bodyLarge?.copyWith(fontSize: 23),
          )),
    );
  }
}
