
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

class VerifyEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyCubit,VerifyStates>(
      listener: (context ,state){},
      builder: (context ,state)=> LoginScreenStr(
        bottomPadding: 20,
        child: Column(children: [

          responsive.smallSizedBox(context),

          Form(
            key: VerifyCubit.get(context).emailVerifyForm,
            child: AppTextField(
              controller: VerifyCubit.get(context).emailVerifyCtrl,
              validator: (x){
                if(x.contains('@') || x.endsWith('.com'))
                  return null;
                else
                  return 'enter your email that you login with it';
              },
              hintText: 'your@example.com',
              prefixIcon: Icon(Icons.mail_outline),
                alwaysLeftDirection:true
            ),
          ),

          responsive.smallSizedBox(context),

          AppButton(
              content: state is LoadingVerifyEmailState ? AppProgress()
                  : Text(getTranslated(context ,'Continue') ,style: TextStyle(color: Colors.white),),
              clr: appClrs.mainColor,
              onPressed: () async{
                VerifyCubit.get(context).emailVerifyForm.currentState.save();

                if(VerifyCubit.get(context).emailVerifyForm.currentState.validate()){
                  await VerifyCubit.get(context).verifyEmail(
                      context,
                      //VerifyCubit.get(context).emailVerifyCtrl.text,
                      );
                }
              }),

          responsive.smallSizedBox(context),

        ],),
      ),
    );
  }
}
