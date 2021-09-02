import 'package:dio/dio.dart';
import '../../../models/homeModels/homeProdsModel.dart';
import '../../../shared/components/endPoints.dart';
import '../../../shared/network/remote/dioHelper.dart';
import 'package:flutter/cupertino.dart';

class HomeHelper{

  DioHelper _dioHelper = DioHelper();

  Future<HomeProdsModel> getHomeProds(BuildContext context) async{
    Response response = await _dioHelper.get(context, path: URL.home, body: {},);
    return HomeProdsModel.fromRes(response.data);
  }

}