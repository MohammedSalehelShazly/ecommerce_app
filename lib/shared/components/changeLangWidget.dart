import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';
import '../../cubit/categories/categoriesCubit.dart';
import '../../cubit/categories/categoriesStates.dart';
import '../../cubit/homeCubit/homeCubit.dart';
import '../../cubit/homeCubit/homeState.dart';
import '../../shared/components/appDialog.dart';
import '../../shared/localization/languageClass.dart';
import '../../shared/components/restartWidget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class ChangeLangWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit ,HomeStates>(
      listener: (context ,homeState){},
      builder:(context ,homeState)=> BlocConsumer<CategoriesCubit ,CategoriesStates>(
        listener: (context ,categoriesState){},
        builder:(context ,categoriesState)=> AppDialog(
          doneAction: ()=> Navigator.pop(context),
          screenCtx: context,
          doneActionTitle: 'Ok / تم',
          appearCancelBtn: false,
          content: Column(children:
          Language.languageList().map((e) =>
              Material(
                color: Colors.transparent,
                child: ListTile(
                  title: Text( e.name ,style: TextStyle(fontFamily: appClrs.mainFontFamily),),
                  trailing: Text( e.flag ),
                  onTap: () async{
                    await HomeCubit.of(context).setLang(context ,e.languageCode);
                    Navigator.pop(context);
                    RestartWidget.restartApp(context);
                    // CategoriesCubit.of(context).oneCategoryClearModel();
                    // CategoriesCubit.of(context).clearCategoriesModel();
                  },
                ),
              )
          ).toList()
          ),
        ),
      ),
    );
  }
}


