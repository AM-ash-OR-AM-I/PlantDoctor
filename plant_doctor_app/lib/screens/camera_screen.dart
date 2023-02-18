import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plant_doctor_app/common/image_picker.dart';

import '../api/request.dart';
import 'image_preview.dart';

enum Camera { backCamera, frontCamera }

class CameraScreen extends StatefulWidget {
  static const String route = '/CameraPage';

  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  Camera chosenCamera = Camera.backCamera;
  late CameraController _controller;
  // late CameraController _controller;

  Future<void> _initCameraController(
      CameraDescription cameraDescription) async {
    log("started");
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (_controller.value.hasError) {
        log('Camera error ${_controller.value.errorDescription}');
      }
    });

    try {
      await _controller.initialize();
    } on CameraException catch (e) {
      log(e.toString());
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      CameraDescription firstCamera = cameras.first;
      await _initCameraController(firstCamera);
    } catch (e) {
      log('******** CAMERA ERROR $e*********');
    }
  }

  Future<void> _takePhoto() async {
    try {
      final navigatorKey = GlobalKey<NavigatorState>();
      final String imagePath =
          '${(await getTemporaryDirectory()).path}/${DateTime.now()}.png';
      setState(() {});

      var picture = await _controller.takePicture(); //take photo
      picture.saveTo(imagePath);

      log("hurraahhh  : $imagePath");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreview(imagePath: imagePath),
        ),
      );

      DiseaseDetails.detectDisease(imagePath).then((value) {
        log("value : $value");
      });
    } catch (e) {
      log('************ ERROR : $e *******************');
    }
  }

  Future<void> _switchCamera() async {
    switch (chosenCamera) {
      case Camera.backCamera:
        chosenCamera = Camera.frontCamera;
        setState(() {});
        break;
      case Camera.frontCamera:
        chosenCamera = Camera.backCamera;
        setState(() {});
        break;
    }
    await _initCameraController(cameras[chosenCamera.index]);
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive) {
      _controller.initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: Stack(
            children: [
              NeumorphicButton(
                margin: const EdgeInsets.only(left: 10),
                onPressed: () => Navigator.pop(context),
                style: const NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 0,
                ),
                child: const Icon(Icons.arrow_back),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Transform.scale(
                  scale: 1,
                  child: CameraPreview(_controller), //cameraPreview
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: IconButton(
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () => chooseImageFromGallery(),
                        icon: const Icon(Icons.image),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: IconButton(
                          onPressed: _takePhoto,
                          iconSize: 70,
                          color: Colors.white,
                          icon: const Icon(Icons.circle),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: IconButton(
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: _switchCamera,
                        icon: const Icon(Icons.sync),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        //
      ),
    );
  }
}
