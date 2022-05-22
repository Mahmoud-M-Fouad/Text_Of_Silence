import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_of_silence_app0/screens/sentence_structure_screen.dart';
import 'package:text_of_silence_app0/screens/video_screen.dart';
import '../controllers/Provider.dart';
import '../controllers/drawer.dart';
import 'Home.dart';

class HomeScreenTOS extends StatefulWidget {
   const HomeScreenTOS({Key? key}) : super(key: key);

  @override
  _HomeScreenTOSState createState() => _HomeScreenTOSState();
}

class _HomeScreenTOSState extends State<HomeScreenTOS> {

  static int index =0;
  void  selectIndex(int i)
  {
    setState(() {
      index = i;
      // context.read<MyProvider>().setindex(index);
      Provider.of<MyProvider>(context,listen: false).setindex(i);
    });
  }
  static const List<Widget> pagesVedio = <Widget>[
    Home(),VideoScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pagesVedio.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectIndex,
        currentIndex: index,
        iconSize: 20,
        selectedFontSize: 20,
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        elevation: 100,
        showUnselectedLabels: false,
        unselectedIconTheme:const IconThemeData(
          color: Colors.white,

        ),
        selectedIconTheme: const IconThemeData(color: Colors.white),

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_enhance_outlined),
            label: 'Video Capture',
          ),

        ],
      ),
      drawer: const DrawerClass(),
    );
  }
}




