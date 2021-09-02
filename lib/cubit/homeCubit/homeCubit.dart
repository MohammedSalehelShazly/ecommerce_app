import 'package:flutter/material.dart';

import '../../cubit/homeCubit/homeState.dart';
import '../../models/homeModels/homeProdsModel.dart';
import '../../shared/localization/language_constants.dart';
import '../../shared/network/remote/home.dart';
import '../../main.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates>{

  HomeCubit() :super (HomeInitStates());
  static HomeCubit of(context)=> BlocProvider.of(context);

  int bottomNavIndex = 0;
  setBottomNavIndex(int _index){
    bottomNavIndex = _index;
    emit(HomeStatesSetBtmNavBar());
  }

  // localization..
  String appLang = 'ar';
  Future<void> setLang(BuildContext context ,String languageCode) async {
    Locale _locale = await setLocale(languageCode);
    MyApp.setLocale(context, _locale);
    getLang();
  }
  Future<void> getLang() async{
    await getLocale().then((value) {
      appLang = value.languageCode;
      emit(HomeStatesSetAppLanguage());
    });
  }


  ScrollController homeScrollController = ScrollController();


  HomeHelper _homeHelper = HomeHelper();

  HomeProdsModel homeProdsModel;
  getHomeData(BuildContext context) async{
    try{
      emit(GetHomeDataLoadingState());
      homeProdsModel = await _homeHelper.getHomeProds(context);

    }on Exception catch(e){
      print(e);
    }finally{
      emit(GetHomeDataState());
    }
  }



  double rotateAngle = 90;
  double rotateEndAngle = 90;
  setEndRotateAngleVal(){
    if(rotateAngle == 90 && rotateEndAngle == 90)
      rotateAngle = 0;

    if(rotateAngle>0){
      rotateAngle = 0;
      rotateEndAngle =90;
    }
    else if(rotateAngle<90){
      rotateAngle = 90;
      rotateEndAngle = 0;
    }
    else{
      rotateAngle = 0;
      rotateEndAngle =90;
    }
    emit(SetEndRotateAngleValState());
  }






























}