import 'package:get/get.dart';

class TokenController extends GetxController {
  // RxString을 사용하여 리액티브하게 토큰 값을 관리
  final RxString token = ''.obs;

  // 토큰 설정
  void setToken(String newToken) {
    token.value = newToken;
    print('Token updated: $newToken');
  }
  // 토큰 업데이트 함수
  void updateToken(String newToken) {
    token.value = newToken;
    print("Token updated: $newToken");
  }

  // 토큰 초기화
  void clearToken() {
    token.value = '';
    print('Token cleared');
  }

  // 토큰 값 가져오기
  String get currentToken => token.value;
}
