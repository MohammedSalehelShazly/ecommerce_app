import '../../modules/profile/changePassScreen.dart';
import '../../shared/localization/language_constants.dart';

import '../../cubit/profileCubit/profileCubit.dart';
import '../../cubit/profileCubit/profileStates.dart';
import '../../cubit/profileCubit/updateProfileCubit.dart';
import '../../cubit/profileCubit/updateProfileStates.dart';
import '../../modules/profile/updateProfileScreen.dart';
import '../../shared/components/logoutBtn.dart';
import '../../shared/components/profileHeader.dart';

import '../../shared/styles/responsive.dart';
import '../../shared/components/appListTile.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocConsumer<ProfileCubit ,ProfileStates>(
        listener: (context ,state){},
        builder:(context ,state){
          return Scaffold(
            body:

            ListView(children: [

              Container(
                  height: responsive.responsiveHigh(context, 0.40),
                  child: ProfileHeader(
                    loading: state is LoadingProfileState || ProfileCubit.get(context).user==null,
                    user: ProfileCubit.get(context).user,
                  )),

              SizedBox(height: responsive.responsiveHigh(context, 0.03),),

              BlocConsumer<UpdateProfileCubit ,UpdateProfileStates>(
                listener: (context ,updateProfileState){},
                builder:(context ,updateProfileState) {
                  return AppListTile(
                      txt: getTranslated(context, 'Edit profile'),
                      trailing: Icon(Icons.edit_outlined),
                      onTap: () {
                        UpdateProfileCubit.get(context).setFieldsCtrl(
                            ProfileCubit.get(context).user);
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (_) => UpdateProfileScreen()))
                            .then((_){
                              Future.delayed(Duration(milliseconds: 500),(){
                                UpdateProfileCubit.get(context).disposeFieldsCtrl();
                              });
                            });
                      });
                  },
              ),

              BlocConsumer<UpdateProfileCubit ,UpdateProfileStates>(
                listener: (context ,state){},
                builder:(context ,state)=> AppListTile(
                    txt: getTranslated(context, 'Change password'),
                    trailing: Icon(Icons.lock_open_outlined),
                    onTap:() async{
                      await UpdateProfileCubit.get(context).setPasswordsCtrl();
                      Navigator.push(context, CupertinoPageRoute(builder: (_)=> ChangePassScreen())).then((_){
                        Future.delayed(Duration(milliseconds: 500),(){
                          UpdateProfileCubit.get(context).disposePasswordsCtrl();
                        });
                      });
                    }
                ),
              ),

              LogoutBtn(),

            ],),
          );

        }


    ));
  }
}
