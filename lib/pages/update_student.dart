import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;
  UpdateStudentPage({Key? key, required this.id}) : super(key: key);
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();

  // Updaing Student
  CollectionReference students = FirebaseFirestore.instance.collection('students');

  Future<void> updateUser(id, name, email, password) {
    return students
        .doc(id)
        .update({
          'name': name,
          'email': email,
          'password': password
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Student"),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance.collection('students').doc(widget.id).get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var name = data!['name'];
              var email = data['email'];
              var password = data['password'];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: name,
                        autofocus: false,
                        onChanged: (value) => name = value,
                        decoration: InputDecoration(
                          labelText: 'Name: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: email,
                        autofocus: false,
                        onChanged: (value) => email = value,
                        decoration: InputDecoration(
                          labelText: 'Email: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          } else if (!value.contains('@')) {
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: password,
                        autofocus: false,
                        onChanged: (value) => password = value,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState!.validate()) {
                                updateUser(widget.id, name, email, password);
                                // Navigator.pop(context);
                                Get.back();
                              }
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            child: Text(
                              'Reset',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}

//   final _formkey = GlobalKey<FormState>();

//   UpdateUser() {
//     print('User Updated');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Students'),
//       ),
//       body: Form(
//         key: _formkey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: 20,
//             horizontal: 30,
//           ),
//           child: ListView(
//             children: [
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                 child: TextFormField(
//                   initialValue: 'Nasir',
//                   onChanged: (value) => {},
//                   autofocus: false,
//                   decoration: InputDecoration(
//                     labelText: 'Name: ',
//                     labelStyle: TextStyle(fontSize: 20.0),
//                     border: OutlineInputBorder(),
//                     errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter Name';
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                 child: TextFormField(
//                   autofocus: false,
//                   initialValue: 'abc@gmail.com',
//                   onChanged: (value) => {},
//                   decoration: InputDecoration(
//                     labelText: 'Email: ',
//                     labelStyle: TextStyle(fontSize: 20.0),
//                     border: OutlineInputBorder(),
//                     errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter Email';
//                     } else if (!value.contains('@')) {
//                       return 'Please Enter valid email';
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                 child: TextFormField(
//                   autofocus: false,
//                   initialValue: '11112232',
//                   onChanged: (value) => {},
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Password: ',
//                     labelStyle: TextStyle(fontSize: 20.0),
//                     border: OutlineInputBorder(),
//                     errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter password';
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                   child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_formkey.currentState!.validate()) {
//                         UpdateUser();
//                         Get.back();
//                       }
//                     },
//                     child: Text(
//                       'Update',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () => {},
//                     child: Text(
//                       'Reset',
//                       style: TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
