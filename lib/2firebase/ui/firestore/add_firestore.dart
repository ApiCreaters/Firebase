
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlites/2firebase/widget/round_btn.dart';

import '../../Utils/utils.dart';

class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  bool loading = false;
  final postController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Firestore"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: const InputDecoration(
                  hintText: 'What is in your nind?',
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 30,),
            RoundButton( loading: loading,
                title: "Add", VoidCallback: (){
                  setState(() {
                    loading = true;
                  });

                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                 fireStore.doc().set({
                   'title': postController.text.toString(),
                   'id': id
                 }).then((value){
                   setState(() {
                     loading = false;
                   });
                 }).onError((error, stackTrace){
                   setState(() {
                     loading = false;
                   });
                   Utils().toastMessage(error.toString());
                 });
                }),
          ],
        ),
      ),
    );
  }
}
