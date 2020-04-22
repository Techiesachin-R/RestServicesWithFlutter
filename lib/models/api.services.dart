import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:studentapiflutter/models/student.dart';


class APIServices{

  static String apiurl = "http://192.168.61.209:5000/api/student/";

  static Future fetchStudent() async{
    return await http.get(apiurl);
  }

  static Map<String, String> header ={
    "Content-type":"application/json",
    "Accept":"application/json"
  };

  static Future<bool> postStudent(Student student) async{
    var myStudent = student.topMap();
    var studentBody = json.encode(myStudent);
    var res = await http.post(apiurl, headers: header, body: studentBody);
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future<bool> deletStudent(int id) async{
    var res = await http.post(apiurl+"?"+id.toString(), headers: header);
    return Future.value(res.statusCode == 200 ? true : false);
  }

}