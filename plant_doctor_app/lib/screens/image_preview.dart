import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:plant_doctor_app/api/request.dart';

class ImagePreview extends StatelessWidget {
  final String imagePath;
  const ImagePreview({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    File(imagePath),
                  ),
                ),
              ),
            ),
            DiseaseDetailsWidget(imagePath: imagePath),
          ],
        ),
      ),
    );
  }
}

class DiseaseDetailsWidget extends StatelessWidget {
  const DiseaseDetailsWidget({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DiseaseDetails.detectDisease(imagePath),
      builder: (context, disease) {
        if (disease.hasData) {
          DiseaseDetails diseaseDetails = disease.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text(imagePath.split('/').last)),
                Center(
                  child: Text(
                    diseaseDetails.plantName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    text: 'Disease: ',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: diseaseDetails.diseaseName,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Remedy:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  diseaseDetails.remedy,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
