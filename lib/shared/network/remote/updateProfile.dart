import 'package:dio/dio.dart';
import '../../../models/userModels/changePasswordModel.dart';
import '../../../models/userModels/updateProfileModel.dart';
import '../../../shared/network/remote/dioHelper.dart';
import 'package:flutter/cupertino.dart';
import '../../../shared/components/endPoints.dart';

class UpdateProfile{

  DioHelper _dioHelper = DioHelper();
  Future<UpdateProfileModel> updateProfile(
      {@required BuildContext context,
      @required Map<String, String> data}) async{
    Response post = await _dioHelper.put(context,
      path: URL.updateProfile ,
      body: data,
    );
   return UpdateProfileModel.froResp(post.data);
  }

  Future<ChangePasswordModel> changePassword(
      {@required dynamic currentPassword,
        @required dynamic newPassword,
        @required BuildContext context
      }) async{
    Response post = await _dioHelper.post(
      context,
        path: URL.changePassword ,
        body: {
          'current_password':'$currentPassword',
          'new_password':'$newPassword',
        },
    );
    return ChangePasswordModel.froResp(post.data);
  }

}