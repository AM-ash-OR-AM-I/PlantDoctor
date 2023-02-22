import 'dart:developer';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/fetch_fertilizer.dart';

class FertilizerScreen extends StatelessWidget {
  const FertilizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: const Text("Fertilizers"),
      ),
      body: FutureBuilder(
        future: Fertilizer.getFertilizers(),
        builder: (_, snapshot) {
          if (!(snapshot.hasData)) {
            log(snapshot.data.toString());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final fertilizers = snapshot.data!;
            return Center(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .6,
                ),
                children: (fertilizers + fertilizers).map<Widget>((fertilizer) {
                  return buildFertilizerItem(fertilizer);
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }

  Padding buildFertilizerItem(Fertilizer fertilizer) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: NeumorphicButton(
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(25),
          ),
          color: Colors.white,
          depth: 5,
          lightSource: LightSource.top,
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: GestureDetector(
            onTap: () async {
              final url = Uri.parse(fertilizer.link);
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  fertilizer.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(fertilizer.image),
                ),
                Text(
                  fertilizer.description,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  fertilizer.price,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
