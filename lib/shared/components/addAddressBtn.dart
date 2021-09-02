import '../../shared/styles/responsive.dart';
import '../../shared/components/dashedDriver.dart';
import '../../shared/localization/language_constants.dart';
import 'package:flutter/material.dart';

class AddAddressBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: responsive.sWidth(context)*0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DashedDriver(axis: Axis.horizontal,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashedDriver(axis: Axis.vertical,),
                Text(getTranslated(context, 'Add an address')),
                Icon(Icons.add),
                DashedDriver(axis: Axis.vertical,),
            ],),
          ),
          DashedDriver(axis: Axis.horizontal,),
        ],
      ),
    );
  }
}
