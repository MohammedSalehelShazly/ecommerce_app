import 'package:flutter/foundation.dart';

class ChangePasswordModel{

  final bool status;
  final String message;
  ChangePasswordModel({
    @required this.status,
    @required this.message,
  });
  factory ChangePasswordModel.froResp(Map<String ,dynamic> dataRes)
  => ChangePasswordModel(
      status: dataRes['status'],
      message: dataRes['message']
  );
}