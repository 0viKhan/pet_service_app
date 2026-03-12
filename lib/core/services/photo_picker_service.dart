import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerService extends GetxService {
  final RxList<File> imageList = <File>[].obs;
  final ImagePicker _picker = ImagePicker();

  final List<String> allowedExtensions = [
    'jpg',
    'jpeg',
    'png',
    'heic',
    'webp',
  ];

  get EasyLoading => null;

  bool _isImageFile(String path) {
    final ext = path.split('.').last.toLowerCase();
    return allowedExtensions.contains(ext);
  }

  Future<File?> _pickImage({
    required ImageSource source,
    bool compress = true,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: compress ? 70 : 100,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFile == null) {
        EasyLoading.showError('No image selected!');
        return null;
      }

      if (!_isImageFile(pickedFile.path)) {
        EasyLoading.showError('Only image files are allowed!');
        return null;
      }

      final file = File(pickedFile.path);
      _addImageToList(file);
      return file;
    } catch (e) {
      EasyLoading.showError('Failed to pick image');
      return null;
    }
  }

  Future<File?> pickFromGallery({bool compress = true}) async {
    return _pickImage(
      source: ImageSource.gallery,
      compress: compress,
    );
  }

  Future<File?> pickFromCamera({bool compress = true}) async {
    return _pickImage(
      source: ImageSource.camera,
      compress: compress,
    );
  }

  Future<List<File>> pickMultipleImages({bool compress = true}) async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: compress ? 70 : 100,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFiles.isEmpty) {
        EasyLoading.showError('No images selected!');
        return [];
      }

      final validFiles = pickedFiles
          .where((file) => _isImageFile(file.path))
          .map((file) => File(file.path))
          .toList();

      if (validFiles.isEmpty) {
        EasyLoading.showError('Only image files are allowed!');
        return [];
      }

      for (final file in validFiles) {
        _addImageToList(file);
      }

      return validFiles;
    } catch (e) {
      EasyLoading.showError('Failed to pick images');
      return [];
    }
  }

  void _addImageToList(File file) {
    if (!imageList.any((f) => f.path == file.path)) {
      imageList.add(file);
    }
  }

  void removeImage(File file) {
    imageList.removeWhere((f) => f.path == file.path);
  }

  void clearAllImages() {
    imageList.clear();
  }
}
