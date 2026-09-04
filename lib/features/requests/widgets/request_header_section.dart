// import 'package:edu_advisor/core/theme/app_theme_colors.dart';
// import 'package:edu_advisor/features/requests/models/student_requests.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class RequestHeaderSection extends StatelessWidget {
//   final StudentRequest request;

//   const RequestHeaderSection({
//     super.key,
//     required this.request,
//   });

//   Color _getStatusColor(BuildContext context) {
//     switch (request.status) {
//       case 2:
//         return context.themeColors.success;

//       case 1:
//         return context.themeColors.warning;

//       case 3:
//       default:
//         return context.colorScheme.error;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           '${request.semesterName} Requests',
//           style: TextStyle(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           'STATUS: ${request.statusName.toUpperCase()}',
//           style: TextStyle(
//             color: _getStatusColor(context),
//             fontWeight: FontWeight.bold,
//             fontSize: 12.sp,
//           ),
//         ),
//       ],
//     );
//   }
// }