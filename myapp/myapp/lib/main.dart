import 'package:flutter/material.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/main/accounts.dart';
import 'package:myapp/main/bottomNav.dart';
import 'package:myapp/main/btnAdd.dart';
import 'package:myapp/main/drawer.dart';
import 'package:myapp/main/mainAccount.dart';
import 'package:myapp/routes/home.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
              "login": (context) => HomeRoute(),
              "theme": (context) => HomeRoute(),
              "language": (context) => HomeRoute(),
            },
          );
        },
      ),
    );
  }
}
