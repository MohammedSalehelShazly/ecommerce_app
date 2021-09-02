import 'package:flutter/foundation.dart';

class OneCategoryModel{
  bool status;
  String message;
  Data data;

  OneCategoryModel({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  factory OneCategoryModel.fromRes(Map<String ,dynamic> responseStr)
  =>OneCategoryModel(
      status: responseStr['status'],
      message: responseStr['message'],
      data: Data.fromRes(responseStr['data']));
}


class Data{

  List<Product> data;
  Data({@required this.data});
  factory Data.fromRes(Map<String ,dynamic> dataData)
    => Data(data: List<Product>.from(dataData['data'].map((e)=> Product.fromRes(e)))
    );

}

class Product{


  final int id ;
  final num price ,old_price ,discount ;
  final String image ,name ,description;
  final List<dynamic> images;
  final bool in_favorites ,in_cart;

  Product({
    @required this.id,
    @required this.price,
    @required this.old_price,
    @required this.discount,
    @required this.image,
    @required this.name,
    @required this.description,
    @required this.images,
    @required this.in_favorites,
    @required this.in_cart});

  factory Product.fromRes(Map<String ,dynamic> responseStr)
  =>
      Product(
        id: responseStr['id'],
        price: responseStr['price'],
        old_price: responseStr['old_price'],
        discount: responseStr['discount'],
        image: responseStr['image'],
        name: responseStr['name'],
        description: responseStr['description'],
        images: responseStr['images'],
        in_favorites: responseStr['in_favorites'],
        in_cart: responseStr['in_cart'],);

}










