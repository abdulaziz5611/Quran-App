import 'package:flutter/material.dart';

import 'package:quran_app/config/app/const/page_const.dart';
import 'package:quran_app/config/app/route/on_generate_route.dart';
import 'package:quran_app/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran App',
      onGenerateRoute: OnGenerateRoute.route,
      initialRoute: PageConst.splashPage,
    );
  }
}
