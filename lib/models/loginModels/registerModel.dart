
import 'package:flutter/cupertino.dart';

class RegisterModel{
  bool status;
  String message;
  Data data;
  RegisterModel({
    @required this.status,
    @required this.message,
    @required this.data,
  });
  factory RegisterModel.fromRes(Map<String ,dynamic> dataFromRes)
      => RegisterModel(
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
