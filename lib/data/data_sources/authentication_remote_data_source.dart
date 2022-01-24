import 'package:moviecorn/data/core/api_client.dart';
import 'package:moviecorn/data/models/request_token_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<RequestTokenModel> getRequestToken();
  Future<RequestTokenModel> validateWithLogin(Map<String, dynamic> requestBody);
  Future<String> createSession(Map<String, dynamic> requestBody);
  Future<void> deleteSession(String sessionId);
}

class AuthenticationDataSourceImpl extends AuthenticationRemoteDataSource {
  final ApiClient _client;
  AuthenticationDataSourceImpl(
    this._client,
  );
  @override
  Future<String> createSession(Map<String, dynamic> requestBody) async {
    final response = await _client.post(
      'authentication/session/new',
      params: requestBody,
    );

    print("CREATE SESSION: $response");
    return response['success'] ? response['session_id'] : null;
  }

  @override
  Future<RequestTokenModel> getRequestToken() async {
    final response = await _client.get('authentication/token/new');
    print("GET REQUEST TOKEN: $response");
    final requestTokenModel = RequestTokenModel.fromJson(response);
    return requestTokenModel;
  }

  @override
  Future<RequestTokenModel> validateWithLogin(
      Map<String, dynamic> requestBody) async {
    final response = await _client.post(
      'authentication/token/validate_with_login',
      params: requestBody,
    );
    print("VALIDATION: $response");
    return RequestTokenModel.fromJson(response);
  }

  @override
  Future<void> deleteSession(String sessionId) async {
    final response =
        await _client.deleteWithBody('authentication/session', params: {
      'session_id': sessionId,
    });
    print("DELETE: ${response['success']}");
    return response['success'] ?? false;
  }
}
