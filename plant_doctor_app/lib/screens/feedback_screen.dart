import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: const Text('Feedback'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "We'd love to hear from you!",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 30),
          Stack(
            children: [
              Neumorphic(
                margin: const EdgeInsets.all(20),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                style: NeumorphicStyle(
                  depth: -5,
                  shadowDarkColorEmboss: Colors.grey.withOpacity(.6),
                  shadowLightColorEmboss: Colors.white,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(35)),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your feedback',
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: NeumorphicButton(
                  onPressed: () {},
                  margin:
                      const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  style: NeumorphicStyle(
                    boxShape: const NeumorphicBoxShape.circle(),
                    shadowDarkColorEmboss: Colors.grey.withOpacity(.6),
                    shadowLightColorEmboss: Colors.white,
                  ),
                  child: const Icon(Icons.send),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
