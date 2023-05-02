import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlites/2firebase/Utils/utils.dart';

import '../auth/login_screen.dart';
import 'add_post.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();
  final editController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Back icon remove from the Page
        centerTitle: true,
        title: const Text("PostScreen"),
        actions: [
          IconButton(onPressed: (){
            auth.signOut()
                .then((value){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                });
          }, icon: Icon(Icons.logout)),
          const SizedBox(width: 10)
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
            child: TextFormField(
              controller: searchFilter,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder()
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: const Text("Loading..."),
                itemBuilder: (context, snapshot, animation, index){
                  final title = snapshot.child('title').value.toString();

                  if(searchFilter.text.isEmpty){
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: (){
                                  Navigator.pop(context);
                                  showMyDialog(title, snapshot.child('id').value.toString());
                                },
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              )),
                          PopupMenuItem(
                            value: 2,
                            child: ListTile(
                              onTap: (){
                                Navigator.pop(context);
                                ref.child(snapshot.child('id').value.toString()).remove();
                              },
                              leading: Icon(Icons.delete),
                              title: Text('Delete'),
                            ),
                          )
                        ],
                      ),
                    );
                  }else if(title.toLowerCase().contains(searchFilter.text.toLowerCase().toLowerCase())){  //toLowerCase().toString()

                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: (){
                                  Navigator.pop(context);
                                  showMyDialog(title, snapshot.child('id').value.toString());
                                },
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              )),
                          PopupMenuItem(
                            value: 2,
                            child: ListTile(
                              onTap: (){
                                Navigator.pop(context);
                                ref.child(snapshot.child('id').value.toString()).remove();
                              },
                              leading: Icon(Icons.delete),
                              title: Text('Delete'),
                            ),
                          )
                        ],
                      ),
                    );
                  }else{
                    return Container();
                  }

                }
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String oldtitle,String id) async{
    editController.text = oldtitle;
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(
                  hintText: 'edit text'
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text("Cancel")),
              TextButton(onPressed: () {
                    Navigator.pop(context);
                    ref.child(id).update({
                      'title' : editController.text.toLowerCase()
                    }).then((value){

                    }).onError((error, stackTrace){
                      Utils().toastMessage(error.toString());
                    });
                  }, child: Text("Update")),
            ],
          );
        }
    );
  }
}













//Expanded(child: StreamBuilder(
//             stream: ref.onValue,
//             builder: (context,AsyncSnapshot<DatabaseEvent> snapshot){
//               Map<dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic;
//               List<dynamic> list = [];
//               list.clear();
//               list = map.values.toList();
//
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                     itemCount: snapshot.data!.snapshot.children.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(list[index]['title']),
//                         subtitle: Text(list[index]['id']),
//                       );
//                     });
//               }else{
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           )),