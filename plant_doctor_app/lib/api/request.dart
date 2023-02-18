import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class DiseaseDetails {
  final String plantName;
  final String diseaseName;
  final String remedy;
  final String fertilizer =
      "Fertilizer Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever";

  final fertilzerImage = "assets/images/fertilizer.jpg";

  DiseaseDetails({
    required this.plantName,
    required this.diseaseName,
    required this.remedy,
  });

  factory DiseaseDetails.fromJson(Map<String, dynamic> json) {
    return DiseaseDetails(
      plantName: json['plant'],
      diseaseName: json['disease'],
      remedy: json['remedy'],
    );
  }
  static Future<DiseaseDetails> detectDisease(String imagePath) async {
    final url = Uri.parse('http://192.168.29.85:8080');
    final image = await File(imagePath).readAsBytes();
    String base64Image = base64Encode(image);
    final request = await post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'image': base64Image}),
    );
    return DiseaseDetails.fromJson(
        jsonDecode(request.body).cast<String, dynamic>());
  }
}
