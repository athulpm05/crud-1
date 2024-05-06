// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Floatbutton1 extends StatefulWidget {
  const Floatbutton1({super.key});

  @override
  State<Floatbutton1> createState() => _Floatbutton1State();
}

class _Floatbutton1State extends State<Floatbutton1> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final valid = GlobalKey<FormState>();
  var name = TextEditingController();
  var content = TextEditingController();
  

  Future<void> add() async {
    final adddata =
        await FirebaseFirestore.instance.collection('addcontent').add({
      'name': name.text,
      'content': content.text,
    });
  }

  void addDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextFormField(
            controller: name,
            decoration: InputDecoration(hintText: "Name"),
          ),
          content: TextFormField(
            controller: content,
            decoration: InputDecoration(
              hintText: "activity",
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  add();
                },
                child: Text("Save"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(onPressed: (){
              addDialog();
            },
            child: Text("Add"),
            )
          ),
         

          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('addcontent').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                
                final users = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var todo = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(todo['name']),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ]),
                    );
                  },
                );
              })
        ],
      ),
    );
  }
}
