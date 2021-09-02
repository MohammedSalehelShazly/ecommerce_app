import 'package:flutter/cupertino.dart';

class PostAddressModel{

  final bool status;
  final String message;
  final int id;
  PostAddressModel({
    @required this.status,
    @required this.message,
    @required this.id,
  });
  factory PostAddressModel.fromRes(Map<String ,dynamic> data)=>
      PostAddressModel(
          status: data['status'],
          message: data['message'],
          id: data['data']['id']
      );



}