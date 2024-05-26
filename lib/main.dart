import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task_1/core/app/providers/app_provider.dart';
import 'package:flutter_task_1/core/services/dependency_inversion.dart';
import 'package:flutter_task_1/core/services/routes.dart';
import 'package:flutter_task_1/core/theme/app_theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: "Camera App",
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRouter,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
