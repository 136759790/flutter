import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/main.dart';

class Scanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScannerState();
}

class ScannerState extends State<Scanner> {
  CameraController controller;
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
          )),
          Expanded(
              child: Center(
            child: TextField(
              maxLines: 10,
            ),
          )),
        ],
      ),
    );
  }
}
