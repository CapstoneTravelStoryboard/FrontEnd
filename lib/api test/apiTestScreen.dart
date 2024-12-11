import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tripdraw/api%20test/tokenStorage.dart';
import '../config/appConfig.dart';

class ApiPostTestScreen extends StatefulWidget {
  @override
  _ApiPostTestScreenState createState() => _ApiPostTestScreenState();
}

class _ApiPostTestScreenState extends State<ApiPostTestScreen> {
  String responseMessage = "아직 응답이 없습니다.";
  List<String> responseList = [];
  String responseString = '';

  // POST 요청 함수
  Future<void> sendPostRequest() async {
    final url = Uri.parse('${AppConfig.baseUrl}/api/v1/auth/login');
    final body = {};

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "ngrok-skip-browser-warning": "69420",
        },
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        setState(() {
          responseList =
              List<String>.from(responseData.map((item) => item.toString()));
          responseMessage = "요청 성공! 제목 리스트가 로드되었습니다.";
        });
      } else {
        setState(() {
          responseMessage = "오류 발생: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        responseMessage = "예외 발생: $e";
      });
    }
  }

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

  void handleLogin(BuildContext context) async {
    final loginBody = {
      'email': 'string@naver.com',
      'password': 'string',
    };

    final result = await login(loginBody);

    if (result.containsKey('token')) {
      // 로그인 성공
      final token = result['token'];
      final member = result['member'];
      print("token ${token}");
      // Token을 SharedPreferences에 저장
      // await saveToken(token);
      final tokenStorage = TokenStorage();

      tokenStorage.saveToken(token);
// Read token
      String? savedtoken = tokenStorage.readToken();
      print("Saved token: $savedtoken");

      // 로그인 성공 메시지
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("로그인 성공: ${member['name']}님 환영합니다!")),
      );
    } else {
      // 로그인 실패 메시지
      final errorMessage = result['error'] ?? '알 수 없는 오류';
      final statusCode = result['statusCode'] ?? 'N/A';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("로그인 실패: $errorMessage (상태 코드: $statusCode)")),
      );
    }
  }

  Map<String, dynamic> request_body = {
    "name": "string",
    "email": "string@naver.com",
    "password": "string",
    "passwordConfirm": "string"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API POST Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "회원가입 POST 요청 보내기",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                signUp(request_body);
              },
              child: Text("POST 요청 보내기"),
            ),
            SizedBox(height: 20),
            Text(
              "응답 메시지:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(responseMessage),
            SizedBox(height: 20),
            Text(
              "응답 리스트:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "로그인 POST 요청 보내기",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => handleLogin(context),

              child: Text("POST 요청 보내기"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: responseList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(responseList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
