// import '../widgets/photo_button.dart';

// import './../screens/image_search.dart';

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common/global_context.dart';
import 'screens/home_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return NeumorphicApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: const Color(0xffedf3fa),
        lightSource: LightSource.topLeft,
        shadowLightColor: Colors.white,
        textTheme: GoogleFonts.notoSansTextTheme(),
        shadowDarkColor: const Color.fromARGB(255, 192, 205, 220),
        iconTheme: const IconThemeData(color: Color(0xff112a42)),
        defaultTextColor: const Color(0xff112a42),
        appBarTheme: const NeumorphicAppBarThemeData(
          centerTitle: true,
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xff112a42),
          ),
        ),
        buttonStyle: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        ),
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        intensity: .9,
        depth: 4,
      ),
      home: const MyHomePage(),
    );
  }
}
