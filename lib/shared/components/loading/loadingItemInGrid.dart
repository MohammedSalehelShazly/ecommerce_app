import 'package:flutter/material.dart';

import '../../styles/responsive.dart';
import 'loadingCntrItem.dart';

class LoadingItemInGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LoadingCntrItem(),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 5,),
              Container(width: responsive.responsiveWidth(context, 0.3), height: 8.0, color: Colors.white,),
              const SizedBox(height: 5,),
              Container(width: responsive.responsiveWidth(context, 0.3), height: 8.0, color: Colors.white,),
              const SizedBox(height: 5,),
              Container(width: responsive.responsiveWidth(context, 0.3), height: 8.0, color: Colors.white,),
              const SizedBox(height: 5,),
              Container(width: responsive.responsiveWidth(context, 0.3), height: 8.0, color: Colors.white,),
              const SizedBox(height: 5,),
              Container(width: 30.0, height: 8.0, color: Colors.white,),
            ],
          ),
        )
      ],
    );
  }
}
