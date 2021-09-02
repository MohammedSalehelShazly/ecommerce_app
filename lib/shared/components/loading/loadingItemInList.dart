import 'package:flutter/material.dart';

import 'loadingCntrItem.dart';

class LoadingItemInList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(width: double.infinity, height: 8.0, color: Colors.white,),
              const SizedBox(height: 5,),
              Container(width: double.infinity, height: 8.0, color: Colors.white,),
              const SizedBox(height: 5,),
              Container(width: double.infinity, height: 8.0, color: Colors.white,),
              const SizedBox(height: 5,),
              Container(width: double.infinity, height: 8.0, color: Colors.white,),
              const SizedBox(height: 5,),
              Container(width: 40.0, height: 8.0, color: Colors.white,),
            ],
          ),
        ),
        const SizedBox(width: 10,),
        LoadingCntrItem(),
      ],
    );
  }
}
