import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/models/hair/set.dart';
import 'package:myapp/views/hair/set_edit.dart';
import 'package:provider/provider.dart';

class SetList extends StatefulWidget {
  SetList({Key key}) : super(key: key);

  @override
  _SetListState createState() => _SetListState();
}

class _SetListState extends State<SetList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('套餐管理'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SetEdit()));
              })
        ],
      ),
      body: _body(),
      // body: _sets.length > 0 ? _body() : _emptyBody(),
    );
  }

  _body() {
    return FutureBuilder<List>(
        future: _getSet(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var _sets = snapshot.data;
            return ListView.separated(
              itemCount: _sets.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                Set set = _sets[index];
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(set.name),
                        flex: 3,
                      ),
                      Expanded(child: Text('${set.time}次'))
                    ],
                  ),
                  subtitle: Text(set.description),
                  trailing: Icon(Icons.edit),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future _getSet() {
    var shop_id = Provider.of<ShopModel>(context, listen: false).shop.id;
    return HairApi.getSets({"shop_id": shop_id});
  }
}
