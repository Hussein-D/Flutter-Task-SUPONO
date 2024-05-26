import 'package:flutter/material.dart';
import 'package:flutter_task_1/core/extensions/context_ext.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      required this.onTapParam,
      required this.title,
      this.subtitle});
  final Function onTapParam;
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapParam();
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: subtitle != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.labelMedium
                  ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: context.textTheme.labelMedium
                    ?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
              )
          ],
        ),
      ),
    );
  }
}
