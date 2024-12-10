import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? selectedEmailDomain;

  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    // 모든 컨트롤러의 변화 감지
    idController.addListener(_validateInputs);
    passwordController.addListener(_validateInputs);
    confirmPasswordController.addListener(_validateInputs);
    emailController.addListener(_validateInputs);
    phoneController.addListener(_validateInputs);
  }

  void _validateInputs() {
    final isFormValid = idController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text == passwordController.text &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        selectedEmailDomain != null;
    isButtonEnabled.value = isFormValid;
  }

  @override
  void dispose() {
    // 컨트롤러 해제
    idController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 50.h, 20.w, 16.h),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '회원가입',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            // 아이디
            Text('아이디'),
            TextField(
              controller: idController,
              decoration: InputDecoration(
                hintText: '아이디',
                helperText: '4~12자/영문 소문자(숫자 조합 가능)',
                suffix: ElevatedButton(
                  onPressed: () {
                    // 중복 확인 동작
                  },
                  child: Text('중복확인'),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // 비밀번호
            Text('비밀번호'),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '비밀번호',
                helperText: '6~20자/영문 대문자, 소문자, 숫자, 특수문자 중 2가지 이상 조합',
              ),
            ),
            SizedBox(height: 16.0),

            // 비밀번호 확인
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '비밀번호 확인',
              ),
            ),
            SizedBox(height: 16.0),

            // 이메일
            Text('이메일'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: '이메일'),
                  ),
                ),
                SizedBox(width: 8.0),
                DropdownButton<String>(
                  value: selectedEmailDomain,
                  items: ['@naver.com', '@gmail.com']
                      .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedEmailDomain = newValue;
                      _validateInputs();
                    });
                  },
                  hint: Text('선택'),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              '더 안전하게 계정을 보호하려면 가입 후 [내정보 > 회원정보 수정]에서 이메일 인증을 진행해주세요.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
            SizedBox(height: 16.0),

            // 휴대폰 번호
            Text('휴대폰 번호'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(hintText: '휴대폰 번호'),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // 인증번호 받기 동작
                  },
                  child: Text('인증번호 받기'),
                ),
              ],
            ),
            SizedBox(height: 50.h,),

            // 가입하기 버튼
            ValueListenableBuilder<bool>(
              valueListenable: isButtonEnabled,
              builder: (context, isEnabled, child) {
                return Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      backgroundColor: isEnabled ? Colors.blue : Colors.grey,
                    ),
                    onPressed: isEnabled
                        ? () {
                      // 가입하기 동작
                    }
                        : null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text('가입하기'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
