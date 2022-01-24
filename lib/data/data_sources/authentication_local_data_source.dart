import 'package:hive/hive.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveSessionId(String sessionId);
  Future<String> getSessionId();
  Future<void> deleteSession();
}

class AuthenticationLocalDataSourceImpl extends AuthenticationLocalDataSource {
  @override
  Future<void> deleteSession() async {
    print('delete session - local');
    final authenticationBox = await Hive.openBox('authenticationBox');
    authenticationBox.delete('session_id');
  }

  @override
  Future<String> getSessionId() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    print("GET: ${authenticationBox.get('session_id')}");
    return await authenticationBox.get('session_id');
  }

  @override
  Future<void> saveSessionId(String sessionId) async {
    final authenticationBox = await Hive.openBox('authenticationBox');

    return await authenticationBox.put('session_id', sessionId);
  }

  // @override
  // Future<void> saveSessionId(String sessionId) async {
  //   final authenticationBox = await Hive.openBox('authenticationBox');

  //   await authenticationBox.put('session_id', sessionId);
  //   print('ID: ${Hive.box("authenticationBox").values}');
  //   print("SESSION ID ADDED");
  // }

  // @override
  // Future<String> getSessionId() async {
  //   print("IS? ${Hive.isBoxOpen('name')}")
  //   final authenticationBox = await Hive.openBox("authenticationBox");
  //   return await authenticationBox.get('session_id');
  // }

  // @override
  // Future<void> deleteSession(String sessionId) async {
  //   final box = await Hive.openBox('authenticationBox');
  //   return await box.delete('session_id');
  // }
}
