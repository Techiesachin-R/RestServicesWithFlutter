class Student{
  int _id;
  String _firstName;
  String _lastName;
  String _gender;

  Student(this._firstName, this._lastName,this._gender);
  Student.WithId(this._id,this._firstName, this._lastName,this._gender);

  int get id => _id;
  String get firstName => _firstName;
  String get lasttName => _lastName;
  String get gender => _gender;

  set firstName(String newFirstName){
    _firstName = newFirstName;
  }

  set lasttName(String newLastName){
    _lastName = newLastName;
  }

  set gender(String newGender){
    _gender = newGender;
  }


Map<String, dynamic> topMap(){
  var map = Map<String,dynamic>();
  map["firstName"] = _firstName;
  map["lastName"] = _lastName;
  map["gender"] = _gender;

  if(_id != null){
    map["id"] = _id;
  }
  return map;
}

Student.fromObject(dynamic o){
  this._id =o["id"];
  this.firstName = o["firstName"];
  this.lasttName = o["lasttName"];
  this.gender = o["gender"];
}

}