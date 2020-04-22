import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:studentapiflutter/Screens/AddStudent.dart';

import 'package:studentapiflutter/models/api.services.dart';
import 'package:studentapiflutter/models/student.dart';

class Students extends StatefulWidget {
  Students({Key key}) : super(key: key);

  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  List<Student> students;

  getStudents() {
    APIServices.fetchStudent().then((response) {
      Iterable list = json.decode(response.body);
      List<Student> studentsList = List<Student>();
      try {
        studentsList = list.map((model) => Student.fromObject(model)).toList();
      } catch (e) {
        print(e);
      }
      setState(() {
        students = studentsList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getStudents();
    return Scaffold(
        floatingActionButton: _buildFloatingButton(),
        appBar: _buildAppbar(),
        body: students == null
            ? Center(
                child: Text("No Data found"),
              )
            : _buildStudentList());
  }

  Widget _buildAppbar() {
    return AppBar(
      title: Text("Student List"),
    );
  }

  Widget _buildStudentList() {
    return ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              //leading: ,
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text(students[index].firstName),
              onTap: () {
                navigateToStudent(this.students[index]);
              },
            ),
          );
        });
  }

  void navigateToStudent(Student student) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddStudent(student)));
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          navigateToStudent(Student("", "", ""));
        });
  }
}
