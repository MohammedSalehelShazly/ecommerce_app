import 'package:flutter/cupertino.dart';

class ComplaintsModel{

  bool status;
  String message; // comeback massage from service
  int id;
  ComplaintsModel({
    @required this.status,
    @required this.message,
    @required this.id,
  });

  factory ComplaintsModel.fromRes(Map<String ,dynamic> data) =>
      ComplaintsModel(
        status: data['status'],
        message: data['message'],
        id: data['data']['id'],
      );
}