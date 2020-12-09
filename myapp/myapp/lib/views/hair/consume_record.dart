import 'package:flutter/material.dart';

class ConsumeRecord extends StatefulWidget {
  int id;
  ConsumeRecord(this.id);

  @override
  _ConsumeRecordState createState() => _ConsumeRecordState();
}

class _ConsumeRecordState extends State<ConsumeRecord> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('data'),
    );
  }
}
