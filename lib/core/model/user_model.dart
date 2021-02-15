import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class User extends Equatable {
  String name;
  String email;

  User({@required this.name, @required this.email});

  User.fromJson(Map<String, dynamic> json) {
    print("fromJson geldi");
    print(json);
    name = json['name'];
    email = json['email'];
    print("fromJson geçti..");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }

  @override
  List<Object> get props => [name, email];
}
