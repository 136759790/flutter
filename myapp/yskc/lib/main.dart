import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yskc/common/global.dart';
import 'package:yskc/common/notifier.dart';
import 'package:yskc/routes/home.dart';
import 'package:yskc/routes/login.dart';
import 'package:provider/provider.dart';

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((value) => runApp(MyApp()));
  cameras = await availableCameras();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserNotifier()),
        ChangeNotifierProvider.value(value: ProjectModel()),
      ],
      child: Consumer<UserNotifier>(
        builder: (context, user, child) {
          return MaterialApp(
            title: '小店',
            home: HomeRoute(),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: [
              const Locale('zh', 'CN'),
              const Locale('en', 'US'),
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
