import 'package:flutter/foundation.dart';

class VerifyNewPassModel{

  final bool status;
  final String message;

  VerifyNewPassModel({
    @required this.status,
    @required this.message
  });

  factory VerifyNewPassModel.fromRes(Map<String ,dynamic> data)
    =>VerifyNewPassModel(
      status: data['status'],
      message: data['message'] ??'',
    );

}