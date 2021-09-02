import 'package:flutter/widgets.dart';

import 'getCartsModel.dart';

class AddOrRemoveProdCartsModels{
  bool status;
  String message;
  Cart_item data;

  AddOrRemoveProdCartsModels({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  factory AddOrRemoveProdCartsModels.fromRes(Map<String,dynamic> data)=>
      AddOrRemoveProdCartsModels(
          status: data['status'],
          message: data['message'],
          data: Cart_item.fromRes(data['data'])
      );
}