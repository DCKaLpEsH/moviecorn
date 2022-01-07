import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviecorn/data/core/api_constants.dart';

class ApiClient {
  final http.Client _client;
  ApiClient(this._client);

  dynamic get(String path) async {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}$path?api_key=${ApiConstants.apiKey}");
    final response = await _client.get(url, headers: {
      "Content-type": "application/json",
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
