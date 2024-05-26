import 'package:flutter_task_1/core/res/media_res.dart';

class PageContent {
  const PageContent({
    required this.image,
    this.subtitle,
    required this.title,
    required this.index,
  });
  const PageContent.getStarted()
      : this(
            title: "Are you ready for\nyour test?",
            subtitle: "Start now by creating your profile and connect!",
            image: MediaRes.getStartedOnboarding,
            index: 0);
  const PageContent.first()
      : this(
            title: "When's your\nbirthday?",
            image: MediaRes.firstOnboarding,
            index: 1);
  const PageContent.second()
      : this(
            title: "Choose your\nnickname",
            image: MediaRes.secondOnboarding,
            index: 2);
  const PageContent.third()
      : this(
            title: "Which gender do\nyou identify as?",
            subtitle: "Your gender helps us find the right\nmatches for you",
            image: MediaRes.thirdOnboarding,
            index: 3);
  const PageContent.fourth()
      : this(
            title: "Add a nice photo\nof yourself",
            image: MediaRes.fourthOnboarding,
            index: 4);

  final String title;
  final String? subtitle;
  final String image;
  final int index;
}
