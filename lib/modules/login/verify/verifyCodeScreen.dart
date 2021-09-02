import '../../../shared/styles/responsive.dart';
import '../../../shared/localization/language_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../cubit/loginCubit/verifyCubit/verifyCubit.dart';
import '../../../cubit/loginCubit/verifyCubit/verifyStates.dart';
import '../../../modules/login/loginScreenStr.dart';
import '../../../shared/components/loading/appProgress.dart';
import '../../../shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyCubit,VerifyStates>(
      listener: (context ,state){},
      builder: (context ,state)=> LoginScreenStr(
        bottomPadding: 20,
        child: Column(children: [

          responsive.smallSizedBox(context),

          state is LoadingVerifyCodeState
                ? AppProgress()
                : Text(getTranslated(context, 'Enter verify code')),
            responsive.smallSizedBox(context),

          PinCodeTextField(
            appContext: context,
            controller: VerifyCubit.get(context).codeVerifyCtrl,
            length: 4,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.transparent,
              inactiveFillColor: Colors.transparent,
              selectedFillColor: appClrs.mainColor,
              selectedColor: appClrs.mainColor,
              inactiveColor: Colors.black54,

            ),
            animationDuration: Duration(milliseconds: 300),
            enableActiveFill: true,
            //errorAnimationController: errorController,
            onCompleted: (v) async{
              print("Completed");
              await VerifyCubit.get(context)
                  .verifyCode(context);
            },
            onChanged: (value) {},
            beforeTextPaste: (text)=> true, // show the paste confirmation dialog
          ),

          responsive.smallSizedBox(context),


        ],),
      ),
    );
  }
}
