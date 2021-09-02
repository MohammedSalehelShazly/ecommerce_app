
import 'modules/home/homePage.dart';

import 'modules/introScreen/introScreen.dart';

import 'cubit/loginCubit/loginCubit.dart';
import 'cubit/loginCubit/loginStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit ,LoginStates>(
      listener: (context ,state){},
      builder:(context ,state)=> LoginCubit.get(context).token=='' ? IntroScreen() :  HomePage()  //ProfileScreen(LoginCubit.get(context).token)
    );
  }
}
