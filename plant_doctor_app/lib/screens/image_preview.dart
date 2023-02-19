import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:plant_doctor_app/providers/disease_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/disease_provider.dart';

class ImagePreview extends StatelessWidget {
  final String imagePath;
  const ImagePreview({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: const Text('About'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  File(imagePath),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: DiseaseDetailsWidget(
                  imagePath: imagePath,
                ),
              ),
            ),
          ),
        ],
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
    return SingleChildScrollView(
      child: FutureBuilder(
        future: DiseaseProvider.detectDisease(imagePath),
        builder: (context, disease) {
          if (disease.hasData) {
            DiseaseDetails diseaseDetails = disease.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      diseaseDetails.plantName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Disease: ',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      children: [
                        if (diseaseDetails.diseaseName.contains("healthy"))
                          const TextSpan(
                            text: "Plant is healthy",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          )
                        else
                          TextSpan(
                            text: diseaseDetails.diseaseName,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Remedies:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...diseaseDetails.remedies
                      .map((text) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text("• $text"),
                          ))
                      .toList(),

                  const SizedBox(height: 15),
                  const Text(
                    "Prevention:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...diseaseDetails.prevention
                      .map((text) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text("• $text"),
                          ))
                      .toList(),
                  const SizedBox(height: 15),
                  const Text(
                    "Fertilizers: ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...diseaseDetails.fertilizer.entries
                      .map(
                        (entry) => GestureDetector(
                          onTap: () async {
                            final url = Uri.parse(entry.value);
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  // TODO: Add fertilizer and pesticide recommendation
                ],
              ),
            );
          } else {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(50.0),
              child: CircularProgressIndicator(),
            ));
          }
        },
      ),
    );
  }
}
