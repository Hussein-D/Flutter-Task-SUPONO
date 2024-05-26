import 'package:flutter/material.dart';
import 'package:flutter_task_1/core/constants/colors.dart';
import 'package:flutter_task_1/core/extensions/context_ext.dart';

class PhotoRule extends StatelessWidget {
  const PhotoRule({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(
            Icons.check,
            color: Colours.greyColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            label,
            style: context.textTheme.labelMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
