
import 'package:dio/dio.dart';
import '../../../models/userModels/complaintsModel.dart';
import '../../../shared/localization/language_constants.dart';
import '../../../shared/network/remote/dioHelper.dart';
import 'package:flutter/material.dart';
import '../../../models/userModels/userModel.dart';
import '../../../shared/components/endPoints.dart';

class UserProfileHelper{

  DioHelper _dioHelper = DioHelper();
  
  Future<User> getUserProfile(BuildContext context) async{
    Response get = await _dioHelper.get(context ,
        path: URL.profile,);
    return User.fromRes(get.data);
  }
  
  Future<ComplaintsModel> addComplaints(BuildContext context ,User user,String msg)async{
    Response post = await _dioHelper.post(context ,
        path: URL.complaints,
        body: {
      "name": user.data.name,
      "phone": user.data.phone,
      "email": user.data.email,
      "message": msg
    },
      withToken: false
    );
    return ComplaintsModel.fromRes(post.data);
  }

}