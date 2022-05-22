import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, theme, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.getTheme(),
          home:Scaffold(
            appBar: AppBar(
              title: const Text('Text Of Silence'),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        if(theme.getTheme()==theme.darkTheme) {
                          theme.setLightMode();
                        }
                        else
                          {
                            theme.setDarkMode();
                          }
                      });
                    }, icon: (theme.getTheme()==theme.darkTheme)?const Icon(Icons.wb_sunny_outlined):
                const Icon(Icons.nightlight_round)
                ),
              ],
            ),
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 50,),
                    const Text('Welcome to TOS', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50,),
                    Expanded(child: Image.asset('images/background.jpg', width: 200.0,),),
                    const SizedBox(height: 50,),
                    const Expanded(child: Text(
                      'Your Lip Reading Assistant',
                      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),),
                    const SizedBox(height: 50,),
                  ],
                ),
              ),
            ),
          )
        ),
                );
  }
}
