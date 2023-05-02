import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlites/2firebase/Utils/utils.dart';
import 'package:sqlites/2firebase/ui/auth/verify_code.dart';
import 'package:sqlites/2firebase/widget/round_btn.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNumberController = TextEditingController();
  bool loding = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logins"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,),
        child: Column(
          children: [
            const SizedBox(height: 80),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: '+1 123 456 7890',
              ),
            ),
            const SizedBox(height: 50),
            RoundButton(loading: loding,
                title: "Login", VoidCallback: (){
              setState(() {
                loding = true;
              });
              auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_){
                    setState(() {
                      loding = false;
                    });
                  },
                  verificationFailed: (e){
                  Utils().toastMessage(e.toString());
                    setState(() {
                      loding = false;
                    });
                  },
                  codeSent: (String verification, int? toeken){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyCodeScreen(verificationId: verification,)));
                    setState(() {
                      loding = false;
                    });
                  },
                  codeAutoRetrievalTimeout: (e1){
                    Utils().toastMessage(e1.toString());
                    setState(() {
                      loding = false;
                    });
                  }
              );
            })

          ],
        ),
      ),
    );
  }
}
