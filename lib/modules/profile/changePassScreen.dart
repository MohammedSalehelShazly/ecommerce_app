import '../../cubit/loginCubit/loginCubit.dart';
import '../../cubit/loginCubit/loginStates.dart';
import '../../cubit/loginCubit/verifyCubit/verifyCubit.dart';
import '../../cubit/loginCubit/verifyCubit/verifyStates.dart';
import '../../cubit/profileCubit/profileCubit.dart';
import '../../cubit/profileCubit/profileStates.dart';
import '../../cubit/profileCubit/updateProfileCubit.dart';
import '../../cubit/profileCubit/updateProfileStates.dart';
import '../../shared/styles/responsive.dart';
import '../../modules/login/loginScreenStr.dart';
import '../../modules/login/verify/verifyEmailScreen.dart';
import '../../shared/components/appButton.dart';
import '../../shared/localization/language_constants.dart';
import '../../shared/components/loading/appProgress.dart';
import '../../shared/components/appTextField.dart';
import '../../shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileCubit,UpdateProfileStates>(
        listener: (context ,state){},
        builder: (context ,state)=> LoginScreenStr(
            bottomPadding: 10,
            child: Form(
              key: UpdateProfileCubit.get(context).changePasswordFrmK,
              child: Column(children: [

                responsive.smallSizedBox(context),

                AppTextField(
                  controller: UpdateProfileCubit.get(context).currentPasswordCtrl,
                  obscureText : UpdateProfileCubit.get(context).obscureCurrentPass,
                  focusNode: UpdateProfileCubit.get(context).currentPasswordFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (v){
                    UpdateProfileCubit.get(context).newPasswordFocus.requestFocus();
                  },
                  suffixIcon: IconButton(
                    icon: Icon(UpdateProfileCubit.get(context).obscureCurrentPass ? Icons.visibility_off_outlined :Icons.visibility_outlined),
                    onPressed:()=> UpdateProfileCubit.get(context).resetObscureCurrentPas(),
                  ),
                  validator: (x){
                    if(x.length>=8)
                      return null;
                    else
                      return getTranslated(context, 'password must be at least 8 characters');
                  },
                  hintText: getTranslated(context, 'Current password'),
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                ),

                responsive.smallSizedBox(context),

                AppTextField(
                  controller: UpdateProfileCubit.get(context).newPasswordCtrl,
                  obscureText : UpdateProfileCubit.get(context).obscureNewPassword,
                  focusNode: UpdateProfileCubit.get(context).newPasswordFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (v){
                    UpdateProfileCubit.get(context).newPasswordSecEnterFocus.requestFocus();
                  },

                  suffixIcon: IconButton(
                    icon: Icon(UpdateProfileCubit.get(context).obscureNewPassword ? Icons.visibility_off_outlined :Icons.visibility_outlined),
                    onPressed:()=> UpdateProfileCubit.get(context).setObscureNewPassword(),
                  ),
                  validator: (x){
                    if(x.length>=8)
                      return null;
                    else
                      return getTranslated(context, 'password must be at least 8 characters');
                  },
                  hintText: getTranslated(context, 'New password'),
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                ),

                responsive.smallSizedBox(context),

                AppTextField(
                  controller: UpdateProfileCubit.get(context).newPasswordSecEnterCtrl,
                  obscureText : UpdateProfileCubit.get(context).obscureNewPassword,
                  focusNode: UpdateProfileCubit.get(context).newPasswordSecEnterFocus,
                  validator: (x){
                    if(x == UpdateProfileCubit.get(context).newPasswordCtrl.text)
                      return null;
                    else
                      return getTranslated(context ,'Password are not matching');
                  },
                  hintText: getTranslated(context, 'Confirm new password'),
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                ),

                responsive.smallSizedBox(context),

                BlocConsumer<ProfileCubit ,ProfileStates>(
                  listener: (context ,profileState){},
                  builder: (context ,profileState)=> AppButton(
                      content: state is LoadingChangePassState ? AppProgress()
                          : Text(getTranslated(context, 'Change') ,style: TextStyle(color: Colors.white),),
                      clr: appClrs.mainColor,
                      onPressed: () async{
                        UpdateProfileCubit.get(context).changePasswordFrmK.currentState.save();
                        if(UpdateProfileCubit.get(context).changePasswordFrmK.currentState.validate()){
                          await UpdateProfileCubit.get(context).changePassword(context);}
                      }),
                ),

                responsive.smallSizedBox(context),

                BlocConsumer<ProfileCubit ,ProfileStates>(
                  listener: (context ,profileState){},
                  builder: (context ,profileState)=> Row(
                    children: [
                      BlocConsumer<VerifyCubit ,VerifyStates>(
                      listener:(context,verifystate){},
                        builder:(context,verifystate)=> TextButton(onPressed: (){
                          VerifyCubit.get(context).setEmailVerifyCtrl(ProfileCubit.get(context).user.data.email);
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> VerifyEmailScreen()));
                        },
                          child: Text( getTranslated(context, 'Forget password'),
                            style: TextStyle(color: appClrs.mainColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


              ],),
            ))
    );
  }
}
