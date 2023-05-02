import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqlite/2firebase/ui/auth/signup.dart';

import '../../Utils/utils.dart';
import '../../widget/round_btn.dart';
import '../forgot_password.dart';
import '../posts/post_screen.dart';
import '../tabar.dart';
import 'login_with_phone.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fromField = GlobalKey<FormState>();
  var emaiController = TextEditingController();
  var passwordController = TextEditingController();
  bool loading = false;

  final _auth = FirebaseAuth.instance;

  void login(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: emaiController.text.toString(),
        password: passwordController.text.toString()
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login Screen"),
        ),
        body: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Form(key: _fromField,
                      child: Column(children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emaiController,
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
                            controller: passwordController,
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
                    title: "Login",VoidCallback: (){
                    if(_fromField.currentState!.validate()) {
                      login();
                    }
                  },),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForegotPasswordScreen()));
                    }, child: Text("Forgot Password?")),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text("Don't have an account?"),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScaren()));
                      }, child: Text("Sign up"))
                    ],
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPhoneNumber()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xff101010),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.white,
                          width: 2
                        )
                      ),
                      child: Center(
                        child: Text("Login with phone"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emaiController.dispose();
    passwordController.dispose();
  }
}
