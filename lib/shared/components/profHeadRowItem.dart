import 'package:flutter/material.dart';

class ProfHeadRowItem extends StatelessWidget {
  final String txt;
  final String val;
  ProfHeadRowItem({
    @required this.txt,
    @required this.val,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(txt),
          LayoutBuilder(
            builder: (context ,constrainedBox)=> Container(
              height: 1.5,
              color: Colors.black26,
              width: constrainedBox.maxWidth*0.2,
              //margin: const EdgeInsets.symmetric(vertical: 2),
            ),
          ),
          Text(val),
        ],
      ),
    );
  }
}
