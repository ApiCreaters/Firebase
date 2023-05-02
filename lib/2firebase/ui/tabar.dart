import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlites/2firebase/ui/posts/post_screen.dart';
import 'package:sqlites/2firebase/ui/ulpload_image.dart';

import 'firestore/firestore_list_screen.dart';

class NavigationBarss extends StatefulWidget {
  const NavigationBarss({Key? key}) : super(key: key);

  @override
  State<NavigationBarss> createState() => _NavigationBarssState();
}

class _NavigationBarssState extends State<NavigationBarss> {
  int _selected = 0;
  static const List _widgetOptions = [
    PostScreen(),
    FireStoreScreen(),
    UploadImageScreen()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selected = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selected),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_sharp),
            label: 'Realtime Database',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'FireStore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file_outlined),
            label: 'Upload Image',
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selected,
        selectedItemColor: Colors.white,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 10,
      ),
    );
  }
}
