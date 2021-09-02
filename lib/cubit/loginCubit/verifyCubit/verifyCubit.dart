
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/loginCubit/verifyCubit/verifyStates.dart';
import '../../../shared/components/staticVariables.dart';
import '../../../models/loginModels/verifyCodeModel.dart';
import '../../../models/loginModels/verifyEmailModel.dart';
import '../../../models/loginModels/verifyNewPassModel.dart';
import '../../../modules/login/verify/resetPassowrdScreen.dart';
import '../../../modules/login/verify/verifyCodeScreen.dart';
import '../../../shared/network/remote/emailLogin.dart';
import '../../../modules/login/loginScreen.dart';


class VerifyCubit extends Cubit<VerifyStates>{

  VerifyCubit() : super (InitVerifyStates());
  static VerifyCubit get(context) => BlocProvider.of(context);

  EmailLogin _emailLogin = EmailLogin();

  TextEditingController emailVerifyCtrl = TextEditingController();
  TextEditingController codeVerifyCtrl = TextEditingController();
  setCodeVerifyCtrl(TextEditingController _ctrl){
    codeVerifyCtrl = _ctrl;
    emit(SetCodeVerifyCtrl());
  }
  TextEditingController passwordVerifyCtrl = TextEditingController();

  GlobalKey<FormState> emailVerifyForm = GlobalKey<FormState>();
  GlobalKey<FormState> passwordVerifyForm = GlobalKey<FormState>();


  bool obscurePassVerify = true;
  resetObscurePassVerify(){
    obscurePassVerify = !obscurePassVerify;
    emit(ObscurePassVerifyState());
  }

  // set emailCtrl if already write the email
  setEmailVerifyCtrl(String txt){
    emailVerifyCtrl = TextEditingController(text: txt);
    emit(SetEmailVerifyCtrlState());
  }

  VerifyEmailModel verifyEmailModel;
  verifyEmail(BuildContext context)async{
    emit(LoadingVerifyEmailState());

    try{
      verifyEmailModel = await _emailLogin.verifyEmail(context ,emailVerifyCtrl.text);

      if (verifyEmailModel.status) {
        VerifyCubit.get(context).setCodeVerifyCtrl(TextEditingController());
        Navigator.push(
            context, CupertinoPageRoute(builder: (_) => VerifyCodeScreen()));
      }

      staticVars.showToast(context, verifyEmailModel.message);
    } on Exception catch(e){
      print(e);
    }finally{
      emit(VerifyEmailState());
    }
  }


  VerifyCodeModel verifyCodeModel;
  verifyCode(BuildContext context)async{
    emit(LoadingVerifyCodeState());

    try{
      verifyCodeModel = await _emailLogin.verifyCode(context ,emailVerifyCtrl.text ,codeVerifyCtrl.text);

      if(verifyCodeModel.status) {
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (_) => ResetPassowrdScreen()));
      }

      if(verifyCodeModel.message !=null || verifyCodeModel.message.trim()!='')
        staticVars.showToast(context, verifyCodeModel.message);

    } on Exception catch(e){
      print(e);
    }finally{
      emit(VerifyCodeState());
    }
  }




  VerifyNewPassModel verifyNewPassModel;
  Future<bool> verifyNewPass(BuildContext context)async{

    emit(LoadingVerifyNewPasswordState());

    try{
      verifyNewPassModel = await _emailLogin.verifyNewPass(
          context ,
          email: emailVerifyCtrl.text ,
          code: codeVerifyCtrl.text ,
          password: passwordVerifyCtrl.text);

      staticVars.showToast(context, verifyNewPassModel.message);
      return verifyNewPassModel.status;

    } on Exception catch(e){
      print(e);
      return Future.value(false);
    }finally{
      emit(VerifyNewPasswordState());
    }
  }


}