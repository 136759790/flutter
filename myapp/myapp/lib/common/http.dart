import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/common/result.dart';

var dio = new Dio(new BaseOptions(
    contentType: Headers.jsonContentType,
    baseUrl: 'http://api.grelove.com/',
    connectTimeout: 5000,
    receiveTimeout: 5000));
