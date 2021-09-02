import 'package:flutter/foundation.dart';

class User{

  final bool status;
  final String message;
  final Data data;

  User({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  factory User.fromRes(Map<String, dynamic> dataFromRes)
  =>
      User(
          status: dataFromRes['status'],
          message: dataFromRes['message'],
          data: dataFromRes['data'] == null ? null : Data.fromRes(
              dataFromRes['data'])
      );
}


class Data{
  final String token ,email , phone, image,name;
  final int id ,points, credit;
  Data({
    @required this.token,
    @required this.id,
    @required this.email,
    @required this.phone,
    @required this.credit,
    @required this.image,
    @required this.points,
    @required this.name,
  });

  factory Data.fromRes(Map<String ,dynamic> data)
  => Data(
    token: data['token'],
    id: data['id'],
    image: data['image'],
    credit: data['credit'],
    email: data['email'],
    phone: data['phone'],
    points: data['points'],
    name : data['name']
  );
}