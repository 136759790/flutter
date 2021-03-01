import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yskc/common/global.dart';
import 'package:yskc/common/notifier.dart';
import 'package:yskc/routes/error.dart';
import 'package:yskc/routes/home.dart';
import 'package:yskc/routes/login.dart';
import 'package:yskc/theme/theme_blue.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((value) => runApp(MyApp()));
  cameras = await availableCameras();
}

List<CameraDescription> cameras = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserNotifier()),
      ],
      child: Consumer<UserNotifier>(
        builder: (context, user, child) {
          return RefreshConfiguration(
            headerBuilder: () => WaterDropHeader(), // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
            footerBuilder: () => ClassicFooter(), // 配置默认底部指示器
            headerTriggerDistance: 80.0, // 头部触发刷新的越界距离
            springDescription: SpringDescription(stiffness: 170, damping: 16, mass: 1.9), // 自定义回弹动画,三个属性值意义请查询flutter api
            maxOverScrollExtent: 100, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
            maxUnderScrollExtent: 0, // 底部最大可以拖动的范围
            enableScrollWhenRefreshCompleted: true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
            enableLoadingWhenFailed: true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
            hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
            enableBallisticLoad: true,
            child: MaterialApp(
              title: '元氏卡车',
              navigatorKey: Global.navigatorKey,
              home: HomeRoute(),
              theme: Theme_blue,
              localizationsDelegates: [
                RefreshLocalizations.delegate,
                PickerLocalizationsDelegate.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              supportedLocales: [
                const Locale('zh', 'CH'),
                const Locale('en', 'US'),
              ],
              onGenerateRoute: _onGenerateRoute,
            ),
          );
        },
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    String routeName = settings.name;
    print("Open page: $routeName");
    switch (routeName) {
      case "home":
        return MaterialPageRoute(builder: (context) => HomeRoute());
        break;
      case "login":
        return MaterialPageRoute(builder: (context) => LoginRoute());
        break;
      case "error":
        return MaterialPageRoute(builder: (context) => ErrorRoute());
        break;
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
