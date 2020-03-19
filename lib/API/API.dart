import 'dart:convert';
import 'package:dio/dio.dart';

class API {
  static Future<dynamic> post(String url, Map<String, dynamic> body) async {
    try {
      Response<String> response;
      final Dio dio = Dio();

      response = await dio.post(url, data: body);
      return json.decode(response.toString());
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> get(String url) async {
    try {
      Response<String> response;
      final Dio dio = Dio();

      dio.options.headers['authorization'] = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMjg4MSwiaWF0IjoxNTczMTQyMDI3LCJleHAiOjE2MDQ2NzgwMjcsImF1ZCI6InNwb3J0c25jb25uZWN0LmNvbSIsImlzcyI6IlNwb3J0cyduJ0Nvbm5lY3QiLCJzdWIiOiJBcnRodXIgS2xiIn0.keDzm7_b-0nrmJ5HPgtssTUdd5N2JCl2TlriieHwcwlaMOaGX9ZWS_BuGTAwy84tEb67CT458jTmgzFcYe5baA';

      response = await dio.get(url);
      return json.decode(response.toString());
    } catch (e) {
      rethrow;
    }
  }
}
