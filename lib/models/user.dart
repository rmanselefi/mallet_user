import 'package:flutter/cupertino.dart';

class UserData {
  String? id;
  String? email;
  String? password;
  String? token;

  UserData({@required this.id,  this.email, this.password,@required this.token});
}