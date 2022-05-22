import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../theme/theme.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.grey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:Colors.grey ,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black54,
          toolbarHeight: 100, // default is 56
          toolbarOpacity: 0.5,
          title: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText('Text Of Silence',textStyle: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
              TyperAnimatedText('Text Of Silence',textStyle: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
              TyperAnimatedText('Start App',textStyle: const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),

            ],
            onTap: () {print("Tap Event");},
          ),
          elevation: 0,
        ),
        body: AnimatedSplashScreen(

        duration: 3002,
        splash:Image.asset('images/imgTos.jpg',height: 300,width: 300,fit: BoxFit.fitHeight  ,),
          splashIconSize:300 ,
          //splash: const Icon(Icons.videocam),
          nextScreen: const MyTOS(),
          splashTransition: SplashTransition.sizeTransition,
          pageTransitionType: PageTransitionType.leftToRight,
          backgroundColor: Colors.black54,
          centered:true ,
          curve: Curves.bounceInOut,
        ),
      ),
    );
  }
}