import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yskc/common/notifier.dart';
import 'package:yskc/common/state/manager.dart';
import 'package:yskc/modules/truck/api/truck.dart';
import 'package:yskc/modules/user/model/user.dart';

class TruckList extends StatefulWidget {
  TruckList({Key key}) : super(key: key);

  @override
  _TruckListState createState() => _TruckListState();
}

class _TruckListState extends State<TruckList> with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController = RefreshController();
  List<Map<dynamic, dynamic>> list = [];
  var param = {"page": 1, "rows": 10, "hasNextPage": true};
  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("卡车列表"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {},
      ),
      body: Container(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              controller: _refreshController,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: list.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  var item = list[index];
                  return Row(
                    children: [
                      Expanded(
                        child: Image.network(
                          item['default_url'],
                          height: 80,
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(item['title']),
                          subtitle: Text(item['description']),
                        ),
                        flex: 5,
                      )
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }

  void _onRefresh() async {
    var data = await TruckApi.page(param);
    list = data['list'];
    param = {"page": data["pageNum"], "rows": data["pageSize"], "hasNextPage": data["hasNextPage"]};
    _refreshController.refreshCompleted();
    this.setState(() {});
  }

  void _onLoading() async {
    if (!param['hasNextPage']) {
      return null;
    }
    var data = await TruckApi.page(param);
    list.addAll(data['list']);
    param = {"page": data["pageNum"], "rows": data["pageSize"], "hasNextPage": data["hasNextPage"]};
    _refreshController.loadComplete();
    if (mounted) setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
