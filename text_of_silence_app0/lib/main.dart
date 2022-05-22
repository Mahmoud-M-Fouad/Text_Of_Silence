import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_of_silence_app0/screens/SplashScreen.dart';
import 'package:text_of_silence_app0/screens/home_screen.dart';
import 'package:text_of_silence_app0/screens/video_screen.dart';
import 'package:text_of_silence_app0/theme/theme.dart';
import 'controllers/Provider.dart';
import 'controllers/color.dart';

void main() async{
  runApp(const SplashScreen());
}
class MyTOS extends StatelessWidget {

  const MyTOS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          backgroundColor: Colors.black,
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
          textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
            buttonTheme: const ButtonThemeData(
              buttonColor: Colors.white,
                textTheme: ButtonTextTheme.primary
            )
        ),
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider (create: (_) => MyProvider()),
            ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
          ],
        child :const HomeScreenTOS(),
          //child :const VideoScreen(),
      ),
    );
  }
}
