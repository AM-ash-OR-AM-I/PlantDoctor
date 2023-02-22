import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart';

import 'disease_model.dart';

class DiseaseProvider with ChangeNotifier {
  static const onlineServer = "http://api.shubhendra.in/";
  static const offlineServer = "http://192.168.5.1/";

  static String currentServer = onlineServer;
  bool _offline = false;

  bool get offline => _offline;

  void toggleServer() {
    _offline = !_offline;
    if (offline) {
      currentServer = offlineServer;
    } else {
      currentServer = onlineServer;
    }
    notifyListeners();
  }

  static Future<DiseaseDetails> detectDisease(String imagePath) async {
    // TODO: add switch for offline and online server
    final url = Uri.parse(currentServer);
    final image = await File(imagePath).readAsBytes();
    String base64Image = base64Encode(image);
    final request = await post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'image': base64Image}),
    );
    log("request.body : ${request.body}");
    return DiseaseDetails.fromJson(
        jsonDecode(request.body).cast<String, dynamic>());
  }
}
