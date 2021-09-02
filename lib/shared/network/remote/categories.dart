import 'package:dio/dio.dart';
import '../../../models/CategoriesModels/oneCategoryModel.dart';
import '../../../shared/localization/language_constants.dart';
import '../../../shared/network/remote/dioHelper.dart';
import 'package:flutter/material.dart';
import '../../../models/CategoriesModels/categoriesModel.dart';
import '../../../shared/components/endPoints.dart';

class CategoriesHelper{

  DioHelper _dioHelper = DioHelper();
  Future<CategoriesModel> getCategories(BuildContext context)async{
    Response get = await _dioHelper.get(
        context,
        path: URL.categories,
        );
    return CategoriesModel.fromRes(get.data);
  }

  Future<OneCategoryModel> getCategoryDetails(int catID ,BuildContext context)async{
    Response get = await _dioHelper.get(context ,path: URL.categoryDetails+'$catID');
    return OneCategoryModel.fromRes(get.data);
  }


  Future<Product> getProduct(int prodID ,BuildContext context) async{
    Response get = await _dioHelper.get(context ,path: URL.products +'$prodID',);
    return Product.fromRes(get.data['data']);
  }





















}