import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class DiseaseDetails with ChangeNotifier {
  final String plantName;
  final String diseaseName;
  final List<String> remedies;
  final List<String> prevention;
  final Map<String, String> fertilizer;

  final fertilzerImage = "assets/images/fertilizer.jpg";

  DiseaseDetails({
    required this.plantName,
    required this.diseaseName,
    required this.remedies,
    required this.prevention,
    required this.fertilizer,
  });

  factory DiseaseDetails.fromJson(Map<String, dynamic> json) {
    return DiseaseDetails(
      plantName: json['disease'].toString().split("__")[0],
      diseaseName: (json['disease'] != null)
          ? json['disease']
              .toString()
              .replaceAll("___", " ")
              .split(" ")[1]
              .replaceAll("_", " ")
          : "No Disease Detected",
      remedies:
          (json['remedies'] != null) ? json['remedies'].cast<String>() : [],
      prevention:
          (json['prevention'] != null) ? json['prevention'].cast<String>() : [],
      fertilizer: (json['fertilizer'] != null)
          ? json['fertilizer'].cast<String, String>()
          : {},
    );
  }
}
