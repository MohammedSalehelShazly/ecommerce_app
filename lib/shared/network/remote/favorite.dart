import 'package:dio/dio.dart';
import '../../../models/favoritesModels/addRemoveFavModels.dart';
import '../../../models/favoritesModels/allFavoritesModel.dart';
import '../../../shared/components/endPoints.dart';
import '../../../shared/localization/language_constants.dart';
import '../../../shared/network/remote/dioHelper.dart';
import 'package:flutter/material.dart';

class Favorite{

  DioHelper _dioHelper = DioHelper();

  Future<AddRemoveFavModels> addRemoveFav(int prodID ,BuildContext context) async{
    Response post = await _dioHelper.post(context ,
        path: URL.favorites,
        body: {
      'product_id' : prodID
    }
    );
    return AddRemoveFavModels.fromRes(post.data);
  }



  Future<AllFavoritesModel> getAllFav(BuildContext context) async{
    Response get = await _dioHelper.get(context ,
      path: URL.favorites,
    );
    return AllFavoritesModel.fromRes(get.data);
  }


}