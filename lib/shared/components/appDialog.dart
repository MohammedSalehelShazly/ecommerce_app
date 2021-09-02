import '../../shared/localization/language_constants.dart';

import '../../shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {

  BuildContext screenCtx;
  dynamic content;
  String doneActionTitle;
  Function doneAction;
  bool appearCancelBtn;
  CupertinoButton customBtn;

  AppDialog({
    @required this.screenCtx,
    @required this.content,
    @required this.doneActionTitle,
    @required this.doneAction,
    this.appearCancelBtn = true,
    this.customBtn
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: content.runtimeType==String
          ? Text(content,style: TextStyle(fontFamily: appClrs.mainFontFamily),) :content,
      actions: [
        if(customBtn !=null)
          customBtn,

        if(appearCancelBtn)
          CupertinoButton(
            child: Text(getTranslated(context, 'Cancel') ,style: TextStyle(fontFamily: appClrs.mainFontFamily),),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        CupertinoButton(
            child: Text(doneActionTitle ,style: TextStyle(color: appearCancelBtn ? Colors.red :appClrs.mainColor ,fontFamily: appClrs.mainFontFamily),),
            onPressed: doneAction
        ),
      ],
    );
  }
}
