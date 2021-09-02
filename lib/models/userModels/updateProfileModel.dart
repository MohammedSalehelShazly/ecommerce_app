import 'package:flutter/foundation.dart';

class UpdateProfileModel{
  final bool status;
  final String message;
  final String token;
  UpdateProfileModel({
    @required this.status,
    @required this.message,
    @required this.token
  });
  factory UpdateProfileModel.froResp(Map<String ,dynamic> dataRes)
  => UpdateProfileModel(
    status: dataRes['status'],
    message: dataRes['message'],
    token : dataRes['data'] !=null ? dataRes['data']['token'] :'',
  );
}