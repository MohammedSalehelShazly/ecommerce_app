import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../cubit/profileCubit/profileCubit.dart';
import '../../cubit/profileCubit/profileStates.dart';
import '../styles/responsive.dart';
import '../../shared/components/appButton.dart';
import '../../shared/components/appTextField.dart';
import '../../shared/components/loading/appProgress.dart';
import '../../shared/localization/language_constants.dart';
import '../../shared/styles/colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AddComplaintsBtmSheet extends StatelessWidget {
  final BuildContext screenContext;
  AddComplaintsBtmSheet(this.screenContext);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit ,ProfileStates>(
      listener: (context ,state){},
      builder:(context ,state)=> BottomSheet(
          onClosing: (){
            Future.delayed(Duration(milliseconds: 600),(){
              ProfileCubit.get(context).disposeComplaintsMsgCtrl();
            });
          },
        enableDrag: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        builder: (context)=>
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    responsive.smallSizedBox(context),
                    Text(getTranslated(context, 'Enter your complaint and we will contact you as soon as possible'),
                      style: TextStyle(fontWeight: FontWeight.w400 ,fontSize: responsive.textScale(context)*18),
                      textAlign: TextAlign.center,
                    ),

                    responsive.smallSizedBox(context),
                    Form(
                      key: ProfileCubit.get(context).complaintsMsgForm,
                      child: AppTextField(
                          hintText: getTranslated(context, 'Make your message constructive'),
                          controller: ProfileCubit.get(context).complaintsMsgCtrl,
                          maxLines: 3,
                          textInputAction: TextInputAction.newline,
                          validator:(val){
                            if(val.trim().isEmpty){
                              return getTranslated(context, 'Enter your complaint');
                            }
                            else return null;
                          }
                      ),
                    ),
                    responsive.smallSizedBox(context),
                    AppButton(
                      clr: appClrs.mainColor,
                      content:
                      state is ComplaintsMsgLoadingState
                          ? AppProgress()
                          : Text(getTranslated(context, 'Send') ,style: TextStyle(color: Colors.white),),
                      onPressed:() async{
                        if(ProfileCubit.get(context).complaintsMsgForm.currentState.validate()){
                          await ProfileCubit.get(context).addComplaints(context);
                        }
                      },
                    ),
                    responsive.smallSizedBox(context),
                  ]
                ),
              ),
            ),
      ),
    );
  }
}
