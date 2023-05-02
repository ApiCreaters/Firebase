import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlites/2firebase/Utils/utils.dart';
import 'package:sqlites/2firebase/widget/round_btn.dart';

class ForegotPasswordScreen extends StatefulWidget {
  const ForegotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForegotPasswordScreen> createState() => _ForegotPasswordScreenState();
}

class _ForegotPasswordScreenState extends State<ForegotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email'
              ),
            ),
            SizedBox(height: 40,),
            RoundButton(title: 'Forgot', VoidCallback: (){
              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){

                Utils().toastMessage("We have sent you email to recover password, please check email");
              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
              });
            }),
          ],
        ),
      ),
    );
  }
}
