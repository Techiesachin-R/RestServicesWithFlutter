import 'package:flutter/material.dart';
import 'package:studentapiflutter/models/api.services.dart';
import 'package:studentapiflutter/models/student.dart';

class AddStudent extends StatefulWidget {
  final Student student;
  AddStudent(this.student);

  /// AddStudent({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddStudentState(student);
  // _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  Student student;
  _AddStudentState(this.student);
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var textStyle = TextStyle();

  final _gendersDropDownList = ["Male", "Female", "NA"];
  String _genderDropDownList = "NA";
  final connectionIssueSnackbar = SnackBar(content: Text("404, Connection Issue !"),);

  @override
  Widget build(BuildContext context) {
    firstNameController.text = student.firstName;
    lastNameController.text = student.lasttName;
    textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildForm(),
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      title: Text("Student List"),
    );
  }

  Widget _buildForm() {
    return ListView(
      padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0),
      children: <Widget>[
        TextField(
          controller: firstNameController,
          style: textStyle,
          onChanged:(value) => updateFirstName(),
          decoration: InputDecoration(
              labelText: "FirstName",
              labelStyle: textStyle,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextField(
          controller: lastNameController,
          style: textStyle,
          onChanged: (value) =>updateLastName(),
          decoration: InputDecoration(
              labelText: "LastName",
              labelStyle: textStyle,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        ),
        // ListTile(
        //   title: DropdownButton<String>(
        //       items: _gendersDropDownList.map((int value) {
        //         return DropdownMenuItem<String>(
        //           value: value,
        //           child: Text(value),
        //         );
        //       }).toList(),
        //       style: textStyle,
        //       value: retriveGender(student.gender),
        //       onChanged: (value) => updateGender(value)),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
                padding: EdgeInsets.all(10.0),
                textColor: Colors.blueAccent,
                child: Text( student == null ? "Save": "Update"),
                onPressed: (){
                  saveStudent();
                }),
            RaisedButton(
                padding: EdgeInsets.all(10.0),
                textColor: Colors.blueAccent,
                child: Text("Delete"),
                onPressed: (){
                  deleteStudent(student.id);
                }),
          ],
        )
      ],
    );
  }

  String retriveGender(int value) {
    return _gendersDropDownList[value - 1];
  }

  void updateGender(String value) {
    switch (value) {
      case "Male":
        student.gender = "1";
        break;
      case "Female":
        student.gender = "2";
        break;
      case "NA":
        student.gender = "3";
        break;
      default:
    }
  }

  void saveStudent() async{
    var saveResponse = await APIServices.postStudent(student);
    saveResponse== true? Navigator.pop(context, true) : Scaffold.of(context).showSnackBar(connectionIssueSnackbar);
  }

  void updateFirstName(){
    student.firstName = firstNameController.text;
  }
    void updateLastName(){
    student.lasttName = lastNameController.text;
  }

  void deleteStudent(int id) async{
    var deletStu = await APIServices.deletStudent(id);
    print(deletStu);
    Navigator.pop(context);
      //deletStu == true? Navigator.pop(context, true) : Scaffold.of(context).showSnackBar(connectionIssueSnackbar);
  }
}
