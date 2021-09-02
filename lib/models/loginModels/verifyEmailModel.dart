import 'package:flutter/cupertino.dart';

class VerifyEmailModel{

  bool status;
  String message;
  String email;
  VerifyEmailModel({
    @required this.status,
    @required this.message,
    @required this.email,
  });
  factory VerifyEmailModel.froResp(Map<String ,dynamic> dataRes)
      => VerifyEmailModel(
          status: dataRes['status'],
          message: dataRes['message'],
          email: dataRes['data'] ==null ? '' : dataRes['data']['email']);
}