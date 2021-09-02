import 'package:dio/dio.dart';
import '../../../models/cartsModels/addOrRemoveProdCartsModels.dart';
import '../../../models/cartsModels/getCartsModel.dart';
import '../../../shared/components/endPoints.dart';
import '../../../shared/network/remote/dioHelper.dart';
import 'package:flutter/material.dart';

class Cart{

  DioHelper _dioHelper = DioHelper();

  Future<AddOrRemoveProdCartsModels> addOrRemove(BuildContext context ,int prodID)async{
    Response post = await _dioHelper.post(
      context,
      path: URL.carts,
      body:{
        'product_id' : prodID
      },
    );
    return AddOrRemoveProdCartsModels.fromRes(post.data);
  }


  changeQuantity({
    @required BuildContext context,
    @required int prodIDItCarts,
    @required int quantity})async{
    _dioHelper.put(
      context,
      path: URL.carts +'/$prodIDItCarts',
      body: {
        'quantity' : prodIDItCarts
      },
    );
  }


  Future<AllCartProdsModel> getAllCarts(BuildContext context) async{
    Response get = await _dioHelper.get(
      context,
      path: URL.carts,
    );
    return AllCartProdsModel.fromRes(get.data);
  }




}