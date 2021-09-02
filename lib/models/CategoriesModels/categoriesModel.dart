import 'package:flutter/foundation.dart';

class CategoriesModel{
  bool status;
  String message;
  Data data;

  CategoriesModel({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  factory CategoriesModel.fromRes(Map<String ,dynamic> responseStr)
    =>CategoriesModel(
        status: responseStr['status'],
        message: responseStr['message'],
        data: Data.fromRes(responseStr['data'])
    );

}


class Data{

  final String first_page_url ,last_page_url ,next_page_url ,path ,prev_page_url;
  final int current_page ,from ,last_page ,per_page ,to ,total;
  final List<Category> data;

  Data({
    @required this.data,
    @required this.first_page_url,
    @required this.last_page_url,
    @required this.next_page_url,
    @required this.path,
    @required this.prev_page_url,
    @required this.current_page,
    @required this.from,
    @required this.last_page,
    @required this.per_page,
    @required this.to,
    @required this.total});

  factory Data.fromRes(Map<String ,dynamic> responseStr)
    =>Data(
        data: List.from(responseStr['data'].map((e) => Category.fromRes(e))),
        first_page_url: responseStr['first_page_url'],
        last_page_url: responseStr['last_page_url'],
        next_page_url: responseStr['next_page_url'],
        path: responseStr['path'],
        prev_page_url: responseStr['prev_page_url'],
        current_page: responseStr['current_page'],
        from: responseStr['from'],
        last_page: responseStr['last_page'],
        per_page: responseStr['per_page'],
        to: responseStr['to'],
        total: responseStr['total'],
    );
}


class Category{
  int id;
  String name;
  String image;

  Category({
    @required this.id,
    @required this.name,
    @required this.image,
  });

  factory Category.fromRes(Map<String ,dynamic> responseStr)
    =>Category(
        id: responseStr['id'],
        name: responseStr['name'],
        image: responseStr['image']);
}



