import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/1sql1/db_helper.dart';

class DatabaseScreen extends StatelessWidget {
  const DatabaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: ()async{
              await DatabaseHelper.instance.insertRecord({
                DatabaseHelper.columnName: "Dafasjwklejdoi 123"
              });
            }, child: Text("Create")),

            ElevatedButton(onPressed: () async{
              var dbquery = await DatabaseHelper.instance.queryDatabase();
              print(dbquery);
            }, child: Text("Read")),

            ElevatedButton(onPressed: () async{
              await DatabaseHelper.instance.updateRecord({
                DatabaseHelper.columnId: 2,
                DatabaseHelper.columnName: "vbswjisw"
              });
            }, child: Text("Update")),

            ElevatedButton(onPressed: ()async{
              // await DatabaseHelper.instance.deleteRecord(2);
            }, child: Text("Delete")),
          ],
        ),
      ),
    );
  }
}
