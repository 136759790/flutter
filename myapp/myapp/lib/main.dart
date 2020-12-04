import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/routes/home.dart';
import 'package:myapp/routes/login.dart';
import 'package:myapp/theme/yellowTheme.dart';
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
        ChangeNotifierProvider(create: (context) => UserNotifier()),
        ChangeNotifierProvider(create: (context) => ProjectModel()),
        ChangeNotifierProvider(create: (context) => ShopModel()),
      ],
      child: Consumer<UserNotifier>(
        builder: (context, user, child) {
          return MaterialApp(
            title: '小店',
            navigatorKey: Global.navigatorKey,
            home: HomeRoute(),
            theme: yellowTheme,
            localizationsDelegates: [
              PickerLocalizationsDelegate.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: [
              const Locale('zh', 'CH'),
              const Locale('en', 'US'),
            ],
            onGenerateRoute: _onGenerateRoute,
          );
        },
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    String routeName = settings.name;
    print("Open page: $routeName");
    // Check permissions
    switch (routeName) {
      case "home":
        return MaterialPageRoute(builder: (context) {
          return HomeRoute();
        });
      case "login":
        return MaterialPageRoute(builder: (context) {
          return LoginRoute();
        });
      default:
        return MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
              body: Center(
            child: Text("Page not found"),
          ));
        });
    }
  }
}
