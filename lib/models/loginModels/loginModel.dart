import 'package:flutter/cupertino.dart';

class LoginModel{
  bool status;
  String message;
  Data data;
  LoginModel({
    @required this.status,
    @required this.message,
    @required this.data,
  });
  factory LoginModel.fromRes(Map<String ,dynamic> dataFromRes)
  => LoginModel(
      status : dataFromRes['status'],
      message: dataFromRes['message'],
      data: dataFromRes['data'] ==null ?null : Data.fromRes(dataFromRes['data'])
  );
}


class Data{
  String token ;
  int id;
  Data({
    @required this.token,
    @required this.id,
  });

  factory Data.fromRes(Map<String ,dynamic> data)
  => Data(
    token: data['token'],
    id: data['id'],
  );
}