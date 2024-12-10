import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/View/Archive/archiveView.dart';
import 'package:tripdraw/View/GenerateStoryboard/generateStoryboard.dart';
import 'package:tripdraw/View/LogIn/signUp.dart';
import 'package:tripdraw/style.dart' as style;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
              '로그인',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            // 아이디
            TextField(
              controller: idController,
              decoration: InputDecoration(
                hintText: '아이디',
                suffix: ElevatedButton(
                  onPressed: () {
                    // 중복 확인 동작
                  },
                  child: Text('중복확인'),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '비밀번호',
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Text("아직 회원이 아니신가요?",style: TextStyle(fontSize: 14.sp),),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignUpScreen());
                  },
                  child: Text("회원가입", style: TextStyle(fontSize: 14.sp, color: Colors.blueAccent),),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),

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
