import 'dart:io';

import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';

class CourseTreeImageView extends StatelessWidget {
  const CourseTreeImageView({super.key});

  static const String _assetPath = 'assets/tree.png';

  Future<void> _download(BuildContext context) async {
    try {
      final data = await rootBundle.load(_assetPath);
      final bytes = data.buffer.asUint8List();
      Directory? dir;
      try {
        dir = await getDownloadsDirectory();
      } catch (_) {
        dir = null;
      }
      dir ??= await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/tree.png');
      await file.writeAsBytes(bytes, flush: true);
      if (context.mounted) {
        AppToast.success(
          context,
          title: 'تم التحميل',
          description: file.path,
        );
      }
    } catch (e) {
      if (context.mounted) {
        AppToast.error(
          context,
          title: 'فشل التحميل',
          description: e.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'خريطة المقررات',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _download(context),
          ),
        ],
      ),
      body: PhotoView(
        imageProvider: const AssetImage(_assetPath),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 4,
      ),
    );
  }
}
