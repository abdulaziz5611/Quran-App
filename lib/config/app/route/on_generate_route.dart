import 'package:flutter/material.dart';

import 'package:quran_app/config/app/const/page_const.dart';
import 'package:quran_app/config/app/navigation_screen/navigation_screen.dart';
import 'package:quran_app/config/app/splash/splash_page.dart';
import 'package:quran_app/features/home/presentation/pages/home_page.dart';
import 'package:quran_app/features/listen_quran/presentation/pages/main_quran_page.dart';
import 'package:quran_app/features/qibla_direction/presentation/pages/main_qibla_page.dart';
import 'package:quran_app/features/settings/presentation/pages/setting_page.dart';
import 'package:quran_app/features/weather/presentation/pages/main_weather_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    switch (settings.name) {
      case PageConst.splashPage:
        return _builder(const SplashPage());
      case PageConst.navigationPage:
        return _builder(const NavigationScreen());
      case PageConst.homePage:
        return _builder(const HomePage());
      case PageConst.mainQuranPage:
        return _builder(const MainQuranPage());
      case PageConst.mainQiblaPage:
        return _builder(const MainQiblaPage());
      case PageConst.weatherPage:
        return _builder(const MainWeatherPage());
      case PageConst.settingPage:
        return _builder(const SettingPage());
      default:
        return _builder(const _NotFoundPage());
    }
  }

  static MaterialPageRoute _builder(Widget page) =>
      MaterialPageRoute(builder: (_) => page);
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: const Center(child: Text('Page not found')),
    );
  }
}
