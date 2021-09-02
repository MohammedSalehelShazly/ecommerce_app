import 'package:flutter/material.dart';

import '../../shared/components/appBadge.dart';
import '../../shared/styles/responsive.dart';
import '../../cubit/homeCubit/homeCubit.dart';
import '../../cubit/homeCubit/homeState.dart';
import '../../shared/components/staticVariables.dart';
import '../../shared/components/doubleTapToExit.dart';
import '../../shared/styles/colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatelessWidget {
  DoubleTapToUndo doubleTapToUndo = DoubleTapToUndo();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<HomeCubit ,HomeStates>(
        listener: (context ,state){},
        builder:(context ,state)=> WillPopScope(
          onWillPop:()async{
            if(HomeCubit.of(context).bottomNavIndex == 0)
              return doubleTapToUndo.action(context);
            else
              HomeCubit.of(context).setBottomNavIndex(0);
            return false;
          },
          child: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              height: responsive.responsiveHigh(context, 0.08),

              index: HomeCubit.of(context).bottomNavIndex,
              items: List<Widget>.generate(staticVars.screensList.keys.length, (index) =>
                HomeCubit.of(context).bottomNavIndex == staticVars.screensList.keys.toList().indexOf(staticVars.screensList.keys.toList()[index])
                    ? Icon(
                  staticVars.iconNotOutLined(staticVars.screensList.keys.toList()[index]),
                  size: responsive.responsiveHigh(context, 0.038),
                )
                    : AppBadge(child: Icon(
                  staticVars.screensList.keys.toList()[index],
                  size: responsive.responsiveHigh(context, 0.031),
                ))
              ),
              onTap: (int index) => HomeCubit.of(context).setBottomNavIndex(index),
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: appClrs.secondColor,
              color: appClrs.mainColor,
            ),

            body: staticVars.screensList.values.toList()[ HomeCubit.of(context).bottomNavIndex ],

          ),
        ),
      ),
    );
  }
}

