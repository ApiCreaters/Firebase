import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/2firebase/ui/posts/post_screen.dart';
import 'package:sqlite/2firebase/ui/tabar.dart';
import 'package:sqlite/2firebase/ui/ulpload_image.dart';

import 'auth/login_screen.dart';
import 'firestore/firestore_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Firebase App",style: TextStyle(color: Colors.white),textScaleFactor: 2)),
    );
  }
}


class SplashServices{

  void isLogin(BuildContext context) {

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null) {
      Timer.periodic(const Duration(seconds: 2), (timer){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationBarss()));
      });
    }else{
      Timer.periodic(const Duration(seconds: 2), (timer){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }


  }
}
