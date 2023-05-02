
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/2firebase/widget/round_btn.dart';

import '../../Utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  bool loading = false;
  final postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
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
              // databaseRef.child('1').set({
              // Multiple child   ==>     .child(DateTime.now().microsecondsSinceEpoch.toString()).child('Comment').child("aa")

              String id = DateTime.now().microsecondsSinceEpoch.toString();

              databaseRef.child(id).set({
                'title' : postController.text.toString(),
                'id' : id
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
            })

          ],
        ),
      ),
    );
  }
}
