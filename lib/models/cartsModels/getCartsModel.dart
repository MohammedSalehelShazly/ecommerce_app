import '../../models/CategoriesModels/oneCategoryModel.dart';
import 'package:flutter/cupertino.dart';

class AllCartProdsModel{

  bool status;
  CartsData data;

  AllCartProdsModel({
    @required this.status,
    @required this.data
  });

  factory AllCartProdsModel.fromRes(Map<String,dynamic> data)=>
      AllCartProdsModel(
        status: data['status'],
        data: CartsData.fromRes(data['data'])
      );

}

class CartsData{

  List<Cart_item> cart_items;

  CartsData({@required this.cart_items});

  factory CartsData.fromRes(Map<String,dynamic> data)=>
      CartsData(
        cart_items: List.from(data['cart_items'].map((e)=> Cart_item.fromRes(e)))
      );

}


class Cart_item{
  int prodIDItCarts;
  int quantity;
  Product product;

  Cart_item({
    @required this.prodIDItCarts,
    @required this.quantity,
    @required this.product
  });

  factory Cart_item.fromRes(Map<String,dynamic> data)=>
      Cart_item(
          prodIDItCarts: data['id'],
          quantity: data['quantity'],
          product: Product.fromRes(data['product'])
      );
}








