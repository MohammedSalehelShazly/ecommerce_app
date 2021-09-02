
import 'package:flutter/cupertino.dart';

class AddRemoveFavModels{
  bool status;
  String message;

  AddRemoveFavModels({
    @required this.status,
    @required this.message,
  });
  factory AddRemoveFavModels.fromRes(Map<String ,dynamic> data)=>
      AddRemoveFavModels(
        status: data['status'],
        message: data['message'],
      );
}