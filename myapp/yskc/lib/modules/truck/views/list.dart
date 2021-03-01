import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yskc/common/notifier.dart';
import 'package:yskc/modules/user/model/user.dart';

class TruckList extends StatefulWidget {
  TruckList({Key key}) : super(key: key);

  @override
  _TruckListState createState() => _TruckListState();
}

class _TruckListState extends State<TruckList> {
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  @override
  void initState() {
    super.initState();
    User user = Provider.of<UserNotifier>(context, listen: false).user;
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("卡车列表"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {},
      ),
      body: Container(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          controller: _refreshController,
          child: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              return Text('123');
            },
          ),
        ),
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }
}
