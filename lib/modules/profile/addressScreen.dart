import '../../cubit/addressCubit/addressCubit.dart';
import '../../cubit/addressCubit/addressStates.dart';
import '../../cubit/profileCubit/profileCubit.dart';
import '../../cubit/profileCubit/profileStates.dart';
import '../../shared/styles/responsive.dart';
import '../../modules/login/loginScreenStr.dart';
import '../../shared/components/appButton.dart';
import '../../shared/components/appDialog.dart';
import '../../shared/components/appTextField.dart';
import '../../shared/components/enums.dart';
import '../../shared/components/loading/appProgress.dart';
import '../../shared/components/loading/appProgressPage.dart';
import '../../shared/localization/language_constants.dart';
import '../../shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressScreen extends StatelessWidget {
  addressFunction function;
  AddressScreen(this.function);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit ,AddressStates>(
      listener: (context ,state){},
      builder:(context ,state) {

        if(AddressCubit.get(context).firstBuildAddAddress){
          if(function == addressFunction.add || function == addressFunction.updateWithCurrent)
            AddressCubit.get(context).getAddressDetails(context);

          else if(function == addressFunction.updateWithOld && AddressCubit.get(context).getAddressModel !=null)
            AddressCubit.get(context).fillCtrlWithOld();
        }

        return AppProgressPage(
          conditional:
          function == addressFunction.add || function == addressFunction.updateWithCurrent
              ? state is SetFirstBuildAddAddressState || state is UserLocationLoadingState
              : false,
          child: LoginScreenStr(
                  bottomPadding: 20,
                  child: Form(
                    key: AddressCubit.get(context).addressFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getTranslated(context, 'Name of address')),
                        AppTextField(
                          controller: AddressCubit.get(context).addressNameCtrl,
                          validator: (x) {
                            if (x.trim().isNotEmpty)
                              return null;
                            else
                              return getTranslated(
                                  context, 'please enter name of your address');
                          },
                          hintText: getTranslated(context, 'home ,work ,..'),
                        ),

                        responsive.smallSizedBox(context),

                        Text(getTranslated(context, 'City')),
                        AppTextField(
                          controller: AddressCubit.get(context).addressCityCtrl,
                          enabled: false,
                          validator: (x) {
                            if (x.trim().isNotEmpty)
                              return null;
                            else
                              return getTranslated(
                                  context, 'please enter your city');
                          },
                          hintText: getTranslated(context, 'city'),
                        ),

                        responsive.smallSizedBox(context),

                        Text(getTranslated(context, 'Region')),
                        AppTextField(
                          controller: AddressCubit.get(context).addressRegionCtrl,
                          enabled: false,
                          validator: (x) {
                            if (x.trim().isNotEmpty)
                              return null;
                            else
                              return getTranslated(
                                  context, 'please enter your region');
                          },
                          hintText: getTranslated(context, 'region'),
                        ),

                        responsive.smallSizedBox(context),

                        Text(getTranslated(context, 'Address Details')),
                        AppTextField(
                          controller:
                          AddressCubit.get(context).addressDetailsCtrl,
                          enabled: false,
                          validator: (x) {
                            if (x.trim().isNotEmpty)
                              return null;
                            else
                              return getTranslated(
                                  context, 'please enter your address details');
                          },
                          hintText: getTranslated(context, 'address details'),
                        ),

                        responsive.smallSizedBox(context),

                        Text(getTranslated(context, 'Notes of Address')),
                        AppTextField(
                          controller: AddressCubit.get(context).addressNotesCtrl,
                          validator: (x) => null,
                        ),

                        responsive.smallSizedBox(context),

                        AppButton(
                            content: state is AddressLoadingState || state is SetAddressCtrlState
                                ? AppProgress()
                                : Text(getTranslated(context ,
                                function == addressFunction.updateWithOld || function == addressFunction.updateWithCurrent
                                  ? 'Update' : 'Save'
                            ) ,style: TextStyle(color: Colors.white),),
                            clr: appClrs.mainColor,
                            onPressed: () async{
                              if(AddressCubit.get(context).addressFormKey.currentState.validate()){
                                if(function == addressFunction.updateWithOld || function == addressFunction.updateWithCurrent){
                                  AddressCubit.get(context).updateAddress(context);
                                }
                                else{
                                  await AddressCubit.get(context).postAddress(context);
                                }
                              }
                            }),
                        responsive.smallSizedBox(context),

                        if(function != addressFunction.add)
                          AppButton(
                            clr: Colors.red,
                            content: state is DeleteAddressLoadingState
                                ? AppProgress()
                                : Text(getTranslated(context, 'Delete') ,style: TextStyle(color: Colors.white),),
                            onPressed:(){
                              showCupertinoDialog(context: context, builder: (_)=> AppDialog(
                                screenCtx: context,
                                content: getTranslated(context, 'Are you sour to delete your address ?'),
                                doneActionTitle: getTranslated(context, 'Delete'),
                                doneAction: () async{
                                  AddressCubit.get(context).deleteAddress(context);
                                },
                              ));
                            },
                          ),

                        if(function != addressFunction.add)
                          responsive.smallSizedBox(context),

                      ],
                    ),
                  ),
                ),
        );
            });
  }
}
