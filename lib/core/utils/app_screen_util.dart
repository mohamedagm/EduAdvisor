import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class AppScreenUtil {
  static const designSize = Size(396, 920);
}

extension ResponsiveTextStyle on TextStyle {
  TextStyle get responsive => copyWith(fontSize: fontSize?.sp);
}
