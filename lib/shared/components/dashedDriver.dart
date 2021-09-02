import 'package:flutter/material.dart';

/// ****-note-****
/// all not from me, i'm get code of (the horizontal) from stackoverflow
/// i'm add vertical and option between them

/// usage
/// it must have known High and Width

/// use dashed border
// class DashedBorder extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: responsive.sWidth(context)*0.4,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           DashedDriver(axis: Axis.horizontal,),
//           Expanded(
//             child: Row(
//               //mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 DashedDriver(axis: Axis.vertical,),
//                 /// body
//                 DashedDriver(axis: Axis.vertical,),
//               ],),
//           ),
//           DashedDriver(axis: Axis.horizontal,),
//         ],
//       ),
//     );
//   }
// }



class DashedDriver extends StatelessWidget {

  Axis axis = Axis.vertical;
  DashedDriver({@required this.axis});

  double _dashWidth = 10.0;
  double _dashHeight = 1.0;
  int _dashCount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final boxHigh = constraints.constrainHeight();

        if(this.axis == Axis.vertical){
          _dashWidth = 1.0;
          _dashHeight = 10.0;
          _dashCount = (boxHigh / (2 * _dashHeight)).floor();
        }
        else
          _dashCount = (boxWidth / (2 * _dashWidth)).floor();

        return Flex(
          children: List.generate(_dashCount, (_) {
            return SizedBox(
              width: _dashWidth,
              height: _dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black12),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: axis,
        );
      },
    );
  }
}
