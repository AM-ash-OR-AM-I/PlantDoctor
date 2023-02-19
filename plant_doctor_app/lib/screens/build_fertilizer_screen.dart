import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class FertilizerScreen extends StatelessWidget {
  const FertilizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: const Text("Feedback"),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
        ),
        children: const [],
      ),
    );
  }
}
