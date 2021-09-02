import 'package:flutter/material.dart';

import '../../modules/cart/cartScreen.dart';
import '../../modules/favorites/favoritesScreen.dart';
import '../../modules/home/homeScreen.dart';
import '../../modules/notifications/notificationsScreen.dart';
import '../../modules/settings/settingsScreen.dart';

import 'package:toast/toast.dart';

StaticVars staticVars = StaticVars();

class StaticVars{

  void showToast(BuildContext context ,String txt ,[bool isException = false]){
    if(txt!=null || '$txt'.trim()!='')
      Toast.show(
          isException && txt.length >50
              ? txt.substring(0,49)+'...'
              :txt,
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
  }

  final BorderRadius borderRadius = BorderRadius.circular(8);

  final Map<IconData ,dynamic> screensList = {
    Icons.home_outlined : HomeScreen(),
    Icons.favorite_outline : FavoritesScreen(),
    Icons.shopping_cart_outlined : CartScreen(),
    Icons.settings_outlined : SettingsScreen(),
  };

  IconData iconNotOutLined(IconData _icon){
    if(_icon == Icons.shopping_cart_outlined)
      return Icons.shopping_cart;
    else if(_icon == Icons.favorite_outline)
      return Icons.favorite;
    else if(_icon == Icons.home_outlined)
      return Icons.home;
    else if(_icon == Icons.settings_outlined)
      return Icons.settings;
    else return Icons.error;
  }







}