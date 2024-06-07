// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:newproject222/forgetpass1.dart';
import 'package:newproject222/forgetpass2.dart';
import 'package:newproject222/screens/registration.dart';
import 'package:newproject222/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

 final valid = GlobalKey<FormState>();
  var name=TextEditingController();
  var password=TextEditingController();
  var email = emailController();


   Future<void> _saveStoreIdToSharedPreferences(String storeId) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('storeId', storeId);
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 370,
                  height: 450,
                  decoration: BoxDecoration(
                    color: Color(0xffb4466b2).withOpacity(0.3)
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Log in",style: TextStyle(
                              color: Color(0xffb4466b2),
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                            ),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              height: 40,
                              child: TextFormField(
                                controller: name,
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  hintStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500
                                  ),
                                  prefixIcon: Icon(Icons.person),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)
                                  )
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              height: 40,
                              child: TextFormField(
                                controller: password,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500
                                  ),
                                  prefixIcon: Icon(Icons.lock),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)
                                  )
                                ),
                                validator: (value) {
                                  if(value==null||value.isEmpty){}
                                },
                              ),

                              
                            ),
                            
                          ],
                        ),
                      ),
                       TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Forgetpass1(),));
                      },
                       child: Text("Forget password")),

                       //2
                       TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Forgetpass2(),));
                      },
                       child: Text("Forget password 2")),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: ()async{

                                 if (_formKey.currentState!.validate()) {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();
                    var querySnapshot = await FirebaseFirestore.instance
                        .collection('storekeeper')
                        .where('email', isEqualTo: email)
                        .limit(1)
                        .get();

                    if (querySnapshot.docs.isNotEmpty) {
                      var userData = querySnapshot.docs.first.data();
                      if (userData['password'] == password) {
                        await _saveStoreIdToSharedPreferences(
                            userData['storeId']);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StoreBottomNavigation(),
                          ),
                        );
                      } else {
                        print('Incorrect password');
                      }
                    } else {
                      print('User not found');
                    }
                  }

                              },
                              child: Container(
                                width: 300,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xffb4466b2)
                                ),
                                child: Center(
                                  child: Text("Log in",style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                  ),),
                                ),
                              ),
                            ),
        
                            
                          ],
                        ),
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Signup(),));
                      },
                       child: Text("Alredy have an account"))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
    
}
}