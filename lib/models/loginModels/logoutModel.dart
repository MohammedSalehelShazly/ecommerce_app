import 'package:flutter/cupertino.dart';

class LogoutModel{
  bool status;
  String message;
  LogoutModel({
    @required this.status,
    @required this.message,
  });
  factory LogoutModel.fromRes(Map<String ,dynamic> dataFromRes)
  => LogoutModel(
      status : dataFromRes['status'],
      message: dataFromRes['message'],
  );
}

