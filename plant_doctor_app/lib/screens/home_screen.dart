import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:plant_doctor_app/common/image_picker.dart';
import 'package:plant_doctor_app/providers/disease_provider.dart';
import 'package:plant_doctor_app/screens/feedback_screen.dart';
import 'package:provider/provider.dart';

import '../components/menu_item.dart';
import 'build_fertilizer_screen.dart';
import 'camera_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  child: buildSwitchIcon(context),
                ),
                buildHeading(),
                buildMenu1(context),
                Selector<DiseaseProvider, bool>(
                  selector: (_, provider) => provider.offline,
                  builder: (_, offline, __) =>
                      !offline ? buildMenu2(context) : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  NeumorphicButton buildSwitchIcon(BuildContext context) {
    return NeumorphicButton(
      margin: const EdgeInsets.symmetric(vertical: 20),
      onPressed: () {
        context.read<DiseaseProvider>().toggleServer();
      },
      child: SizedBox(
        height: 30,
        child: Selector<DiseaseProvider, bool>(
          selector: (_, provider) => provider.offline,
          builder: (_, offline, __) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (offline) ...[
                const Icon(Icons.cloud_off_rounded),
                const SizedBox(width: 15),
                const Text("Offline")
              ] else ...[
                const Icon(Icons.cloud_outlined),
                const SizedBox(width: 15),
                const Text("Cloud")
              ]
            ],
          ),
        ),
      ),
    );
  }

  Padding buildHeading() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Dr. Plant",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xff112a42),
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            Icons.local_hospital_rounded,
            size: 30,
            color: Colors.green.shade700,
          ),
        ],
      ),
    );
  }

  SizedBox buildMenu1(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MenuItem(
              text: "Upload Image",
              icon: Icons.upload_file_rounded,
              onPressed: () {
                chooseImageFromGallery();
              }),
          const SizedBox(width: 20),
          MenuItem(
              text: "Scan for Disease",
              icon: Icons.camera_enhance_rounded,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CameraScreen(),
                  ),
                );
              }),
        ],
      ),
    );
  }

  SizedBox buildMenu2(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MenuItem(
              text: "Latest Fertilizers",
              icon: Icons.newspaper,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FertilizerScreen(),
                  ),
                );
              }),
          const SizedBox(width: 20),
          MenuItem(
              text: "Feedback",
              icon: Icons.question_answer_rounded,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FeedbackScreen(),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
