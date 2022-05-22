import 'package:flutter/material.dart';
//import 'package:avatars/avatars.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var height =  MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child:ListView(
            children: [
              Container(
                height: height,
                  child: Image.asset("assets/background.jpg",fit: BoxFit.fill,height:double.infinity)),
              //const SizedBox(height: 50,),
              ////AnimatedTextKitFunction2(),
              //Text("Your lip reading assistant ",style: TextStyle(fontSize: 20),),
              //Text("Press the button below to start the app",style: TextStyle(fontSize: 20)),
              //const Divider(color: Colors.amber,height: 5,thickness: 1),
              //const SizedBox(height: 80,),
              //Image.asset("assets/img.png",height: 300,width: 300,),
              //Text('Vedio Picker'),





            ],
          ),
        )

    );
  }
}
Widget AnimatedTextKitFunction2() {
  return DefaultTextStyle(
    style: const TextStyle(
      fontSize: 30.0,
      fontFamily: 'Bobbers',
    ),
    child: AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText('Text Of Silence',speed: Duration(milliseconds: 200),
          curve: Curves.slowMiddle,
        ),
        ScaleAnimatedText('TOS'),
        TyperAnimatedText('Text Of Silence',speed: Duration(milliseconds: 200),
          curve: Curves.slowMiddle,
        ),
        ScaleAnimatedText('TOS'),
        TyperAnimatedText('Text Of Silence',speed: Duration(milliseconds: 200),
          curve: Curves.slowMiddle,
        ),
        ScaleAnimatedText('TOS')

      ],
      onTap: () {
        print("Tap Event");
      },
    ),
  );
}