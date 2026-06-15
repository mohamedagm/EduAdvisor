import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

class AppToast {
  const AppToast._();

  static void success(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    CherryToast.success(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      description: Text(description),
      animationType: AnimationType.fromTop,
      action: const Text('OK', style: TextStyle(color: Colors.green)),
    ).show(context);
  }

  static void error(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    CherryToast.error(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      description: Text(description),
      animationType: AnimationType.fromTop,
    ).show(context);
  }
}
