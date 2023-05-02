import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlites/2firebase/ui/auth/login_screen.dart';
import 'package:sqlites/2firebase/ui/posts/post_screen.dart';

import '../../Utils/utils.dart';
import '../../widget/round_btn.dart';
import '../tabar.dart';

class SignUpScaren extends StatefulWidget {
  const SignUpScaren({Key? key}) : super(key: key);

  @override
  State<SignUpScaren> createState() => _SignUpScarenState();
}

class _SignUpScarenState extends State<SignUpScaren> {
  final _fromField = GlobalKey<FormState>();
  var emaiCcontroller = TextEditingController();
  var passwordCcontroller = TextEditingController();
  bool loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Form(key: _fromField,
                child: Column(children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emaiCcontroller,
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Email address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwordCcontroller,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Password address";
                      }
                      return null;
                    },
                  ),
                ],)
            ),
            const SizedBox(height: 50,),
            RoundButton(loading: loading,
              title: "Sign Up",VoidCallback: (){
              if(_fromField.currentState!.validate()) {
                signUp();
              }
            },),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Text("Already have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                }, child: const Text("Login up"))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emaiCcontroller.dispose();
    passwordCcontroller.dispose();
  }


  signUp(){
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emaiCcontroller.text.toString(),
        password: passwordCcontroller.text.toString()
    ).then((value){
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationBarss()));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
    });
  }
}
