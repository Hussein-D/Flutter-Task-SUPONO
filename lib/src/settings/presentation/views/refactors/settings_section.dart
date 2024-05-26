import 'package:flutter/material.dart';
import 'package:flutter_task_1/core/constants/colors.dart';
import 'package:flutter_task_1/core/extensions/context_ext.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection(
      {super.key, required this.label, required this.widgets});
  final String label;
  final List<Widget> widgets;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.labelSmall
                ?.copyWith(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colours.settingsItemBackgroundColor,
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return widgets[index];
                  },
                  separatorBuilder: (context, index) {
                    if (index != widgets.length - 1) {
                      return const Divider();
                    } else {
                      return const SizedBox();
                    }
                  },
                  itemCount: widgets.length),
            ),
          )
        ],
      ),
    );
  }
}
