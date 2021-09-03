import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../cubit/loginCubit/verifyCubit/verifyCubit.dart';
import '../../cubit/loginCubit/verifyCubit/verifyStates.dart';
import '../../shared/localization/language_constants.dart';
import '../../modules/login/verify/verifyEmailScreen.dart';
import '../../shared/components/loading/appProgress.dart';
import '../../cubit/loginCubit/loginCubit.dart';
import '../../cubit/loginCubit/loginStates.dart';
import '../../shared/styles/responsive.dart';
import '../../modules/login/loginScreenStr.dart';
import '../../modules/login/signUpScreen.dart';
import '../../shared/components/appButton.dart';
import '../../shared/components/appTextField.dart';
import '../../shared/styles/colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocConsumer<LoginCubit ,LoginStates>(
      listener: (context ,state){},
      builder:(context ,state){
        return LoginScreenStr(
          bottomPadding: 80,
          child: Form(
            key: LoginCubit.get(context).formLoginKey,
            child: Column(
              children: [

                AppTextField(
                    controller: LoginCubit.get(context).emailLoginCtrl,
                    focusNode: LoginCubit.get(context).emailLoginFocus,
                    onFieldSubmitted: (val){
                      LoginCubit.get(context).passwordLoginFocus.requestFocus();
                    },
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
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
                  obscureText : LoginCubit.get(context).obscurePassRegister,
                  focusNode: LoginCubit.get(context).passwordLoginFocus,
                  suffixIcon: IconButton(
                    icon: Icon(LoginCubit.get(context).obscurePassRegister ? Icons.visibility_off_outlined :Icons.visibility_outlined),
                    onPressed:()=> LoginCubit.get(context).setObscurePassRegister(),
                  ),


                  controller: LoginCubit.get(context).passwordLoginCtrl,
                  validator: (x){
                    if(x.trim().isNotEmpty)
                      return null;
                    else
                      return getTranslated(context, 'password must be filled');
                  },
                  hintText: '**********',
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                ),


                responsive.smallSizedBox(context),

                AppButton(
                    content: state is LoginLoadingState ? AppProgress()
                        : Text(getTranslated(context ,'Continue') ,style: TextStyle(color: Colors.white),),
                    clr: appClrs.mainColor,
                    onPressed: () async{
                      if(LoginCubit.get(context).formLoginKey.currentState.validate()){
                        await LoginCubit.get(context).login(context ,
                          LoginCubit.get(context).emailLoginCtrl.text,
                          LoginCubit.get(context).passwordLoginCtrl.text,);
                      }
                    }),


                responsive.smallSizedBox(context),

                Row(children: [
                  Text(getTranslated(context, "Don't have an account") + ' ?'),
                  TextButton(
                    onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> SignUpScreen())),
                    child: Text(getTranslated(context ,'Sign Up'),
                      style: TextStyle(color: appClrs.mainColor),),
                  )
                ],),

                Row(
                  children: [
                    BlocConsumer<VerifyCubit,VerifyStates>(
                      listener: (context ,verifyState){},
                      builder: (context ,verifyState)=> TextButton(
                        onPressed: (){
                          VerifyCubit.get(context).setEmailVerifyCtrl(LoginCubit.get(context).emailLoginCtrl.text);
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> VerifyEmailScreen()));
                      },
                        child: Text( getTranslated(context, 'Forget password'),
                          style: TextStyle(color: appClrs.mainColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],),
          ),
        );

      }
    ));
  }
}