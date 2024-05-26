import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task_1/core/app/providers/app_provider.dart';
import 'package:flutter_task_1/core/constants/colors.dart';
import 'package:flutter_task_1/core/extensions/context_ext.dart';
import 'package:flutter_task_1/core/res/svg_icons.dart';
import 'package:flutter_task_1/src/home/presentation/bloc/home_screen_bloc.dart';
import 'package:flutter_task_1/src/home/presentation/views/ad_banner_widget.dart';
import 'package:flutter_task_1/src/settings/presentation/views/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const route = "/home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> onRefresh() async {
    context.read<HomeScreenBloc>().add(LoadHomeScreenEvent());
  }

  @override
  void initState() {
    super.initState();
    context.homeBloc.add(LoadHomeScreenEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
      if (state is HomeScreenLoaded) {
        return Scaffold(
          bottomNavigationBar:
              !(context.watch<AppProvider>().user?.subscribed ?? false)
                  ? Container(
                      height: 80,
                      color: Colors.black,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const AdBanner(),
                          Align(
                            alignment: Alignment.topRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    height: 22,
                                    width: 72,
                                    padding: const EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : null,
          body: Container(
            height: context.height,
            width: context.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(state.user.image)),
                    fit: BoxFit.cover)),
            child: Container(
              padding: const EdgeInsets.all(16).copyWith(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SettingsScreen.route);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                                border: Border.all(
                                  color: Colours.greyishWhite,
                                ),
                                shape: BoxShape.circle),
                            child: SvgPicture.string(
                              SVGIcons.settingsIcon,
                              color: Colours.greyishWhite,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (state is HomeScreenError) {
        RefreshIndicator.adaptive(
          onRefresh: onRefresh,
          child: const Center(
            child: Text("An error has occured , please refresh the page"),
          ),
        );
      }
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }, listener: (context, state) {
      if (state is HomeScreenLoaded) {
        print("state user : ${state.user}");
        print("state user image: ${state.user.image}");
        context.appProvider.init(state.user);
      }
    });
  }
}
