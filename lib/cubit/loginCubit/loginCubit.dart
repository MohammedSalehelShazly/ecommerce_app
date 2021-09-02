import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/loginModels/loginModel.dart';
import '../../models/loginModels/logoutModel.dart';
import '../../models/loginModels/registerModel.dart';
import 'loginStates.dart';
import '../../shared/components/staticVariables.dart';
import '../../shared/network/remote/emailLogin.dart';
import '../../shared/network/local/sharedPreferences.dart';
import '../../modules/login/loginScreen.dart';
import '../../shared/components/appDialog.dart';
import '../../modules/home/homePage.dart';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit() : super(LoginInitialStates());
  static LoginCubit get(BuildContext context)=> BlocProvider.of(context);

  final CarouselController carouselController = CarouselController();

  int currentIndexOfIntroScreen = 0;
  setCurrentIndexOfIntroScreen(int _index){
    currentIndexOfIntroScreen = _index;
    emit(CurrentIndexOfIntroScreenState());
  }

  TextEditingController emailLoginCtrl;
  TextEditingController passwordLoginCtrl;
  bool obscurePassLogin = true;
  GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();


  TextEditingController emailRegisterCtrl;
  TextEditingController passwordRegisterCtrl;
  TextEditingController nameRegisterCtrl;
  TextEditingController phoneRegisterCtrl;
  bool obscurePassRegister = true;
  GlobalKey<FormState> formRegisterKey = GlobalKey<FormState>();

  setLoginCtrl(){
    emailRegisterCtrl = TextEditingController();
    passwordRegisterCtrl = TextEditingController();
    nameRegisterCtrl = TextEditingController();
    phoneRegisterCtrl = TextEditingController();
    emailLoginCtrl = TextEditingController();
    passwordLoginCtrl = TextEditingController();
    emit(SetObscurePassLoginState());
  }
  disposeLoginCtrl(){
    emailRegisterCtrl.dispose();
    passwordRegisterCtrl.dispose();
    nameRegisterCtrl.dispose();
    phoneRegisterCtrl.dispose();
    emailLoginCtrl.dispose();
    passwordLoginCtrl.dispose();
    emit(SetObscurePassLoginState());
  }

  setObscurePassLogin(){
    obscurePassLogin = !obscurePassLogin;
    emit(ObscurePassLoginState());
  }

  setObscurePassRegister(){
    obscurePassRegister = !obscurePassRegister;
    emit(ObscurePassRegisterState());
  }

  String token ='';

  getIsLoginStored([bool loginNow =false]) async{
    token = await sharedPreferencesHelper.getToken();
    emit(LoginLoginState());
  }





  EmailLogin _emailLogin = EmailLogin();

  LoginModel loginModel;
  login(BuildContext context ,String email ,String password) async{
    emit(LoginLoadingState());
    try{
      loginModel = await _emailLogin.login(context ,email ,password);

      /// /......................../getIsLoginStored(true); // should get user to update bool val

      if(loginModel.status){ // login is success ?
        token = loginModel.data.token;
        /// set user && stored
        await sharedPreferencesHelper.setToken(token);
        staticVars.showToast(context ,'${loginModel.message}');
        Future.delayed(Duration(seconds: 1),(){
          disposeLoginCtrl();
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => HomePage()));
      }
      else{
        showDialog(context: context, builder: (_)=> AppDialog(
          content: loginModel.message,
          doneActionTitle: 'Ok',
          screenCtx: context,
          appearCancelBtn: false,
          doneAction: ()=> Navigator.pop(context),
        ));
      }
    }on Exception catch (e) {
      print(e);
    }finally{
      emit(LoginLoginState());
    }
  }


  RegisterModel registerModel;
  register(BuildContext context) async{
    emit(LoginLoadingState());
    try{
      registerModel = await _emailLogin.register(context ,{
        'name' : '${nameRegisterCtrl.text}',
        'email' :'${emailRegisterCtrl.text}',
        'password' :'${passwordRegisterCtrl.text}',
        'phone' : phoneRegisterCtrl.text
      });

      /// /......................../getIsLoginStored(true); // should get user to update bool val

      if(registerModel.status){ // register is success ?
        token = registerModel.data.token;
        /// set user && stored
        await sharedPreferencesHelper.setToken(token);
        staticVars.showToast(context ,'${registerModel.message}');
        Future.delayed(Duration(seconds: 1),(){
          disposeLoginCtrl();
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => HomePage()));
      }
      else{
        showDialog(context: context, builder: (_)=> AppDialog(
          content: registerModel.message,
          doneActionTitle: 'Ok',
          screenCtx: context,
          appearCancelBtn: false,
          doneAction: ()=> Navigator.pop(context),
        ));
      }
    }on Exception catch (e) {
      print(e);
    }finally{
      emit(LoginLoginState());
    }
  }



  LogoutModel logoutModel;
  logout(BuildContext context) async{
    emit(LogoutLoadingState());
    try{
      logoutModel = await _emailLogin.logout(context);

      if(logoutModel.status){ // logout is success ?
        /// set user && stored
        token = '';
        await sharedPreferencesHelper.setToken('');
        getIsLoginStored();
        await setLoginCtrl();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => LoginScreen()));
      }

      staticVars.showToast(context, logoutModel.message);

    }on Exception catch(e){
      print(e);
    }finally{
      emit(LoginLogoutState());
    }
  }


  bool agreePrivacyPolice = false;
  reverseAgreePrivacyPolice(){
    agreePrivacyPolice = !agreePrivacyPolice;
    emit(LoginAgreePrivacyPoliceState());
  }



}