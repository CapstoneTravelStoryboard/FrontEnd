import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/appConfig.dart';

class ApiPostTestScreen extends StatefulWidget {
  @override
  _ApiPostTestScreenState createState() => _ApiPostTestScreenState();
}

class _ApiPostTestScreenState extends State<ApiPostTestScreen> {
  String responseMessage = "아직 응답이 없습니다.";
  List<String> responseList = [];

  // POST 요청 함수
  Future<void> sendPostRequest() async {
    final url = Uri.parse('${AppConfig.baseUrl}/api/v1/auth/login');
    final body = {

    };

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
              "POST 요청 보내기",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: sendPostRequest,
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
