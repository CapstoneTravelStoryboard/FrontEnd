// import 'package:shared_preferences/shared_preferences.dart';
//
// Future<void> saveToken(String token) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('auth_token', token); // 'auth_token'은 저장 키
// }
//
//
// Future<String?> getToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString('auth_token'); // 'auth_token'으로 저장된 값 가져오기
// }
//
// Future<void> deleteToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.remove('auth_token'); // 'auth_token' 삭제
// }
