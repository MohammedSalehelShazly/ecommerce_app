import 'package:flutter/foundation.dart';

class AllFavoritesModel{
  bool status;
  List<FavProduct> products;

  AllFavoritesModel({
    @required this.status,
    @required this.products
  });
  factory AllFavoritesModel.fromRes(Map<String ,dynamic> data)=>
      AllFavoritesModel(
        status: data['status'],
        products: List.from(data['data']['data'].map((e)=> FavProduct.fromRes(e['product']))),
      );
}

class FavProduct{

  final int id ;
  final num price ,old_price ,discount ;
  final String image ,name ,description;
  final List<dynamic> images;
  final bool in_favorites ,in_cart;

  FavProduct({
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

  factory FavProduct.fromRes(Map<String ,dynamic> responseStr)
  =>
      FavProduct(
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