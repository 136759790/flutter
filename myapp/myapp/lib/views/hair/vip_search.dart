import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/Page.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/models/hair/vip.dart';
import 'package:myapp/views/hair/vip_edit.dart';
import 'package:provider/provider.dart';

class VipSearch extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => "请输入姓名或手机号搜索";
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {})];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var data = {
      'shop_id': Provider.of<ShopModel>(context).shop.id,
      'key': query ?? ''
    };
    return FutureBuilder(
      future: HairApi.pageVip(data),
      initialData: {},
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          PageInfo page = snapshot.data;
          if (page.data == null || page.data.isEmpty) {
            return Center(
              child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context) => VipEdit()));
                  },
                  child: Text('未找到联系人，点击新建')),
            );
          } else {
            return ListView.builder(
                itemCount: page.total,
                itemBuilder: (context, index) {
                  var item = page.data[index];
                  Vip vip = Vip.fromJson(item);
                  return ListTile(
                    title: RichText(
                      text: TextSpan(
                          text: '${vip.name}',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: '', style: TextStyle(color: Colors.grey))
                          ]),
                    ),
                    trailing: Text('${vip.phone}'),
                  );
                });
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
