
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

import '../../shared/components/staticVariables.dart';
import '../../models/userModels/changePasswordModel.dart';
import '../../models/userModels/updateProfileModel.dart';
import '../../shared/network/remote/updateProfile.dart';
import '../../cubit/profileCubit/updateProfileStates.dart';
import '../../models/userModels/userModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileStates>{

  UpdateProfileCubit() :super(InitUpdateProfileState());
  static UpdateProfileCubit get(context)=> BlocProvider.of(context);

  UpdateProfile _updateProfile = UpdateProfile();

  TextEditingController emailUpdateCtrl;
  TextEditingController nameUpdateCtrl ;
  TextEditingController phoneUpdateCtrl;
  TextEditingController passwordCtrl; // it used when update profile
  GlobalKey<FormState> formUpdateKey = GlobalKey<FormState>();

  FocusNode emailUpdateFocus;
  FocusNode nameUpdateFocus;
  FocusNode phoneUpdateFocus;
  FocusNode passwordFocus;

  bool obscurePass = true;
  resetObscurePas(){
    obscurePass = !obscurePass;
    emit(ObscurePassState());
  }



  TextEditingController currentPasswordCtrl;
  TextEditingController newPasswordCtrl;
  TextEditingController newPasswordSecEnterCtrl;
  FocusNode currentPasswordFocus;
  FocusNode newPasswordFocus;
  FocusNode newPasswordSecEnterFocus;
  GlobalKey<FormState> changePasswordFrmK = GlobalKey<FormState>();

  setPasswordsCtrl(){
    currentPasswordCtrl = TextEditingController();
    newPasswordCtrl = TextEditingController();
    newPasswordSecEnterCtrl = TextEditingController();
    currentPasswordFocus = FocusNode();
    newPasswordFocus = FocusNode();
    newPasswordSecEnterFocus = FocusNode();
    emit(SetPasswordsCtrlState());
  }
  disposePasswordsCtrl(){
    currentPasswordCtrl.dispose();
    newPasswordCtrl.dispose();
    newPasswordSecEnterCtrl.dispose();
    currentPasswordFocus.dispose();
    newPasswordFocus.dispose();
    newPasswordSecEnterFocus.dispose();
    emit(SetPasswordsCtrlState());
  }



  bool obscureCurrentPass = true;
  resetObscureCurrentPas(){
    obscureCurrentPass = !obscureCurrentPass;
    emit(ObscurePassState());
  }
  bool obscureNewPassword = true;
  setObscureNewPassword(){
    obscureNewPassword = !obscureNewPassword;
    emit(ObscurePassState());
  }

  ChangePasswordModel changePasswordModel;
  changePassword(BuildContext context,) async{

    emit(LoadingChangePassState());
    try{
      changePasswordModel = await _updateProfile.changePassword(
          currentPassword:currentPasswordCtrl.text ,
          newPassword:newPasswordCtrl.text,
          context: context);
      if(changePasswordModel.status){
        currentPasswordCtrl = TextEditingController();
        newPasswordCtrl = TextEditingController();
        newPasswordSecEnterCtrl = TextEditingController();
        Navigator.pop(context);
      }
      staticVars.showToast(context, changePasswordModel.message);

    }on Exception catch (e){
      print(e);
    }finally{
      emit(ChangePassState());
    }

  }



  setFieldsCtrl(User user){
    emailUpdateCtrl = TextEditingController(text: user.data.email );
    nameUpdateCtrl = TextEditingController(text: user.data.name );
    phoneUpdateCtrl = TextEditingController(text: user.data.phone );
    passwordCtrl = TextEditingController();
    emailUpdateFocus = FocusNode();
    nameUpdateFocus = FocusNode();
    phoneUpdateFocus = FocusNode();
    passwordFocus = FocusNode();
    emit(SetFieldsCtrlUpdateProfileState());
  }

  disposeFieldsCtrl(){
    emailUpdateCtrl.dispose();
    nameUpdateCtrl.dispose();
    phoneUpdateCtrl.dispose();
    passwordCtrl.dispose();
    emailUpdateFocus.dispose();
    nameUpdateFocus.dispose();
    phoneUpdateFocus.dispose();
    passwordFocus.dispose();
    emit(SetFieldsCtrlUpdateProfileState());
  }

  UpdateProfileModel updateProfileModel;
  Future<bool> update({@required BuildContext context}) async{
    emit(LoadingUpdateProfileState());
    try{
      updateProfileModel = await _updateProfile.updateProfile(
          context :context,
          data: {
            'email' :emailUpdateCtrl.text,
            'name' :nameUpdateCtrl.text,
            'phone' :phoneUpdateCtrl.text,
            'password':passwordCtrl.text
          });

      staticVars.showToast(context, updateProfileModel.message);

      return updateProfileModel.status;

    }on Exception catch(e){
      print(e);
    }finally{
      emit(UpdateProfileState());
    }
  }









}