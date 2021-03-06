import 'dart:io';
import '../../shared/localization/language_constants.dart';
import 'package:flutter/material.dart';

// notice..
/// if create more than constructor its not work ,because the list (_tapCont) initialized every time you create constructor
/// so, im not pass (context) to constructor
// usage
/// DoubleTapToUndo doubleTapToUndo = DoubleTapToUndo();
/// onWillPop:()async()=> doubleTapToUndo.action(context);


class DoubleTapToUndo {

  _showSnackBar(BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(getTranslated(context, 'double tab to exit') ,style: TextStyle(color: Colors.white),),
      backgroundColor: Color(0xff303030),
      duration: Duration(seconds: 2),
    ));
  }

  List<int> _tapCont =[]; // [ 1 ,1 ] => exit

  action(BuildContext context){
    _tapCont.add(1);

    if(_tapCont.length==1) {
      _showSnackBar(context);
      Future.delayed(Duration(seconds: 2), () {
        _tapCont = [];
      });
    }
    else if(_tapCont.length == 2){
      exit(0);
    }
    print(_tapCont);
  }
}