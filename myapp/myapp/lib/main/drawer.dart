import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/views/hair/shop_list.dart';
import 'package:myapp/views/scan/scan.dart';
import 'package:myapp/views/setting/setting.dart';
import 'package:myapp/widgets/switch_project.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawerState();
}

class DrawerState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserNotifier>(context).user.toString());
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              '${Provider.of<UserNotifier>(context).user.name}',
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              '136759790@qq.com',
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://pub.flutter-io.cn/static/img/pub-dev-logo-2x.png?hash=umitaheu8hl7gd3mineshk2koqfngugi'),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bg_flower.jpg'))),
          ),
          ListTile(
            title: Text('切换项目'),
            subtitle: Text(
              '${Provider.of<ProjectModel>(context).project.name}',
            ),
            trailing: Icon(Icons.swap_vertical_circle),
            onTap: () {
              print('switch project');
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new SwitchProject()));
            },
          ),
          ListTile(
            title: Text('店铺'),
            subtitle: Text(
              '${Provider.of<ShopModel>(context).shop.name}',
            ),
            trailing: Icon(Icons.swap_vertical_circle),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new ShopList()));
            },
          ),
          ListTile(
            title: Text('系统设置'),
            trailing: Icon(Icons.settings),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Setting()));
            },
          ),
          ListTile(
            title: Text('文字识别'),
            trailing: Icon(Icons.crop_free),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Scanner()));
            },
          ),
          ListTile(title: Text('我要发布'), trailing: Icon(Icons.send)),
          Divider(),
          ListTile(
            title: Text('切换账号'),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.pushNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }
}
