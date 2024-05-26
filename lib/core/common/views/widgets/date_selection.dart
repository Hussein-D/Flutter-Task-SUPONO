import 'package:flutter/material.dart';
import 'package:flutter_task_1/core/constants/colors.dart';
import 'package:flutter_task_1/core/extensions/context_ext.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.label,
      required this.controller,
      required this.flex,
      required this.validator,
      required this.textInputType});
  final String? label;
  final TextEditingController controller;
  final int? flex;
  final TextInputType textInputType;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex ?? 1,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              validator: validator,
              style: context.textTheme.bodyMedium,
              cursorColor: Colors.white,
              textAlign: TextAlign.center,
              keyboardType: textInputType,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colours.greyColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colours.greyColor))),
            ),
            if (label != null)
              const SizedBox(
                height: 10,
              ),
            if (label != null)
              Text(
                label!,
                style: context.textTheme.labelMedium,
              )
          ],
        ),
      ),
    );
  }
}
