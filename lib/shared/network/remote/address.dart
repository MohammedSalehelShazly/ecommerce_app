import 'package:dio/dio.dart';
import '../../../models/userModels/getAddressModel.dart';
import '../../../models/userModels/postAddressModel.dart';
import '../../../shared/components/endPoints.dart';
import '../../../shared/network/remote/dioHelper.dart';
import 'package:flutter/cupertino.dart';

class Address{
  
  DioHelper _dioHelper = DioHelper();
  
  Future<PostAddressModel> postAddress({
    @required BuildContext context ,@required String name, @required String city, @required String region, @required String details, @required String notes, @required String latitude, @required String longitude,
  }) async{
    Response post = await _dioHelper.post(
      context ,
      path: URL.addresses,
      body: {
        "name" : name ,
        "city" : city ,
        "region" : region ,
        "details" : details ,
        "notes" : notes ,
        "latitude" : latitude ,
        "longitude" : longitude ,
      },
    );
    return PostAddressModel.fromRes(post.data);
  }


  Future<GetAddressModel> getAddress(BuildContext context) async{
    Response get = await _dioHelper.get(context ,path: URL.addresses);
    return GetAddressModel.fromRes(get.data);
  }

  Future<Map<String ,dynamic>> updateAddress({
    @required BuildContext context ,@required String addressID ,@required String name, @required String city, @required String region, @required String details, @required String notes, @required String latitude, @required String longitude,
  }) async{
    Response put = await _dioHelper.put(context ,path: URL.addressesUpdate+addressID ,
      body: {
        "name" : name ,
        "city" : city ,
        "region" : region ,
        "details" : details ,
        "notes" : notes ,
        "latitude" : latitude ,
        "longitude" : longitude ,
      }
    );
    return put.data;
  }



  Future<Map<String ,dynamic>> deleteAddress(int addressID ,BuildContext context) async{
    Response delete = await _dioHelper.delete(
      context,
      path: URL.addressesUpdate + '$addressID',
    );
    return delete.data;
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}