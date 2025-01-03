import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tripdraw/api%20test/generatesb_api_func.dart';
import 'package:tripdraw/config/appConfig.dart';

import 'package:get/get.dart';

import '../controller/tokenController.dart';

Future<String> signUp(Map<String, dynamic> body) async {
  final url = Uri.parse('${AppConfig.baseUrl}/api/v1/members/signup');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // 응답 데이터를 JSON으로 디코드 후 String List로 변환
      final responseData = json.decode(response.body);
      print('응답 데이터: $responseData');
      return responseData;
    } else {
      print('오류: ${response.statusCode}');
      return '';
    }
  } catch (e) {
    print('예외 발생: $e');
    return '';
  }
}

Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
  final url = Uri.parse('${AppConfig.baseUrl}/api/v1/members/login');

  final tokenController = Get.find<TokenController>();
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('응답 데이터: $responseData');
      return responseData; // JSON 데이터를 반환
    } else {
      print('오류: ${response.statusCode}');
      return {'error': '로그인 실패', 'statusCode': response.statusCode};
    }
  } catch (e) {
    print('예외 발생: $e');
    return {'error': '예외 발생', 'exception': e.toString()};
  }
}

void handleLogin(BuildContext context, loginBody) async {
  final result = await login(loginBody);

  if (result.containsKey('token')) {
    // 로그인 성공
    final token = result['token'];
    final member = result['member'];
    print("token ${token}");
    tokenController.updateToken(token);
    // Token 저장
    final name = member['name'];

    // 이름이 한글일 경우 UTF-8로 인코딩
    final encodedName = utf8.encode(name); // 바이트 배열로 인코딩
    final decodedName = utf8.decode(encodedName); // 다시 디코딩

    print("token ${token}");
    print("encodedName $encodedName");
    print("decodedName $decodedName");

    tokenController.updateToken(token);
    // 로그인 성공 메시지
    Get.snackbar(
      '로그인 성공',
      '환영합니다!',
      snackPosition: SnackPosition.BOTTOM,
    );
  } else {
    // 로그인 실패 메시지
    final errorMessage = result['error'] ?? '알 수 없는 오류';
    final statusCode = result['statusCode'] ?? 'N/A';

    Get.snackbar(
      '로그인 실패',
      '에러: $errorMessage (상태 코드: $statusCode)',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

}
