import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/models/hair/set.dart';
import 'package:myapp/views/hair/set_edit.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SetList extends StatefulWidget {
  SetList({Key key}) : super(key: key);

  @override
  _SetListState createState() => _SetListState();
}

class _SetListState extends State<SetList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<Set> _sets = [];
  @override
  void initState() {
    super.initState();
    _getSet().then((value) {
      setState(() {
        _sets = value;
      });
    });
  }

  void _onRefresh() async {
    var result = await _getSet();
    setState(() {
      _sets = result;
    });
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('套餐管理'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SetEdit()))
                    .then((value) {
                  if (value) {
                    setState(() {});
                  }
                });
              })
        ],
      ),
      body: _body(),
      // body: _sets.length > 0 ? _body() : _emptyBody(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(10),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView.separated(
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
              trailing: Icon(Icons.keyboard_arrow_right),
            );
          },
        ),
      ),
    );
  }

  Future _getSet() {
    var shop_id = Provider.of<ShopModel>(context, listen: false).shop.id;
    return HairApi.getSets({"shop_id": shop_id});
  }
}
