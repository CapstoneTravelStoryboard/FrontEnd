import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ApiExampleScreen extends StatefulWidget {
  @override
  _ApiExampleScreenState createState() => _ApiExampleScreenState();
}

class _ApiExampleScreenState extends State<ApiExampleScreen> {
  final Dio dio = Dio();
  String message = "버튼을 눌러 데이터를 가져오세요!";
  bool isLoading = false;

  // API 요청 메서드
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      message = "데이터를 가져오는 중...";
    });

    try {
      final response =
          await dio.get('https://octopus-epic-shrew.ngrok-free.app');
      final data = response.data;

      setState(() {
        message =
        // "성공적으로 데이터를 가져왔습니다:\n\n";
        "${data.toString()}";
        // "Title: ${data['title']}\n\n"
        // "Body: ${data['body']}";
      });
    } catch (e) {
      setState(() {
        message = "데이터 가져오기에 실패했습니다.\n오류: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API 통신 예제'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
                  ? CircularProgressIndicator()
                  : Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchData,
                child: Text('데이터 가져오기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
