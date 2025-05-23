// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sathuh/core/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';

class AddImages extends StatefulWidget {
  const AddImages({super.key});

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    _loadSavedImages();
  }

  Future<void> _loadSavedImages() async {
    final prefs = await SharedPreferences.getInstance();
    final paths = prefs.getStringList('saved_images') ?? [];
    setState(() {
      _images = paths.map((path) => File(path)).toList();
    });
  }

  Future<void> _saveImagePaths() async {
    final prefs = await SharedPreferences.getInstance();
    final paths = _images.map((file) => file.path).toList();
    await prefs.setStringList('saved_images', paths);
  }

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      final newImages = result.paths.map((path) => File(path!)).toList();
      setState(() {
        _images.addAll(newImages);
      });
      await _saveImagePaths();
    }
  }

  void _removeImage(int index) async {
    setState(() {
      _images.removeAt(index);
    });
    _saveImagePaths();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24.h),
        _images.isEmpty
            ? Center(
              child: AppText(
                text: LocaleKeys.no_saved_images.tr(),
                size: 18.sp,
                fontWeight: FontWeight.bold,
                bottom: 16.h,
              ),
            )
            : SizedBox(
              height: 200,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                itemCount: _images.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.file(
                          _images[index],
                          width: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: InkWell(
                          onTap: () => _removeImage(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
        SizedBox(height: 10.h),
        ElevatedButton(
          onPressed: _pickImages,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(AppColors.primary),
          ),
          child: AppText(
            text: LocaleKeys.add_images.tr(),
            size: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
