import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/views/scan/scan.dart';
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
                  'https://avatars1.githubusercontent.com/u/18189078?s=400&u=f755a948031cb7e756b661c9f7c0978ed8524b96&v=4'),
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
          ListTile(title: Text('系统设置'), trailing: Icon(Icons.settings)),
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
