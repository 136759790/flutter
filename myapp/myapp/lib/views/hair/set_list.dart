import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/models/hair/set.dart';
import 'package:myapp/views/hair/set_edit.dart';

class SetList extends StatefulWidget {
  SetList({Key key}) : super(key: key);

  @override
  _SetListState createState() => _SetListState();
}

class _SetListState extends State<SetList> {
  List _sets = [];
  @override
  void initState() {
    super.initState();
    _init();
  }

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
      body: _sets.length > 0 ? _body() : _emptyBody(),
      // body: _sets.length > 0 ? _body() : _emptyBody(),
    );
  }

  _emptyBody() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(44.0),
      child: FlatButton.icon(
          color: Colors.blue,
          onPressed: () {
            Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) => SetEdit()))
                .then((value) {
              if (value) {
                this._init();
              }
            });
          },
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: Text(
            '添加套餐',
            style: TextStyle(color: Colors.white),
          )),
    ));
  }

  _body() {
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
  }

  void _init() {
    HairApi.getSets({}).then((data) => {
          this.setState(() {
            _sets = data;
          })
        });
  }
}
