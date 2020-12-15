import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/Page.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/models/hair/card.dart';
import 'package:myapp/models/hair/vip.dart';
import 'package:myapp/views/hair/card_edit.dart';
import 'package:myapp/views/hair/consume_record.dart';
import 'package:myapp/views/hair/vip_edit.dart';
import 'package:provider/provider.dart';

class VipView extends StatefulWidget {
  int id;
  VipView(this.id);

  @override
  _VipViewState createState() => _VipViewState();
}

class _VipViewState extends State<VipView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('会员'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _newRefresh,
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 10,
                margin: EdgeInsets.all(10),
                shadowColor: Colors.black54,
                child: FutureBuilder<Vip>(
                    future: HairApi.getVip(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Vip vip = snapshot.data;
                        String ctime = DateFormat('yyyy-MM-dd').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                vip.ctime * 1000));
                        return ListTile(
                          title: Text('${vip.name}'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          subtitle: Text('${vip.phone}  |  ${ctime}'),
                          leading: CircleAvatar(
                            child: Text('${vip.name[0]}'),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (_) => VipEdit(id: vip.id)))
                                .then((value) => {this.setState(() {})});
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ),
            Expanded(
              child: FutureBuilder<Object>(
                  future: HairApi.getCards({
                    "shop_id":
                        Provider.of<ShopModel>(context, listen: false).shop.id,
                    'vip_id': widget.id
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      PageInfo page = snapshot.data;
                      List cards = page.data;
                      if (cards == null || cards.isEmpty) {
                        return Center(
                          child: FlatButton(
                            onPressed: _newRefresh,
                            child: Text('无数据点击添加会员卡'),
                          ),
                        );
                      } else {
                        return CardsView(cards: cards);
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              flex: 6,
            ),
          ],
        ),
      ),
    );
  }

  void _newRefresh() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => VipEdit()))
        .then((value) => {this.setState(() {})});
  }
}

class CardsView extends StatelessWidget {
  const CardsView({
    Key key,
    @required this.cards,
  }) : super(key: key);

  final List cards;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          HairCard card = HairCard.fromJson(cards[index]);
          return Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            shadowColor: Colors.black54,
            child: Column(children: [
              ListTile(
                dense: true,
                title: Text('${card.name}'),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '共${card.time}次  |  已用${card.residue_time}次   |   办理时间 ${DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(card.ctime * 1000))}',
                      ),
                      Text('${card.description}')
                    ]),
                trailing: Icon(Icons.remove_red_eye),
              ),
              ButtonBar(
                children: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ConsumeRecord(card.id)));
                      },
                      child: Text('查看记录')),
                  FlatButton(onPressed: () {}, child: Text('点击消费'))
                ],
              )
            ]),
          );
        }, childCount: cards.length))
      ],
    );
  }
}
