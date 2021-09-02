import 'package:flutter/material.dart';

import '../../styles/responsive.dart';
import 'appProgress.dart';

class AppProgressPage extends StatelessWidget {


  bool conditional;
  Widget child;
  AppProgressPage({
    @required this.conditional,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return
      !conditional ?  child
          :
      Stack(children: [

        child,

        Center(
          child: Container(
            height: responsive.responsiveHigh(context, 1),
            width: responsive.responsiveWidth(context, 1),
            color: Colors.black.withOpacity(0.5),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: responsive.responsiveWidth(context, 0.25),
                  width: responsive.responsiveWidth(context, 0.25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[500]
                  ),
                  child: AppProgress(),
                ),
              ],
            ),
          ),
        ),

    ],);
  }
}
