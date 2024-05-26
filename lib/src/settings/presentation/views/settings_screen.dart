import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_1/core/app/providers/app_provider.dart';
import 'package:flutter_task_1/core/constants/colors.dart';
import 'package:flutter_task_1/core/extensions/context_ext.dart';
import 'package:flutter_task_1/src/settings/presentation/views/refactors/settings_item.dart';
import 'package:flutter_task_1/src/settings/presentation/views/refactors/settings_section.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const route = "/settings";
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colours.greyColor,
                              ),
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 16,
                            color: Colours.greyColor,
                          )))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<AppProvider>(builder: (context, value, child) {
                if (!(value.user?.subscribed ?? false)) {
                  return SettingsSection(label: "Settings", widgets: [
                    SettingsItem(
                        onTapParam: () async {
                          final updateProvider = context.appProvider;
                          final result = await showDialog(
                              context: context,
                              builder: (context) {
                                if (Platform.isAndroid) {
                                  return AlertDialog(
                                    title: Text(
                                      'Unlock Ad-Free Experience',
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    content: Text(
                                      'Subscribe now to remove ads and enjoy a seamless experience!',
                                      style: context.textTheme.labelLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: context.textTheme.labelMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context, {"unlock-app": true});
                                          },
                                          child: Text(
                                            "Proceed",
                                            style: context.textTheme.labelMedium
                                                ?.copyWith(color: Colors.black),
                                          ))
                                    ],
                                  );
                                }
                                if (Platform.isIOS) {
                                  return CupertinoAlertDialog(
                                    title: Text(
                                      'Unlock Ad-Free Experience',
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    content: Text(
                                      'Subscribe now to remove ads and enjoy a seamless experience!',
                                      style: context.textTheme.labelLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text(
                                          "Cancel",
                                          style: context.textTheme.labelMedium
                                              ?.copyWith(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.pop(
                                                context, {"unlock-app": true});
                                          },
                                          child: Text(
                                            "Proceed",
                                            style: context.textTheme.labelMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              });
                          if (result != null) {
                            updateProvider.setShowUnlockApp(true);
                          }
                        },
                        title: "Unlock App"),
                    const SettingsItem(
                        onTapParam: showRating, title: "Rate Us"),
                  ]);
                } else {
                  return const SettingsSection(label: "Settings", widgets: [
                    SettingsItem(onTapParam: showRating, title: "Rate Us"),
                  ]);
                }
              }),
              SettingsSection(label: "My Account", widgets: [
                SettingsItem(
                  onTapParam: () {},
                  title: "Username",
                  subtitle: context.appProvider.user?.nickname ?? "nickname",
                ),
                SettingsItem(
                  onTapParam: () {},
                  title: "Birthday",
                  subtitle: DateFormat('d MMM y').format(
                      context.appProvider.user?.birthdate ?? DateTime.now()),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> showRating() async {
  final InAppReview inAppReview = InAppReview.instance;
  try {
    final available = await inAppReview.isAvailable();
    if (available) {
      await inAppReview.requestReview();
    } else {
      inAppReview.openStoreListing(appStoreId: "com.example.flutter_task_1");
    }
    return true;
  } catch (e) {
    return false;
  }
}
