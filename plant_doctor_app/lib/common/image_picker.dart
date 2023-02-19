import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:plant_doctor_app/common/global_context.dart';
import 'package:plant_doctor_app/providers/disease_provider.dart';

import '../screens/image_preview.dart';

Future<void> chooseImageFromGallery() async {
  // final ImagePicker picker = ImagePicker();
  // XFile? image = await picker.pickImage(source: ImageSource.gallery);
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    final String imagePath = result.files.single.path ?? "";
    // } else {
    //   // User canceled the picker
    // }
    // if (image != null) {
    // final String imagePath = image.path;
    log("imagePath =  $imagePath");

    final diseaseDetails =
        DiseaseProvider.detectDisease(imagePath).then((value) {
      log("value : $value");
    });

    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => ImagePreview(imagePath: imagePath),
      ),
    );
  }
}
