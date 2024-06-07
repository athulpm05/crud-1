// ignore_for_file: camel_case_types, prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newproject222/screens/registration.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final valid = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();

  // Future<void> register() async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //             email: email.text, password: password.text);

  //     String authenticationid = userCredential.user!.uid;
  //     await FirebaseFirestore.instance
  //         .collection('register')
  //         .doc(authenticationid)
  //         .set({
  //       'name': name.text,
  //       'email': email.text,
  //       'password': password.text,
  //       'uid': authenticationid
  //     });

  //     print("User registration successfully");
  //     // ScaffoldMessenger(child: SnackBar(content: Text("User registration successfully")));
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => Floatbutton1(),
  //         ));

  //   } on FirebaseAuthException catch (e) {
  //     print("Fialed registration user:$e");
  //     String errormasage = "registration failed: ${e.message}";
  //     if(e.code=="email-alredy-in-use"){
  //        errormasage="email alredy used";
  //     }
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errormasage)));

  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("unexpected eroor")));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Registration',
          ),
        ),
      ),
      body: SafeArea(
          child: Form(
        key: valid,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 40),
                child: Row(
                  children: [
                    Text(
                      "Name",
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    height: 40,
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your user name";
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 40),
                child: Row(
                  children: [
                    Text(
                      "Email",
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    height: 40,
                    child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),

                        //validatin
                        validator: (value1) {
                          if (value1 == null || value1.isEmpty) {
                            return "Enter your user email";
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value1)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        }),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 40),
                child: Row(
                  children: [
                    Text(
                      "Password",
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    height: 40,
                    child: TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                        validator: (value2) {
                          if (value2 == null || value2.isEmpty) {
                            return "Enter your user passsword";
                          }
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value2 as String)) {
                            return "enter valid password";
                          }
                          return null;
                        }),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (valid.currentState?.validate() ?? true) {
                          // register();
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: email.text, password: password.text);

                            String authenticationid = userCredential.user!.uid;
                            await FirebaseFirestore.instance
                                .collection('register')
                                .doc(authenticationid)
                                .set({
                              'name': name.text,
                              'email': email.text,
                              'password': password.text,
                              'uid': authenticationid
                            });

                            print("User registration successfully");
                            // ScaffoldMessenger(child: SnackBar(content: Text("User registration successfully")));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Floatbutton1(),
                                ));
                          } on FirebaseAuthException catch (e) {
                            print("Fialed registration user:$e");
                            String errormasage =
                                "registration failed: ${e.message}";
                            if (e.code == "email-alredy-in-use") {
                              errormasage = "email alredy used";
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(errormasage)));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("unexpected eroor")));
                          }
                        }
                      },
                      child: Container(
                        width: 380,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffb4472B2)),
                        child: Center(
                            child: Text("register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
