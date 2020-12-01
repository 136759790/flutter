import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/models/hair/set.dart';
import 'package:myapp/views/hair/vip_search.dart';

class ShopCard extends StatefulWidget {
  ShopCard({Key key}) : super(key: key);

  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  List<Set> _sets = [];
  TextEditingController _set = TextEditingController();
  TextEditingController _ctime = TextEditingController(
      text: DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()));
  Map _form = {
    'name': '',
    'phone': '',
    'set': null,
  };
  GlobalKey _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    HairApi.getSets({}).then((data) {
      this.setState(() {
        _sets = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('添加会员卡'),
        centerTitle: true,
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: 100.0, left: 50.0, right: 50.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _fieldName(),
                  SizedBox(
                    height: 10,
                  ),
                  _fieldPhone(),
                  SizedBox(
                    height: 10,
                  ),
                  _fieldSet(),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                    onPressed: () {
                      if ((_formKey.currentState as FormState).validate()) {}
                    },
                    child: Text(
                      '保存',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              )),
        );
      }),
    );
  }

  Widget _btnSave() {
    if ((_formKey.currentState as FormState).validate()) {}
  }

  Widget _fieldSet() {
    return TextFormField(
      controller: _set,
      readOnly: true,
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => Container(
                  height: 400,
                  child: ListView.separated(
                    itemCount: _sets.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      Set set = _sets[index];
                      return ListTile(
                        title: Text(set.name),
                        subtitle: Text(set.description),
                        trailing: Icon(Icons.touch_app),
                        onTap: () {
                          _chooseSet(set);
                        },
                      );
                    },
                  ),
                ));
      },
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.arrow_drop_down),
          border: UnderlineInputBorder(),
          filled: true,
          counterStyle: TextStyle(color: Colors.white),
          fillColor: Colors.transparent,
          hintText: '请选择套餐',
          prefixIcon: Icon(Icons.reorder)),
    );
  }

  Widget _fieldName() {
    return TextFormField(
      readOnly: true,
      initialValue: _form['name'],
      autofocus: false,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          filled: true,
          counterStyle: TextStyle(color: Colors.white),
          fillColor: Colors.transparent,
          suffixIcon: Icon(Icons.clear),
          border: UnderlineInputBorder(),
          hintText: '请输入会员姓名'),
      validator: (value) => value.trim().isNotEmpty ? null : '姓名不能为空',
      onTap: () {
        showSearch(context: context, delegate: VipSearch()).then((value) {
          print('showSearch------>$value');
        });
      },
      onSaved: (value) {
        setState(() {
          _form['name'] = value;
        });
      },
    );
  }

  Widget _fieldPhone() {
    return TextFormField(
      initialValue: _form['phone'],
      autofocus: false,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          filled: true,
          counterStyle: TextStyle(color: Colors.white),
          fillColor: Colors.transparent,
          suffixIcon: Icon(Icons.clear),
          border: UnderlineInputBorder(),
          hintText: '请输入会员手机号码',
          prefixIcon: Icon(Icons.phone)),
      validator: (value) => value.trim().isNotEmpty ? null : '手机号码不能为空',
      onSaved: (value) {
        setState(() {
          _form['phone'] = value;
        });
      },
    );
  }

  void _chooseSet(Set set) {
    setState(() {
      _form['set'] = set;
      _set.text = set.name;
    });
    Navigator.of(context).pop();
  }
}
