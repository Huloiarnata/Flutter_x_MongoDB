// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

import 'package:mongo_dart/mongo_dart.dart';

class User {
  ObjectId id;
  String name;
  String reg;
  String email;

  User(
      {required this.id,
      required this.name,
      required this.reg,
      required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      reg: json['reg'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['reg'] = this.reg;
    data['email'] = this.email;
    return data;
  }
}
