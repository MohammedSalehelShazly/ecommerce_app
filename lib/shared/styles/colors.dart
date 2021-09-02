import 'package:flutter/material.dart';


AppClrs appClrs = AppClrs();

class AppClrs{

  Color mainColor = Color(0xff01C38E);
  List<Color> gradientColors = [
    Color(0xff01C38E),
    Color(0xff00C389),
    Color(0xff00FA9A),
    Color(0xffACFFAD),
  ];
  Color secondColor = Colors.yellow[700];
  Color scaffoldBackgroundColorDark = Color(0xff585858);


  String mainFontFamily = 'Cairo';
  String secondFontFamily = 'Amiri';

  ThemeData appThem()=> ThemeData(
    brightness: Brightness.light,
    fontFamily: mainFontFamily,
    primaryColor: mainColor,

    appBarTheme: AppBarTheme(
      color: mainColor,
      textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold ,fontFamily: mainFontFamily)
      ),
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(color: mainColor ),
    ),
  );


}