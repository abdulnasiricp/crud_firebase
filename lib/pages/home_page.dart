import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_student.dart';
import 'list_student_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Firebase CRUD'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
              child: Text('Add'),
              onPressed: () {
                Get.to(AddStudentPage());
              },
            )
          ],
        ),
      ),
      body: ListStudentPage(),
    );
  }
}
