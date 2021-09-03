import '../../shared/localization/language_constants.dart';

import '../../shared/components/loading/appProgress.dart';

import '../../modules/home/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../cubit/loginCubit/loginCubit.dart';
import '../../cubit/loginCubit/loginStates.dart';
import '../../shared/styles/responsive.dart';
import '../../modules/login/loginScreenStr.dart';
import '../../shared/components/appButton.dart';
import '../../shared/components/appTextField.dart';
import '../../shared/styles/colors.dart';


class SignUpScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit ,LoginStates>(
      listener: (context ,state){},
      builder:(context ,state)=> LoginScreenStr(
        bottomPadding: 5,
        isRegister: true,
        child: Form(
          key: LoginCubit.get(context).formRegisterKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              responsive.smallSizedBox(context),

              Text(getTranslated(context, "Looks like you don't have an account.Let's create a new account for you")),

              responsive.smallSizedBox(context),

              AppTextField(
                controller: LoginCubit.get(context).nameRegisterCtrl,
                focusNode: LoginCubit.get(context).nameRegisterFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val){
                  LoginCubit.get(context).emailRegisterFocus.requestFocus();
                },
                validator: (x){
                  if(x.trim().isNotEmpty)
                    return null;
                  else
                    return getTranslated(context, 'User name must be filled');
                },
                hintText: getTranslated(context, 'user name'),
                prefixIcon: Icon(Icons.perm_identity_rounded),
              ),

              responsive.smallSizedBox(context),

              AppTextField(
                  controller: LoginCubit.get(context).emailRegisterCtrl,
                  focusNode: LoginCubit.get(context).emailRegisterFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (val){
                    LoginCubit.get(context).passwordRegisterFocus.requestFocus();
                  },
                  textInputType: TextInputType.emailAddress,
                  validator: (x){
                    if(x.contains('@') || x.endsWith('.com'))
                      return null;
                    else
                      return getTranslated(context, 'email must be written as')+': name@example.com';
                  },
                  hintText: 'name@example.com',
                  prefixIcon: Icon(Icons.mail_outline),
                  alwaysLeftDirection:true
              ),

              responsive.smallSizedBox(context),

              AppTextField(
                  controller: LoginCubit.get(context).passwordRegisterCtrl,
                  obscureText : LoginCubit.get(context).obscurePassLogin,
                  focusNode: LoginCubit.get(context).passwordRegisterFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (val){
                    LoginCubit.get(context).phoneRegisterFocus.requestFocus();
                  },
                  suffixIcon: IconButton(
                    icon: Icon(LoginCubit.get(context).obscurePassLogin ? Icons.visibility_off_outlined :Icons.visibility_outlined),
                    onPressed:()=> LoginCubit.get(context).setObscurePassLogin(),
                  ),
                  validator: (x){
                    if(x.length>=8)
                      return null;
                    else
                      return getTranslated(context, 'password must be at least 8 characters');
                  },
                  hintText: '**********',
                  prefixIcon: Icon(Icons.vpn_key_outlined),
              ),
              responsive.smallSizedBox(context),

              AppTextField(
                controller: LoginCubit.get(context).phoneRegisterCtrl,
                focusNode: LoginCubit.get(context).phoneRegisterFocus,
                textInputType: TextInputType.phone,
                validator: (x){
                  if(x.trim().isNotEmpty)
                    return null;
                  else
                    return getTranslated(context, 'phone must be filled');
                },
                hintText: getTranslated(context, 'phone'),
                prefixIcon: Icon(Icons.smartphone_outlined),
              ),
              responsive.smallSizedBox(context),

              Row(
                children: [Text(getTranslated(context ,'By selecting Agree and Continue below,'),),],
              ),

              responsive.smallSizedBox(context),

              Row(children: [
                Checkbox(
                  visualDensity: VisualDensity.compact,
                    value: LoginCubit.get(context).agreePrivacyPolice,
                    onChanged: (val){
                      LoginCubit.get(context).reverseAgreePrivacyPolice();
                    }),
                Text(getTranslated(context, 'I agree to')+' ' ,style: TextStyle(fontSize: 12),),
                TextButton(
                    style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
                    onPressed: (){},
                    child: Text(getTranslated(context ,'Terms of Services') ,style: TextStyle(color: appClrs.mainColor ,fontWeight: FontWeight.bold ,fontSize: 12),)),
                Text(getTranslated(context ,'and') ,style: TextStyle(color: appClrs.mainColor ,fontSize: 12),),
                TextButton(
                    style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
                    onPressed: (){},
                    child: Text(getTranslated(context ,'Privacy Policy') ,style: TextStyle(color: appClrs.mainColor ,fontWeight: FontWeight.bold ,fontSize: 12),))
              ],),

              responsive.smallSizedBox(context),

              AppButton(
                  content:
                  state is LoginLoadingState ? AppProgress()
                      : Text(getTranslated(context, 'Agree and Continue') ,style: TextStyle(color: Colors.white),),
                  clr: appClrs.mainColor,
                  onPressed: () async{
                    if(LoginCubit.get(context).formRegisterKey.currentState.validate()){
                      await LoginCubit.get(context).register(context,);
                    }
                  }),

            ],),
        ),
      ),
    );
  }
}