
import 'package:flutter/cupertino.dart';

class VerifyCodeModel{

  final bool status;
  final String message;

  VerifyCodeModel({
    @required this.status,
    @required this.message
  });

  factory VerifyCodeModel.fromRes(Map<String ,dynamic> data)
      =>VerifyCodeModel(
        status: data['status'],
        message: data['message'] ??'',
      );
}