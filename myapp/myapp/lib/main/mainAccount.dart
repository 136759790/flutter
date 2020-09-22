import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class AccountMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountMainState();
}

class AccountMainState extends State<AccountMain> {
  void _chooseDate() async {
   Picker picker = new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: new JsonDecoder().convert(PickerData)),
        changeToFirst: true,
        textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
        }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '小店记账',
        ),
        centerTitle: true,
        leading: Icon(Icons.settings),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _chooseDate,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '2020年',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          Row(
                            children: [
                              Text(
                                '09月',
                                style: TextStyle(fontSize: 15),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                SizedBox(
                  width: 1,
                  height: 20,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '收入',
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          '200000',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '支出',
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          '200000',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  flex: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
