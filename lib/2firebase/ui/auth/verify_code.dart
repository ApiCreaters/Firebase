import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/utils.dart';
import '../../widget/round_btn.dart';
import '../posts/post_screen.dart';
import '../tabar.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;

  const VerifyCodeScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final verifyCodeController = TextEditingController();
  bool loding = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Varifiy"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            const SizedBox(height: 80),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: verifyCodeController,
              decoration: InputDecoration(
                hintText: '6 digit code',
              ),
            ),
            const SizedBox(height: 50),
            RoundButton(loading: loding, title: "Login", VoidCallback: () async {
              setState(() {
                loding = true;
              });
              final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verifyCodeController.text.toString()
              );
              try {
                await auth.signInWithCredential(credential);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavigationBarss()));

              }catch(e){
                setState(() {
                  loding = false;
                });
                Utils().toastMessage(e.toString());
              }
            })
          ],
        ),
      ),
    );
  }
}
