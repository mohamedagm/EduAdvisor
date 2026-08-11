import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyRequestsWidget extends StatelessWidget {
  const EmptyRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.w),
      child: Column(
        children: [
          Icon(Icons.inbox_outlined, size: 50.r),
          SizedBox(height: 10.w),
          Text('No requests found', style: TextStyle(fontSize: 14.sp)),
        ],
      ),
    );
  }
}
