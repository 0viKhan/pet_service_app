import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/photo_picker_service.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final PhotoPickerService photoPickerService;

  const ImagePickerBottomSheet({
    super.key,
    required this.photoPickerService,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.blue),
            title: const Text('Pick from Gallery'),
            onTap: () async {
              final File? file = await photoPickerService.pickFromGallery();
              Get.back(result: file);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt, color: Colors.green),
            title: const Text('Take a Photo'),
            onTap: () async {
              Get.back();
              await Future.delayed(const Duration(milliseconds: 200));
              final file = await photoPickerService.pickFromGallery();
              debugPrint('picked file: ${file?.path}');
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_album_rounded, color: Colors.orange),
            title: const Text('Pick Multiple Images'),
            onTap: () async {
              final files = await photoPickerService.pickMultipleImages();
              Get.back(result: files.isNotEmpty ? files.first : null);
            },
          ),
          ListTile(
            leading: const Icon(Icons.close, color: Colors.red),
            title: const Text('Cancel'),
            onTap: () => Get.back(result: null),
          ),
        ],
      ),
    );
  }

  static Future<File?> show(
      BuildContext context, {
        required PhotoPickerService photoPickerService,
      }) async {
    return await showModalBottomSheet<File?>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (_) => ImagePickerBottomSheet(
        photoPickerService: photoPickerService,
      ),
    );
  }
}

class AppLightColors {
}