import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tripdraw/config/appConfig.dart';

Future<List<String>> signUp(Map<String, dynamic> body) async {
  final url = Uri.parse('${AppConfig.baseUrl}/api/v1/members/signup');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json',
      'Cookie':'JSESSIONID='},
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      // 응답 데이터를 JSON으로 디코드 후 String List로 변환
      final responseData = json.decode(response.body);
      List<String> result = List<String>.from(responseData.map((item) => item.toString()));
      print('응답 데이터: $result');
      return result;
    } else {
      print('오류: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('예외 발생: $e');
    return [];
  }
}



Future<void> login(
    BuildContext context, {
      required String email,
      required String password,
    }) async {
  final url = Uri.parse('${AppConfig.baseUrl}/api/v1/members/login');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final String token = responseData['token'];
      final Map<String, dynamic> member = responseData['member'];


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("로그인 성공: ${member['name']}님 환영합니다!")),
      );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("로그인 실패: ${response.statusCode}")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("로그인 중 오류 발생: $e")),
    );
  }
}
