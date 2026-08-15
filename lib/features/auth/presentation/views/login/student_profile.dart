import 'dart:io';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(File? selectedImage) onImageSelected;

  const ImagePickerWidget({super.key, required this.onImageSelected});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isPickingImage = false;

  Future<void> _pickImage() async {
    if (_isPickingImage) return;
    _isPickingImage = true;

    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (picked != null && mounted) {
        setState(() {
          _selectedImage = File(picked.path);
        });

        widget.onImageSelected(_selectedImage);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    } finally {
      _isPickingImage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 100.w,
        width: 100.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.themeColors.mutedSurface,
          border: Border.all(color: context.colorScheme.outline),
          image: _selectedImage != null
              ? DecorationImage(
                  image: FileImage(_selectedImage!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _selectedImage == null
            ? Icon(
                Icons.add_a_photo,
                size: 32.r,
                color: context.themeColors.textMuted,
              )
            : null,
      ),
    );
  }
}
