import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:plant_doctor_app/common/image_picker.dart';

import 'camera_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildHeading(),
              buildMenu(context),
              // TODO: Latest Fertilizer Recommendation
            ],
          ),
        ),
      ),
    );
  }

  Padding buildHeading() {
    return Padding(
      padding: const EdgeInsets.only(top: 160, bottom: 120),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Plant Doctor",
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
            color: Colors.red.shade800,
          ),
        ],
      ),
    );
  }

  SizedBox buildMenu(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildItem(
            text: "Upload Image",
            icon: Icons.upload_file_rounded,
            onPressed: () {
              chooseImageFromGallery();
            },
          ),
          const SizedBox(width: 20),
          buildItem(
            text: "Scan for Disease",
            icon: Icons.camera_enhance_rounded,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CameraScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Expanded buildItem({
    required String text,
    required IconData icon,
    void Function()? onPressed,
  }) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: NeumorphicButton(
            onPressed: onPressed,
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
            ),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 35),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      text,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
