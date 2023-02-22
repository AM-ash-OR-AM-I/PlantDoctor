import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class Fertilizer {
  final String name;
  final String image;
  final String description;
  final String price;
  final String link;

  Fertilizer({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.link,
  });

  factory Fertilizer.fromJson(Map<String, dynamic> json) {
    return Fertilizer(
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
      link: json['link'],
    );
  }

  static Future<List<Fertilizer>> getFertilizers() async {
    String data = await rootBundle.loadString('assets/fertilizers_data.json');
    List<dynamic> dataLoaded = jsonDecode(data);
    List<Fertilizer> fertilizers = [];

    for (int i = 0; i < dataLoaded.length; i++) {
      fertilizers.add(
        Fertilizer.fromJson(dataLoaded[i]),
      );
    }
    return fertilizers;
  }
}
