import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared/components/ContactUs/contactUsList.dart';
import '../../cubit/homeCubit/homeCubit.dart';
import '../../cubit/homeCubit/homeState.dart';
import '../../cubit/profileCubit/profileCubit.dart';
import '../../cubit/profileCubit/profileStates.dart';
import '../../shared/components/addComplaintsBtmSheet.dart';
import '../../shared/components/appListTile.dart';
import '../../shared/components/changeLangWidget.dart';
import '../../shared/localization/language_constants.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Card(
                child: AppListTile(
                  txt: getTranslated(context, 'language'),
                  trailing: const Icon(Icons.language_outlined),
                  margin: const EdgeInsets.all(0),
                  onTap:(){
                    showDialog(context: context, builder: (_)=>
                        ChangeLangWidget());
                  },
                ),
              ),

              BlocConsumer<ProfileCubit ,ProfileStates>(
                listener: (context ,state){},
                builder:(ctx ,state)=> Card(
                  child: AppListTile(
                    txt: getTranslated(context, 'For complaints and suggestions'),
                    trailing: const Icon(Icons.mode_comment_outlined),
                    margin: const EdgeInsets.all(0),
                    onTap:() async{
                      await ProfileCubit.get(ctx).setComplaintsMsgCtrl();
                      showModalBottomSheet(
                          context: context,
                          builder: (_)=>
                              AddComplaintsBtmSheet(context)
                      );
                    },
                  ),
                ),
              ),

              Stack(
                children: [

                  Align(
                    alignment: Alignment.topCenter,
                    child: Transform.translate(
                        offset: Offset(0,5),
                        child: ContactUsList(context)),
                  ),

                  Card(
                    child: BlocConsumer<HomeCubit ,HomeStates>(
                      listener: (context ,state){},
                      builder:(context ,state)=> AppListTile(
                        margin: const EdgeInsets.all(0),
                        txt: getTranslated(context, 'Contact Us'),
                        onTap: (){
                          HomeCubit.of(context).setEndRotateAngleVal();
                        },
                        trailing: Icon(Icons.info_outline),
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(child: Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ecommerceBG.png')
                    )
                  ),
                ),
              ))

            ],
          ),
        ),
      ),
    );
  }
}
