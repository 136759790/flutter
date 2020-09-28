import 'package:flutter/material.dart';
import 'package:myapp/common/http.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/routes/home.dart';
import 'package:myapp/routes/login.dart';
import 'package:provider/provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  Global.init().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (context, themeModel, localeModel, child) {
          return MaterialApp(
            title: '小店',
            theme: ThemeData(
              primarySwatch: themeModel.theme,
            ),
            home: HomeRoute(),
            locale: localeModel.getLocale(),
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('zh', 'CN'),
            ],
            routes: {
              "login": (context) => LoginRoute(),
              "home": (context) => HomeRoute(),
              "language": (context) => HomeRoute(),
            },
          );
        },
      ),
    );
  }
}
