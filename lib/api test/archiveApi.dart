import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> deleteTrip(int id) async {
  final url = Uri.parse('https://your-api-domain.com/api/v1/trips/$id');
  final headers = {'Content-Type': 'application/json'};

  try {
    // DELETE 요청
    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 204) {
      // 삭제 성공
      Get.snackbar('완료', '여행이 삭제되었습니다.');
    } else {
      // 삭제 실패
      Get.snackbar('오류', '여행을 삭제하는 데 실패했습니다.');
    }
  } catch (e) {
    // 네트워크 오류 등 처리
    print('Error deleting trip: $e');
    Get.snackbar('오류', '여행을 삭제하는 중 문제가 발생했습니다.');
  }
}