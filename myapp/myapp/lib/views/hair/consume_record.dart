import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/models/hair/card.dart';
import 'package:myapp/models/hair/record.dart';

class ConsumeRecord extends StatefulWidget {
  int id;
  ConsumeRecord(this.id);

  @override
  _ConsumeRecordState createState() => _ConsumeRecordState();
}

class _ConsumeRecordState extends State<ConsumeRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消费记录'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: _initData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<HairConsumeRecord> records = snapshot.data['records'];
              return ListView.separated(
                itemCount: records.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  HairConsumeRecord record = records[index];
                  String date = DateFormat('yyy-MM-dd').format(
                      DateTime.fromMillisecondsSinceEpoch(record.ctime * 1000));
                  return ListTile(
                    title: Text(date),
                    subtitle: Text(record.remark),
                    trailing: Text('消费成功'),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<Map> _initData() async {
    List<HairConsumeRecord> records = await HairApi.getRecords(widget.id);
    HairCard card = await HairApi.getCard(widget.id);
    return {
      "records": records,
      "card": card,
    };
  }
}
