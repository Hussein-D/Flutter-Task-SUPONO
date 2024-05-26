import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_1/core/common/views/widgets/button_with_opacity.dart';
import 'package:flutter_task_1/core/common/views/widgets/date_selection.dart';
import 'package:flutter_task_1/core/common/views/widgets/filled_button.dart';
import 'package:flutter_task_1/core/constants/colors.dart';
import 'package:flutter_task_1/core/enums/gender_enum.dart';
import 'package:flutter_task_1/core/extensions/context_ext.dart';
import 'package:flutter_task_1/src/home/presentation/views/home_screen.dart';
import 'package:flutter_task_1/src/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter_task_1/src/onboarding/presentation/views/page_content.dart';
import 'package:flutter_task_1/src/onboarding/presentation/views/widgets/photo_rule.dart';
import 'package:image_picker/image_picker.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const route = "/";
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final GlobalKey<FormState> _dateFormKey = GlobalKey();
  final GlobalKey<FormState> _nicknameFormKey = GlobalKey();
  Gender? _genderChosen;
  PageContent pageContent = const PageContent.getStarted();
  int index = 0;
  @override
  void initState() {
    super.initState();
    context.onBoardingBloc.add(CheckIfUserFirstTimeEvent());
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: ((context, state) {
        if ((state is UserChecked && !state.isFirstTime) ||
            state is UserCached) {
          Navigator.pushReplacementNamed(context, HomeScreen.route);
          context.onBoardingBloc.close();
        }
      }),
      builder: (context, state) {
        if (state is UserChecked && state.isFirstTime) {
          return StatefulBuilder(builder: (_, refresh) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Scaffold(
                  floatingActionButton: index == 1 || index == 2
                      ? FloatingActionButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (index == 1) {
                              final result =
                                  _dateFormKey.currentState?.validate();
                              if (result ?? false) {
                                refresh(() {
                                  pageContent = const PageContent.second();
                                  index = pageContent.index;
                                });
                              }
                            } else if (index == 2) {
                              final result =
                                  _nicknameFormKey.currentState?.validate();
                              if (result ?? false) {
                                refresh(() {
                                  pageContent = const PageContent.third();
                                  index = pageContent.index;
                                });
                              }
                            }
                          },
                          backgroundColor: Colors.white,
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                        )
                      : null,
                  body: Container(
                    height: context.height,
                    width: context.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(pageContent.image),
                            fit: BoxFit.cover)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0).copyWith(
                          bottom: 0,
                          left: index == 0 ? 0 : 16,
                          right: index == 0 ? 0 : 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: index == 0
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          if (index == 0)
                            Container(
                              height: 250,
                              width: context.width,
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                              child: Column(
                                children: [
                                  Text(
                                    pageContent.title,
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    pageContent.subtitle ?? "",
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.labelLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ButtonFilled(
                                      onPressed: () {
                                        refresh(() {
                                          pageContent =
                                              const PageContent.first();
                                          index = pageContent.index;
                                        });
                                      },
                                      label: "Continue")
                                ],
                              ),
                            ),
                          if (index != 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (index == 1) {
                                        refresh(() {
                                          pageContent =
                                              const PageContent.getStarted();
                                          index = pageContent.index;
                                        });
                                      } else if (index == 2) {
                                        refresh(() {
                                          pageContent =
                                              const PageContent.first();
                                          index = pageContent.index;
                                        });
                                      } else if (index == 3) {
                                        refresh(() {
                                          pageContent =
                                              const PageContent.second();
                                          index = pageContent.index;
                                        });
                                      } else if (index == 4) {
                                        refresh(() {
                                          pageContent =
                                              const PageContent.third();
                                          index = pageContent.index;
                                        });
                                      }
                                    },
                                    icon: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1.5,
                                              color: Colours.greyColor,
                                            ),
                                            shape: BoxShape.circle),
                                        child: index != 1
                                            ? const Icon(
                                                Icons.arrow_back_ios_new,
                                                size: 16,
                                                color: Colours.greyColor,
                                              )
                                            : const Icon(
                                                Icons.close,
                                                size: 16,
                                                color: Colours.greyColor,
                                              ))),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.5,
                                            color: Colours.greyColor,
                                          ),
                                          shape: BoxShape.circle),
                                      child: Text(
                                        "${index * 25}%",
                                        style: context.textTheme.labelSmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    CircularProgressIndicator(
                                      value: index * 25 / 100,
                                      strokeWidth: 2,
                                      color: Colors.white,
                                      strokeCap: StrokeCap.round,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          if (index != 0)
                            const SizedBox(
                              height: 50,
                            ),
                          if (index != 0)
                            Text(
                              pageContent.title,
                              style: context.textTheme.bodyLarge,
                            ),
                          if (pageContent.subtitle != null && index != 0)
                            const SizedBox(
                              height: 10,
                            ),
                          if (pageContent.subtitle != null && index != 0)
                            Text(
                              pageContent.subtitle!,
                              style: context.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                          if (index != 0)
                            const SizedBox(
                              height: 50,
                            ),
                          index == 1
                              ? Form(
                                  key: _dateFormKey,
                                  child: Row(
                                    children: [
                                      AppTextField(
                                          label: "Day",
                                          flex: 1,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                (int.parse(value)) < 1 ||
                                                (int.parse(value)) > 31) {
                                              return "Please enter a valid day";
                                            }
                                            return null;
                                          },
                                          textInputType: TextInputType.number,
                                          controller: _dayController),
                                      AppTextField(
                                          label: "Month",
                                          flex: 1,
                                          textInputType: TextInputType.number,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                (int.parse(value)) < 1 ||
                                                (int.parse(value)) > 12) {
                                              return "Please enter a valid month";
                                            }
                                            return null;
                                          },
                                          controller: _monthController),
                                      AppTextField(
                                          label: "Year",
                                          flex: 2,
                                          textInputType: TextInputType.number,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                (int.parse(value)) < 1950 ||
                                                (int.parse(value)) > 2022) {
                                              return "Please enter a valid year";
                                            }
                                            return null;
                                          },
                                          controller: _yearController),
                                    ],
                                  ))
                              : index == 2
                                  ? Form(
                                      key: _nicknameFormKey,
                                      child: AppTextField(
                                          label: null,
                                          flex: 1,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter a valid nickname";
                                            }
                                            return null;
                                          },
                                          textInputType: TextInputType.text,
                                          controller: _nicknameController))
                                  : Container(),
                          if (index == 3) ...[
                            ButtonWithOpacity(
                              label: "Male",
                              onPressed: () {
                                _genderChosen = Gender.MALE;
                                refresh(() {
                                  pageContent = const PageContent.fourth();
                                  index = pageContent.index;
                                });
                              },
                            ),
                            ButtonWithOpacity(
                              label: "Female",
                              onPressed: () {
                                _genderChosen = Gender.FEMALE;
                                refresh(() {
                                  pageContent = const PageContent.fourth();
                                  index = pageContent.index;
                                });
                              },
                            ),
                            ButtonWithOpacity(
                              label: "Other",
                              onPressed: () {
                                _genderChosen = Gender.OTHER;
                                refresh(() {
                                  pageContent = const PageContent.fourth();
                                  index = pageContent.index;
                                });
                              },
                            ),
                          ],
                          if (index == 4) ...[
                            ButtonFilled(
                                onPressed: () async {
                                  final cacheUser = context.onBoardingBloc;
                                  XFile? image = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  if (image != null) {
                                    cacheUser.add(CacheUserEvent(
                                        birthdate: DateTime.parse(
                                            "${_yearController.text}-${_monthController.text}-${_dayController.text}"),
                                        gender: _genderChosen ?? Gender.MALE,
                                        nickname: _nicknameController.text,
                                        image: image.path));
                                  }
                                },
                                label: "Take your first photo"),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 1.5, color: Colours.greyColor)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Make sure that your image",
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const PhotoRule(
                                      label: "Shows your face clearly"),
                                  const PhotoRule(
                                      label: "Yourself only, no group pic"),
                                  const PhotoRule(
                                      label:
                                          "No fake pic, object or someone else")
                                ],
                              ),
                            )
                          ]
                        ],
                      ),
                    ),
                  )),
            );
          });
        } else if (state is OnboardingError) {
          return const Scaffold(
            body: Center(
              child: Text("An error has occured , please try again later."),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
