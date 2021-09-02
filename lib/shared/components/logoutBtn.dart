import '../../shared/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/loginCubit/loginCubit.dart';
import '../../cubit/loginCubit/loginStates.dart';
import 'appDialog.dart';
import 'appListTile.dart';
import 'loading/appProgress.dart';

class LogoutBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit ,LoginStates>(
      listener: (context ,state){},
      builder:(context ,state)=> AppListTile(
        txt: getTranslated(context ,'Logout'),
        trailing: Icon(Icons.login_outlined ,color: Colors.red,),
        onTap: () async{
          await showCupertinoDialog(context: context, builder: (ctx)=> AppDialog(
            screenCtx: context,
            content: (state is LogoutLoadingState)
              ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(getTranslated(context ,'Logout')+'...'),
                AppProgress()
              ],
            ) : getTranslated(context, 'Are you sure to logout your account'),
            doneActionTitle: getTranslated(context ,'Logout'),
            doneAction: ()async {
              await LoginCubit.get(context).logout(context);
            }

          ));




        },
      ),
    );
  }
}
