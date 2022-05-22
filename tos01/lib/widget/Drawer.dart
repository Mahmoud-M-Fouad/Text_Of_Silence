import 'package:flutter/material.dart';

import '../main.dart';

class DrawerClass{

  Drawer drawerMethod(BuildContext ctx)
  {

    int _selectedDestination = 0;
    void selectDestination(int index) {
      /*  setState(() {
      _selectedDestination = index;
    });*/
    }
    return Drawer(
      backgroundColor: Colors.blueGrey,
      elevation: 20,
      child: ListView(
        children:  [
          const Padding(
            padding: EdgeInsets.all(25),
            child: ListTile(
              title: Text('Text Of Silence'),
              subtitle: Text('TOS'),
              leading: Image(image: AssetImage('assets/icon.jpg'),),
            ),
          ),
          const Divider(color: Colors.amber,height: 5,thickness: 1),
          const SizedBox(height: 5,),
          ListTile(
            title: const Text('Title 1',),
            trailing: const Icon(Icons.navigate_next),
            leading: const Icon(Icons.navigate_next),
            selected: _selectedDestination == 0,
            onTap: () => selectDestination(0),
          ),
          const Divider(color: Colors.amber,height: 5,thickness: 1),
          const SizedBox(height: 5,),
          ListTile(
            title: const Text('Title 1',),
            trailing: const Icon(Icons.navigate_next),
            leading: const Icon(Icons.navigate_next),
            selected: _selectedDestination == 1,
            onTap: () => selectDestination(1),
          ),
          const Divider(color: Colors.amber,height: 5,thickness: 1),
          const SizedBox(height: 5,),
          ListTile(
            title: const Text('Title 1',),
            trailing: const Icon(Icons.navigate_next),
            leading: const Icon(Icons.navigate_next),
            selected: _selectedDestination == 2,
            onTap: () => selectDestination(2),
          ),
          const Divider(color: Colors.amber,height: 5,thickness: 1),
          const SizedBox(height: 5,),
          ListTile(
            title: const Text('Title 1',),
            trailing: const Icon(Icons.navigate_next),
            leading: const Icon(Icons.navigate_next),
            selected: _selectedDestination == 3,
            onTap: () => selectDestination(3),
          ),

          const Divider(color: Colors.amber,height: 5,thickness: 1),
          const SizedBox( height: kToolbarHeight,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Expanded(child: Align(
                alignment: FractionalOffset.center,
                child: FloatingActionButton(
                    heroTag: "btn1",
                    child: const Icon(Icons.home),
                    onPressed: (){
                      // Navigator.push(context, HomeScreen());
                      Navigator.pushReplacement(
                        ctx,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );
                    }),
              ),
              ),
              Expanded(child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: FloatingActionButton(
                    heroTag: "btn2",
                    child: const Icon(Icons.logout),
                    onPressed: (){
                      // exit(1);
                    }),

              ),
              ),

            ],
          ),

        ],
      ),

    );


  }
}