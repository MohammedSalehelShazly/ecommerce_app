
import '../../../cubit/loginCubit/loginCubit.dart';
import '../../../cubit/loginCubit/loginStates.dart';
import '../../../shared/styles/responsive.dart';
import '../../../shared/localization/language_constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/loginCubit/verifyCubit/verifyCubit.dart';
import '../../../cubit/loginCubit/verifyCubit/verifyStates.dart';
import '../../../modules/login/loginScreenStr.dart';
import '../../../shared/components/appButton.dart';
import '../../../shared/components/loading/appProgress.dart';
import '../../../shared/components/appTextField.dart';
import '../../../shared/styles/colors.dart';

class ResetPassowrdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyCubit,VerifyStates>(
      listener: (context ,state){},
      builder: (context ,state)=> LoginScreenStr(
        bottomPadding: 20,
        child: Column(children: [

          responsive.smallSizedBox(context),

          Form(
            key: VerifyCubit.get(context).passwordVerifyForm,
            child: AppTextField(

              controller: VerifyCubit.get(context).passwordVerifyCtrl,
              obscureText : VerifyCubit.get(context).obscurePassVerify,
              suffixIcon: IconButton(
                icon: Icon(VerifyCubit.get(context).obscurePassVerify ? Icons.visibility_off_outlined :Icons.visibility_outlined),
                onPressed:()=> VerifyCubit.get(context).resetObscurePassVerify(),
              ),
              validator: (x){
                if(x.length>=8)
                  return null;
                else
                  return 'password must be at least 8 characters';
              },
              hintText: '**********',
              prefixIcon: Icon(Icons.vpn_key_outlined),
            ),
          ),

          responsive.smallSizedBox(context),

          BlocConsumer<LoginCubit ,LoginStates>(
              listener: (context ,stateLogin){},
              builder:(context ,stateLogin)=> AppButton(
                content: state is LoadingVerifyNewPasswordState ? AppProgress()
                    : Text(getTranslated(context ,'Continue') ,style: TextStyle(color: Colors.white),),
                clr: appClrs.mainColor,
                onPressed: () async{

                  VerifyCubit.get(context).passwordVerifyForm.currentState.save();
                  if(VerifyCubit.get(context).passwordVerifyForm.currentState.validate()){
                    bool isSavedNewPass = await VerifyCubit.get(context).verifyNewPass(context);
                    if(isSavedNewPass)
                      LoginCubit.get(context).login(context,
                          VerifyCubit.get(context).emailVerifyCtrl.text,
                          VerifyCubit.get(context).passwordVerifyCtrl.text,);
                  }
                }),
          ),

          responsive.smallSizedBox(context),

        ],),
      ),
    );
  }
}
