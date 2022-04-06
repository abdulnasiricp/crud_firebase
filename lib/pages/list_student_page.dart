import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'update_student.dart';

class ListStudentPage extends StatefulWidget {
  _ListStudentPageState createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> studentsStream = FirebaseFirestore.instance.collection('students').snapshots();

  // For Deleting User
  CollectionReference students = FirebaseFirestore.instance.collection('students');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students.doc(id).delete().then((value) => print('User Deleted')).catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Action',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(child: Text(storedocs[i]['name'], style: TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Center(child: Text(storedocs[i]['email'], style: TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                  onPressed: () {
                                    Get.to(
                                      UpdateStudentPage(id: storedocs[i]['id']),
                                    );
                                  }),
                              IconButton(
                                onPressed: () => {
                                  deleteUser(storedocs[i]['id'])
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        });
  }
}

//   final Stream<QuerySnapshot> studentsStream = FirebaseFirestore.instance.collection('students').snapshots();

//   deleteUser(id) {
//     print('User Deleted $id');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: studentsStream,
//       builder: (BuildContext context,
//        AsyncSnapshot<QuerySnapshot> snapshot) {
//          if (snapshot.hasError) {
//   print('Something went wrong');
// }
// if (snapshot.connectionState == ConnectionState.waiting){
//   return Center(
//     child: CircularProgressIndicator (),
//  );
// }
// final List storedocs = [];
//     snapshot.data!.docs.map((DocumentSnapshot document) {
//       Map a = document.data() as Map<String, dynamic>;
//       storedocs.add(a);
//     }).toList();
//     print(storedocs);
//        }
//     )
//  return Container(
//       margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Table(
//           border: TableBorder.all(),
//           columnWidths: <int, TableColumnWidth>{
//             1: FixedColumnWidth(140),
//           },
//           defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//           children: [
//             TableRow(
//               children: [
//                 TableCell(
//                   child: Container(
//                     color: Colors.greenAccent,
//                     child: Center(
//                       child: Text(
//                         'Name',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 TableCell(
//                   child: Container(
//                     color: Colors.greenAccent,
//                     child: Center(
//                       child: Text(
//                         'Email',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 TableCell(
//                   child: Container(
//                     color: Colors.greenAccent,
//                     child: Center(
//                       child: Text(
//                         'Action',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             for (var i = 0; i < storedocs.length; i++) ...[
//               TableRow(
//                 children: [
//                   TableCell(
//                     child: Container(
//                       child: Center(
//                         child: Text(
//                           storedocs[i]['name'],
//                           style: TextStyle(
//                             fontSize: 20.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   TableCell(
//                     child: Container(
//                       child: Center(
//                         child: Text(
//                           storedocs[i]['email'],
//                           style: TextStyle(
//                             fontSize: 20.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   TableCell(
//                     child: Row(
//                       children: [
//                         IconButton(
//                             icon: Icon(Icons.edit),
//                             color: Colors.blue,
//                             onPressed: () {
//                               Get.to(UpdateStudentPage());
//                             }),
//                         IconButton(
//                           icon: Icon(Icons.delete),
//                           color: Colors.red,
//                           onPressed: () => {
//                             print(storedocs)
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ],
//         ),
//       ),
//     );

//        },
//     );

//   }
// }
