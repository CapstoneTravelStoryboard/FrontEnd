import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripdraw/style.dart' as style;
class TutorialView extends StatefulWidget {
  @override
  _TutorialViewState createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // TabController 리스너 추가
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {}); // 상태를 갱신해 UI 업데이트
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 50.h, 20.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이용방법 안내',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('images/guide1.png'),
                    SizedBox(height: 16.h),
                    Image.asset('images/guide2.png'),
                    SizedBox(height: 16.h),
                    Image.asset('images/guide3.png'),
                    SizedBox(height: 16.h),
                    Image.asset('images/guide4.png'),
                    SizedBox(height: 16.h),
                    Image.asset('images/guide5.png'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
