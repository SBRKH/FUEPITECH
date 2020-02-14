
import 'dart:convert';
import 'package:dio/dio.dart';

class API {
  static Future<dynamic> post(String url, Map<String, dynamic> body) async {
    Response<String> response;
    final Dio dio = Dio();

    response = await dio.post(url, data: body);
    return json.decode(response.toString());
  }
}