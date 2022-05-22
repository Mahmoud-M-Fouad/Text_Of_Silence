import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tos01/uploadVedio/VideoCapture.dart';
import 'package:tos01/uploadVedio/videopicker2.dart';
import 'package:tos01/widget/Drawer.dart';
import 'package:provider/provider.dart';
import 'Provider.dart';
import 'Screen/HomeScreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  /* await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: ChangeNotifierProvider(
          create: (_)=>MyProvider(),
          child: const MyHomeApp()),

    );

  }
}

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({Key? key}) : super(key: key);

  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  static int index =1;
  void selectIndex(int i)
  {
    setState(() {
      index = i;
      // context.read<MyProvider>().setindex(index);
      Provider.of<MyProvider>(context,listen: false).setindex(index);
    });
  }
  static const List<Widget> pagesVedio = <Widget>[
    VedioPicker2(),HomeScreen(),VedioPicker2()];
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body:  pagesVedio.elementAt(index),
      drawer: DrawerClass().drawerMethod(context),
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectIndex,
        currentIndex: index,
        iconSize: 20,
        selectedFontSize: 20,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.amberAccent,
        unselectedIconTheme:const IconThemeData(
          color: Colors.black87,

        ),
        selectedIconTheme: const IconThemeData(color: Colors.amberAccent),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_enhance_outlined),
            label: 'Pick Camera',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Pick Gallery',
          ),

        ],
      ),

    );

  }

}


