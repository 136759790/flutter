import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/main.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class Scanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScannerState();
}

class ScannerState extends State<Scanner> {
  CameraController controller;
  List<Widget> _ws = [];
  var dio = new Dio(new BaseOptions(
      responseType: ResponseType.json,
      contentType: Headers.formUrlEncodedContentType,
      connectTimeout: 500000,
      receiveTimeout: 500000));
  @override
  void initState() {
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container(
        child: Text('123'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('文字识别'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: CameraPreview(controller),
            ),
            flex: 4,
          ),
          Expanded(
            child: RaisedButton(
              onPressed: () async {
                final dateTime = DateTime.now();
                final path = join(
                    (await getApplicationDocumentsDirectory()).path,
                    '${dateTime.millisecondsSinceEpoch}.png');
                await controller.takePicture(path);
                List<String> ws = await _baidu(path);
                for (var s in ws) {
                  setState(() {
                    _ws.add(Text(s));
                  });
                }
              },
              child: Text('拍照'),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: _ws,
              ),
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }

  _baidu(String path) async {
    String key = "YN7uOc5bNNE8W5ut2CAy4Zjq";
    String secret = "tepdQz0Z8hU74GT0asU9vx2gSnZHXhkQ";
    Response res = await dio.post(
        'https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=$key&client_secret=$secret');
    Map<String, dynamic> data = new Map.from(res.data);
    String access_token = data['access_token'];
    print('aaaaaaaaaaaaaaaa$access_token');
    File file = File(path);
    List<int> bytes = await file.readAsBytes();
    print('aaaaaaaaaaaaaaaa${bytes.length}');
    Response res2 = await dio.post(
        'https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic?access_token=$access_token',
        data: {"image": base64Encode(bytes)});
    print('aaaaaaaaaaaaaaaa$res2');
    Map<String, dynamic> data2 = new Map.from(res2.data);
    List words = data2['words_result'];
    List<String> ws = [];
    for (var w in words) {
      ws.add(w['words']);
    }
    return ws;
  }
}
