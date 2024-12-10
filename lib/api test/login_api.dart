import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> sendDataForTitle(Map<String, dynamic> body) async {
  final url = Uri.parse('/api/v1/users');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json',
      'Cookie':'JSESSIONID='},
      body: json.encode(body),
    );

    if (response.statusCode == 201) {
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
