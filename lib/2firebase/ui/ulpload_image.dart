import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqlites/2firebase/Utils/utils.dart';
import 'package:sqlites/2firebase/widget/round_btn.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  bool loading = false;
  File? _image;
  final picker = ImagePicker();

  // firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');

  
  Future getImageGallery() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }else{
        Utils().toastMessage("No image was picked");
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                getImageGallery();
              },
              child: Container(
                height: 200,
                width: 200,
                child: _image != null ?  Image.file(_image!.absolute) : Center(child: Icon(Icons.image,size: 40)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xff5b585d),
                  border: Border.all(color: Colors.white,width: 2)
                ),
              ),
            ),
            SizedBox(height: 40,),
            RoundButton(loading: loading,
                title: 'Upload', VoidCallback: () async{
              setState(() {
                loading = true;
              });
              firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/foldename/'+DateTime.now().microsecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

              await Future.value(uploadTask).then((value) async{

                var newUrl =  await ref.getDownloadURL();
                databaseRef.child('image').child(DateTime.now().microsecondsSinceEpoch.toString()).set({
                  'id' : '123',
                  'title' : newUrl.toString()
                }).then((value){
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage('Done');
                }).onError((error, stackTrace){
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(error.toString());
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
