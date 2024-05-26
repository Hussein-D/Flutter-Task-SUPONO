import 'package:flutter/material.dart';
import 'package:flutter_task_1/core/extensions/context_ext.dart';
import 'package:flutter_task_1/core/res/media_res.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: Image.asset(MediaRes.pageUnderConstruction),
      ),
    );
  }
}
