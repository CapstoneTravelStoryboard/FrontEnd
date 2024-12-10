import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tripdraw/style.dart' as style;

class EditView extends StatefulWidget {
  final String initialTitle;
  final String initialDate;
  final String initialDestination;
  final Function(String title, String date) onSave;

  const EditView({
    Key? key,
    required this.initialTitle,
    required this.initialDate,
    required this.initialDestination,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _destinationController;

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    print(widget.initialDate);
    _titleController = TextEditingController(text: widget.initialTitle);
    _dateController = TextEditingController(text: widget.initialDate);
    _destinationController =
        TextEditingController(text: widget.initialDestination);
    if (widget.initialDate.isNotEmpty) {
      selectedDate =
          DateTime.tryParse(widget.initialDate); // String을 DateTime으로 변환
      if (selectedDate == null) {
        print('Invalid date format: ${widget.initialDate}');
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _onDateSelected(DateTime selectedDate) {
    setState(() {
      this.selectedDate = selectedDate;
      _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // 스크롤 가능하도록 수정
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 50.h, 20.w, 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '스토리보드 정보수정',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '수정 후 저장을 눌러야 반영됩니다',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: '제목'),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: _dateController,
                readOnly: true, // 날짜는 직접 입력할 수 없도록 설정
                decoration: InputDecoration(
                  labelText: '여행 날짜',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 20.h),
              SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.single,
                initialSelectedDate: selectedDate,
                initialDisplayDate: selectedDate ?? DateTime.now(),
                onSelectionChanged: (args) {
                  if (args.value is DateTime) {
                    _onDateSelected(args.value); // 날짜 선택 시 즉시 반영
                  }
                },
                headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: Colors.transparent, // 헤더 배경색 제거
                  textStyle:
                      TextStyle(color: Colors.blueAccent, fontSize: 16.sp),
                ),
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width, // 버튼의 가로 크기를 화면 너비에 맞춤
          child: ElevatedButton(
            onPressed: () {
              widget.onSave(
                _titleController.text,
                _dateController.text,
              );
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: style.mainColor,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              '저장',
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
