import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/models/shop.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/views/hair/set_list.dart';
import 'package:myapp/views/hair/shop_list.dart';
import 'package:myapp/views/scan/scan.dart';
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
    User user = Provider.of<UserNotifier>(context).user;
    Shop shop = Provider.of<ShopModel>(context, listen: false).shop;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              '${user != null ? user.name : ''}',
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
          // ListTile(
          //   title: Text('切换项目'),
          //   subtitle: Text(
          //     '${Provider.of<ProjectModel>(context).project.name}',
          //   ),
          //   trailing: Icon(Icons.swap_vertical_circle),
          //   onTap: () {
          //     print('switch project');
          //     Navigator.push(
          //         context,
          //         new MaterialPageRoute(
          //             builder: (context) => new SwitchProject()));
          //   },
          // ),
          ListTile(
            title: Text('店铺'),
            subtitle: Text(
              '${shop?.name}',
            ),
            trailing: Icon(Icons.swap_vertical_circle),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ShopList())).then((value) {
                if (value) {
                  Navigator.of(context).pop();
                }
              });
            },
          ),
          ListTile(
            title: Text('套餐管理'),
            trailing: Icon(Icons.folder),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new SetList()));
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
