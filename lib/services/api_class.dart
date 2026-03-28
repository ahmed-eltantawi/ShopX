import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static Future<List<dynamic>> get({required String uri, String? token}) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "User-Agent": "Mozilla/5.0",
    };
    if (token != null) {
      headers.addAll({"Authentication": "Bearer $token"});
    }
    http.Response response = await http.get(Uri.parse(uri), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
        "There is some thing wrong in response state code: ${response.statusCode}",
      );
    }
  }

  static Future<Map<String, dynamic>> post({
    required String url,
    required dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "User-Agent": "Mozilla/5.0",
    };
    if (token != null) {
      headers.addAll({"Authentication": "Bearer $token"});
    }
    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "There is a problem with status code ${response.statusCode} And the body is: ${jsonDecode(response.body)}",
      );
    }
  }

  static Future<Map<String, dynamic>> put({
    required String url,
    required String id,
    required Map<String, dynamic> body,

    String? tokens,
  }) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    if (tokens != null) {
      headers.addAll({"Authentication": "Bearer $tokens"});
    }
    http.Response response = await http.put(
      Uri.parse("$url$id"),
      body: jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "There is a problem with status code ${response.statusCode} And the body is: ${jsonDecode(response.body)}",
      );
    }
  }
}
