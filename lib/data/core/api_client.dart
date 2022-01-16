import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviecorn/data/core/api_constants.dart';

class ApiClient {
  final http.Client _client;
  ApiClient(this._client);

  dynamic get(String path, {Map<dynamic, String>? params}) async {
    final url = Uri.parse(
      search(path, params ?? {}),
    );
    final response = await _client.get(url, headers: {
      "Content-type": "application/json",
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic search(String path, Map<dynamic, String> params) {
    var stringParams = "";
    if (params.isNotEmpty || params != null) {
      params.forEach((key, value) {
        stringParams += "&$key=$value";
      });
    }
    return "${ApiConstants.baseUrl}$path?api_key=${ApiConstants.apiKey}$stringParams";
  }
}
