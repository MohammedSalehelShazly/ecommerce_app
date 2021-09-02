import '../../cubit/profileCubit/profileCubit.dart';
import '../../cubit/profileCubit/profileStates.dart';
import '../../shared/styles/responsive.dart';
import '../../shared/localization/language_constants.dart';

import '../../cubit/profileCubit/updateProfileCubit.dart';
import '../../cubit/profileCubit/updateProfileStates.dart';
import '../../models/userModels/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../modules/login/loginScreenStr.dart';
import '../../shared/components/appButton.dart';
import '../../shared/components/loading/appProgress.dart';
import '../../shared/components/appTextField.dart';
import '../../shared/styles/colors.dart';

class UpdateProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileCubit ,UpdateProfileStates>(
      listener: (context ,state){},
      builder:(context ,state)=> LoginScreenStr(
        bottomPadding: 20,
        child: Form(
          key: UpdateProfileCubit.get(context).formUpdateKey,
          child: Column(
            children: [
              AppTextField(
                controller: UpdateProfileCubit.get(context).nameUpdateCtrl,
                focusNode: UpdateProfileCubit.get(context).nameUpdateFocus,
                onFieldSubmitted: (s){
                  UpdateProfileCubit.get(context).emailUpdateFocus.requestFocus();
                },
                textInputAction: TextInputAction.next,
                validator: (x){
                  if(x.trim().isNotEmpty)
                    return null;
                  else
                    return getTranslated(context, 'name must be filled');
                },
                hintText: getTranslated(context, 'name'),
                prefixIcon: Icon(Icons.perm_identity_rounded),
              ),
              responsive.smallSizedBox(context),
              AppTextField(
                  controller: UpdateProfileCubit.get(context).emailUpdateCtrl,
                  focusNode: UpdateProfileCubit.get(context).emailUpdateFocus,
                  onFieldSubmitted: (s){
                    UpdateProfileCubit.get(context).phoneUpdateFocus.requestFocus();
                    },
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
                controller: UpdateProfileCubit.get(context).phoneUpdateCtrl,
                focusNode: UpdateProfileCubit.get(context).phoneUpdateFocus,
                onFieldSubmitted: (s){
                  UpdateProfileCubit.get(context).passwordFocus.requestFocus();
                },
                textInputAction: TextInputAction.next,

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
              AppTextField(
                controller: UpdateProfileCubit.get(context).passwordCtrl,
                obscureText : UpdateProfileCubit.get(context).obscurePass,
                focusNode: UpdateProfileCubit.get(context).passwordFocus,
                textInputAction: TextInputAction.next,
                suffixIcon: IconButton(
                  icon: Icon(UpdateProfileCubit.get(context).obscurePass ? Icons.visibility_off_outlined :Icons.visibility_outlined),
                  onPressed:()=> UpdateProfileCubit.get(context).resetObscurePas(),
                ),
                validator: (x){
                  if(x.length >8)
                    return null;
                  else
                    return getTranslated(context, 'your password is not matching');
                },
                hintText: getTranslated(context, 'your password'),
                prefixIcon: Icon(Icons.vpn_key_outlined),
              ),
              responsive.smallSizedBox(context),

              BlocConsumer<ProfileCubit ,ProfileStates>(
                listener:(context ,profileStates){},
                builder:(context ,profileStates)=> AppButton(
                    content:
                    state is LoadingUpdateProfileState ? AppProgress()
                        : Text(getTranslated(context, 'Update') ,style: TextStyle(color: Colors.white),),
                    clr: appClrs.mainColor,
                    onPressed: () async{
                      if(UpdateProfileCubit.get(context).formUpdateKey.currentState.validate()){
                        bool update = await UpdateProfileCubit.get(context).update(
                          context: context,);
                        if(update){
                          await ProfileCubit.get(context).getUserProfile(
                              context: context,
                          );
                          Navigator.pop(context);
                        }
                      }
                    }),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
