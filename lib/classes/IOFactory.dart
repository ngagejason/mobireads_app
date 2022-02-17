import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'UserSecureStorage.dart';

class IOFactory {

  static int TimeoutSeconds = 180;

  static Map<String,String> getGetHeaders() =>
      <String, String>{};

  static Map<String,String> getPostHeaders() =>
      <String, String>{'Content-Type': 'application/json; charset=UTF-8'};

  static Future<Map<String,String>> getGetHeadersWithBearer() async {
    Map<String,String> h = getGetHeaders();
    String bearer = await UserSecureStorage.getBearer() ?? '';
    h.addAll({'Authorization': bearer}) ;
    return h;
  }

  static Future<Map<String,String>> getPostHeadersWithBearer() async {
    Map<String,String> h = getPostHeaders();
    h.addAll({'Authorization': await UserSecureStorage.getBearer() ?? ''}) ;
    return h;
  }

  static Uri getPath(String extension, Map<String,String>? args) {
    var base = dotenv.env['SERVER_BASE'] ?? '';
    bool first = true;
    args?.forEach((k, v) {
      extension += first ? '?' : '&';
      extension += k + '=' + v;
      first = false;
    });

    return Uri.parse(base + extension);
  }


  static Future<Response> doPost<T>({ required String urlExtension, required T data }) async {
    return await http.post(
        IOFactory.getPath(urlExtension, null),
        headers: await IOFactory.getPostHeaders(),
        body: jsonEncode(data)
    ).timeout(Duration(seconds: TimeoutSeconds));
  }

  static Future<Response> doPostWithBearer<T>({ required String urlExtension, required T data }) async {
    return await http.post(
        IOFactory.getPath(urlExtension, null),
        headers: await IOFactory.getPostHeadersWithBearer(),
        body: jsonEncode(data)
    ).timeout(Duration(seconds: TimeoutSeconds));
  }

  static Future<Response> doGetWithBearer({ required String urlExtension, Map<String,String>? args }) async {
    return await http.get(
      IOFactory.getPath(urlExtension, args),
      headers: await IOFactory.getGetHeadersWithBearer()
    ).timeout(Duration(seconds: TimeoutSeconds));
  }


  static Future<Response> doGet({ required String urlExtension, Map<String,String>? args }) async {
    return await http.get(
        IOFactory.getPath(urlExtension, args)
    ).timeout(Duration(seconds: TimeoutSeconds));
  }
}