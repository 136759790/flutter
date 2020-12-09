import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/models/hair/card.dart';
import 'package:myapp/views/hair/consume_record.dart';

class CardView extends StatefulWidget {
  int id;
  CardView(this.id);
  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('会员卡详情'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: FutureBuilder(
            future: HairApi.getCard(widget.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                HairCard card = snapshot.data;
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('${card.vip.name}'),
                      subtitle: Text('${card.vip.phone}'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.dashboard),
                      title: Text('${card.name}'),
                      subtitle: Text('${card.description}'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text('剩余${card.residue_time}次'),
                      subtitle: Text(
                          '共${card.time}次，已使用${card.residue_time - card.time}次'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ConsumeRecord(widget.id)));
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 1000,
                      child: FlatButton(
                          onPressed: () async {
                            await HairApi.reduceCardTime(widget.id);
                            setState(() {});
                          },
                          child: Text('消费')),
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
