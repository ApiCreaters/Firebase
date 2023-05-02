import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/2firebase/Utils/utils.dart';

import '../auth/login_screen.dart';
import 'add_firestore.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Back icon remove from the Page
        centerTitle: true,
        title: const Text("FireStore"),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: Icon(Icons.logout)),
          const SizedBox(width: 10)
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Some error"));
                }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final titles = snapshot.data!.docs[index]['title'].toString();
                          return ListTile(
                            title: Text(snapshot.data!.docs[index]['title'].toString()),
                            subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) =>[
                                PopupMenuItem(
                                  value: 1,
                                  child: TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                      showMyDialog(titles, snapshot.data!.docs[index]['id'].toString());
                                    },
                                    child: Text("Edit"),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                      ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                                    },
                                    child: Text("Delete"),
                                  )
                                )
                              ],
                            ),
                          );
                        }),
                  );

              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddFirestoreDataScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String oldtitle, String id) async {
    editController.text = oldtitle;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(hintText: 'edit text'),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.doc(id).update({
                      'title' : editController.text.toString(),
                    }).then((value){
                      Utils().toastMessage("done");
                    }).onError((error, stackTrace){
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Text("Update")),
            ],
          );
        });
  }
}


// ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
//                                 'title' : 'a'
//                               }).then((value){
//
//                               }).onError((error, stackTrace){
//                                 Utils().toastMessage(error.toString());
//                               });


//ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();