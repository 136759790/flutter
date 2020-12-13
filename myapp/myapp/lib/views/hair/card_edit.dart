import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/models/hair/set.dart';
import 'package:myapp/models/hair/vip.dart';
import 'package:myapp/views/hair/vip_search.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ShopCard extends StatefulWidget {
  int id;
  ShopCard({Key key, this.id});

  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  List<Set> _sets = [];
  TextEditingController _set = TextEditingController();
  TextEditingController _name = TextEditingController();
  Map _form = {
    'vip': null,
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
    if (widget.id != null) {
      HairApi.getVip(widget.id).then((vip) {
        this.setState(() {
          _form['vip'] = vip;
          _name.text = vip.name;
        });
      });
    }
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
                  _fieldSet(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 1000,
                    padding: EdgeInsets.all(20),
                    child: FlatButton(
                      onPressed: () {
                        if ((_formKey.currentState as FormState).validate()) {
                          var card = {
                            'set_id': _form['set'].id,
                            'vip_id': _form['vip'].id,
                            'shop_id':
                                Provider.of<ShopModel>(context, listen: false)
                                    .shop
                                    .id,
                          };
                          HairApi.saveCard(card).then((value) {
                            Navigator.of(context).pop(true);
                          });
                        }
                      },
                      child: Text(
                        '保存',
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              )),
        );
      }),
    );
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
      controller: _name,
      readOnly: true,
      autofocus: false,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          filled: true,
          counterStyle: TextStyle(color: Colors.white),
          fillColor: Colors.transparent,
          suffixIcon: Icon(Icons.arrow_drop_down),
          border: UnderlineInputBorder(),
          hintText: '请选择会员'),
      onTap: () {
        showSearch(context: context, delegate: VipSearch()).then((id) async {
          Vip vip = await HairApi.getVip(id);
          this.setState(() {
            _form['vip'] = vip;
            _name.text = vip.name;
          });
        });
      },
      onSaved: (value) {
        setState(() {
          _form['name'] = value;
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
