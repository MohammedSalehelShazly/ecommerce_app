import '../../models/CategoriesModels/oneCategoryModel.dart';
import 'package:flutter/cupertino.dart';

class HomeProdsModel{
  bool status;
  HomeData data;

  HomeProdsModel({
    @required this.status,
    @required this.data
  });

  factory HomeProdsModel.fromRes(Map<String ,dynamic> data)=>
      HomeProdsModel(
          status: data['status'],
          data: HomeData.fromRes(data['data'])
      );
}




class HomeData{

  String ad;
  List<Banner> banners;
  List<Product> products;

  HomeData({
    @required this.ad,
    @required this.banners,
    @required this.products,
  });

  factory HomeData.fromRes(Map<String ,dynamic> data)=>
      HomeData(
        ad: data['ad'],
        products: List.from(data['products'].map((e)=> Product.fromRes(e))),
        banners: List.from(data['banners'].map((e)=> Banner.fromRes(e))),
      );
}

class Banner{
  int id;
  String image;

  Banner({
    @required this.id,
    @required this.image,
  });

  factory Banner.fromRes(Map<String ,dynamic> data)=>
      Banner(
        id: data['id'],
        image: data['image'],
      );
}
