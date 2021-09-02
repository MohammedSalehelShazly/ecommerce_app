
import '../../../shared/network/remote/dioHelper.dart';
import 'package:flutter/cupertino.dart';

import 'package:dio/dio.dart';

import '../../../models/loginModels/verifyCodeModel.dart';
import '../../../models/loginModels/verifyEmailModel.dart';
import '../../../models/loginModels/verifyNewPassModel.dart';
import '../../../models/loginModels/loginModel.dart';
import '../../../models/loginModels/logoutModel.dart';
import '../../../models/loginModels/registerModel.dart';
import '../../../shared/components/endPoints.dart';

class EmailLogin{


  DioHelper _dioHelper = DioHelper();


  Future<LoginModel> login(BuildContext context ,String email ,String password) async {
    Response post = await _dioHelper.post(context ,
        path: URL.login ,
        body: {
      'email' :email,
      'password' :password,
    },
        withToken: false
    );
    return LoginModel.fromRes(post.data);
  }
  Future<RegisterModel> register(BuildContext context ,Map<String ,dynamic> dataRegister) async{
    Response post = await _dioHelper.post(context ,
        path: URL.register ,
        body: {
      'name' :dataRegister['name'],
      'email' :dataRegister['email'],
      'password' :dataRegister['password'],
      'phone' :dataRegister['phone'],
    },
      withToken: false
    );
    return RegisterModel.fromRes(post.data);
  }



  /// when login (email is alrady saved)
  /// its verify to reset password
  Future<VerifyEmailModel> verifyEmail(BuildContext context ,String email)async{
    Response post = await _dioHelper.post(context ,
        path: URL.verifyEmail,
        body: {
      'email' : email
    },
        withToken: false
    );

    return VerifyEmailModel.froResp(post.data);
  }

  Future<VerifyCodeModel> verifyCode(BuildContext context ,String email ,String code)async{
    Response post = await _dioHelper.post(context ,
        path: URL.verifyCode,
        body: {
      'email' : email,
      'code' : code
    },
        withToken: false
    );
    return VerifyCodeModel.fromRes(post.data);
  }


  Future<VerifyNewPassModel> verifyNewPass(
      BuildContext context,
      {@required String email,
        @required String password,
        @required String code})async{
    Response post = await _dioHelper.post(context ,
        path: URL.verifyNewPAss,
        body: {
      'email' : email,
      'code' : code,
      'password': password
    },
        withToken: false
    );
    return VerifyNewPassModel.fromRes(post.data);
  }


  Future<LogoutModel> logout(BuildContext context) async {
    Response post = await _dioHelper.post(context,
        path: URL.logout);
    return LogoutModel.fromRes(post.data);
  }

}












