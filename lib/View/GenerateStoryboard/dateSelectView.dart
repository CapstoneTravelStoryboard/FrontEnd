import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
class DateSelectView extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime start, DateTime end) onDateSelected;

  const DateSelectView({
    Key? key,
    required this.initialStartDate,
    required this.initialEndDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<DateSelectView> createState() => _DateSelectViewState();
}

class _DateSelectViewState extends State<DateSelectView> {
  late DateTime? startDate;
  late DateTime? endDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      setState(() {
        startDate = args.value.startDate;
        endDate = args.value.endDate ?? args.value.startDate;
      });
      widget.onDateSelected(startDate!, endDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '여행 날짜',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: startDate != null && endDate != null
                    ? '${DateFormat('yyyy-MM-dd').format(startDate!)} - ${DateFormat('yyyy-MM-dd').format(endDate!)}'
                    : '여행 날짜를 선택하세요',
              ),
              readOnly: true,
            ),
            SizedBox(height: 10),
            SizedBox(
              // width: constraints.maxWidth * 0.8,
              // height: constraints.maxHeight * 0.6,
              child: SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.range,
                onSelectionChanged: _onSelectionChanged,
                initialSelectedRange: startDate != null && endDate != null
                    ? PickerDateRange(startDate, endDate)
                    : null,
                headerStyle: DateRangePickerHeaderStyle(
                  textStyle: TextStyle(color: Colors.blueAccent, fontSize: 16.sp), // 헤더 텍스트 스타일
                  backgroundColor: Colors.white // 헤더 배경색
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}

