import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/style.dart' as style;
import 'package:url_launcher/url_launcher.dart';

class YoutubeUrlWidget extends StatefulWidget {
  const YoutubeUrlWidget({super.key});

  @override
  State<YoutubeUrlWidget> createState() => _YoutubeUrlWidgetState();
}

class _YoutubeUrlWidgetState extends State<YoutubeUrlWidget> {
  final List<String> bannerImages = [
    'images/guidebanner.png',
    'images/guidebanner2.png',
  ];

  final String youtube1 = "https://www.youtube.com/watch?v=kt0gJq-nN58";
  final String youtube2 = "https://www.youtube.com/watch?v=yQyClAcrgyI";

// URL 실행 함수
  Future<void> lanchtourl(input_url) async {
    final Uri url = Uri.parse(input_url);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $input_url';
    }
  }

  Future<void> goToUrl(String url) async {
    final Uri uri = Uri.parse(url); // 문자열을 Uri 객체로 변환
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      // URL 실행 실패 처리
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to load video: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "여행 영상",
              style: style.textTheme.displayLarge,
            ),
            SizedBox(width: 3.w),
          ],
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () async {
                    goToUrl(youtube1);
                  },
                  child: Container(
                    width: 22.w * 7,
                    height: 11.h * 7.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0XFF2266FF),
                      image: DecorationImage(
                        image: AssetImage('images/youtube_thumbnail1.jpg'),
                        // 이미지
                        fit: BoxFit.fitWidth, // 이미지를 꽉 채우기
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2.h),
                  width: 22.w * 7, // 텍스트가 자동으로 줄바뀌도록 컨테이너의 너비를 제한
                  child: Text(
                    "[sub]11월에 놓치면 후회하는 여행지(기가 막힌 곳만 모아 놓음.zip)",
                    style: TextStyle(fontSize: 12.sp),
                    maxLines: 2, // 최대 2줄까지만 표시
                    overflow: TextOverflow.ellipsis, // 초과된 텍스트는 '...'으로 표시
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 5.w,
            ),
            InkWell(
              onTap: () async {
                goToUrl(youtube2);
              },
              child: Column(
                children: [
                  Container(
                    width: 22.w * 7,
                    height: 11.h * 7.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0XFF2266FF),
                      image: DecorationImage(
                        image: AssetImage('images/youtube_thumbnail2.jpg'),
                        // 이미지
                        fit: BoxFit.fitWidth, // 이미지를 꽉 채우기
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    width: 22.w * 7, // 텍스트가 자동으로 줄바뀌도록 컨테이너의 너비를 제한
                    child: Text(
                      "영화 아니고 여행 동영상입니다 ver.2 I 국내여행지 강릉 Gangneung",
                      style: TextStyle(fontSize: 12.sp),
                      maxLines: 2, // 최대 2줄까지만 표시
                      overflow: TextOverflow.ellipsis, // 초과된 텍스트는 '...'으로 표시
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
