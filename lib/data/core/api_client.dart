import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviecorn/data/core/api_constants.dart';
import 'package:moviecorn/data/core/unauthorised_exception.dart';

class ApiClient {
  final http.Client _client;
  ApiClient(this._client);

  dynamic get(String path, {Map<dynamic, String>? params}) async {
    final response = await _client.get(getPath(path, params ?? {}), headers: {
      "Content-type": "application/json",
    });

    Future.delayed(Duration(milliseconds: 2000));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Uri getPath(String path, Map<dynamic, String> params) {
    var stringParams = "";
    if (params.isNotEmpty || params != null) {
      params.forEach((key, value) {
        stringParams += "&$key=$value";
      });
    }
    return Uri.parse(
      "${ApiConstants.baseUrl}$path?api_key=${ApiConstants.apiKey}$stringParams",
    );
  }

  dynamic post(String path, {Map<dynamic, dynamic>? params}) async {
    final response = await _client.post(
      getPath(
        path,
        {},
      ),
      body: jsonEncode(params),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic deleteWithBody(String path, {Map<dynamic, dynamic>? params}) async {
    http.Request request = http.Request('DELETE', getPath(path, {}));
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode(params);
    final response = await _client.send(request).then(
          (value) => http.Response.fromStream(value),
        );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
