import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:yskc/api/truck.dart';

class TruckList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TruckListState();
}

class TruckListState extends State<TruckList> {
  int page = 1;
  int rows = 50;
  List<dynamic> _trucks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('卡车列表'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: [
          Expanded(child: _searchBar()),
          Expanded(
            child: _listView(),
            flex: 6,
          )
        ]),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              
              decoration: InputDecoration(
                labelText: '搜索',
                labelStyle: TextStyle(
                  color: Colors.pink,
                  fontSize: 12,
                ),
                helperText: 'helperText',
                hintText: 'Placeholder...',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
            flex: 5,
          ),
          Expanded(child: Icon(Icons.search))
        ],
      ),
    );
  }

  Widget _listView() {
    return CustomScrollView(
      slivers: [
        SliverSafeArea(
            sliver: SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return _truckView(index);
          }, childCount: _trucks.length)),
        )),
      ],
    );
  }

  Widget _truckView(int index) {
    return Row(
      children: [
        Expanded(
            child: Image.network(
          _trucks[index]['default_url'],
          height: 80,
        )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_trucks[index]['title'], textAlign: TextAlign.start),
                Text(
                  _trucks[index]['description'],
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 12),
                ),
                Tags(
                  itemCount: 2,
                  itemBuilder: (int index_) {
                    if (index_ == 0) {
                      return ItemTags(
                        index: index,
                        title: '￥${_trucks[index]['price']}万',
                        pressEnabled: false,
                        activeColor: Colors.green,
                        textStyle: TextStyle(fontSize: 10),
                      );
                    } else {
                      return ItemTags(
                        index: index,
                        title: '浏览${_trucks[index]['hits']}次',
                        pressEnabled: false,
                        activeColor: Colors.grey,
                        textStyle: TextStyle(fontSize: 10),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          flex: 3,
        )
      ],
    );
  }

  void _getdata() {
    TruckApi.page({"page": page, "rows": rows}).then((data) {
      setState(() {
        _trucks.addAll(data['list']);
      });
    });
  }
}

class SearchBarDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
