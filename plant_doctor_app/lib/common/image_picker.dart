import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_doctor_app/common/global_context.dart';

import '../api/request.dart';
import '../screens/image_preview.dart';

Future<void> chooseImageFromGallery() async {
  final ImagePicker picker = ImagePicker();
  XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    final String imagePath = image.path;
    log("imagePath =  $imagePath");

    final diseaseDetails =
        DiseaseDetails.detectDisease(imagePath).then((value) {
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
