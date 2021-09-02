import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {

  String txt;
  Function onTap;
  Widget trailing;
  Widget leading;
  EdgeInsetsGeometry margin;

  AppListTile({
    @required this.txt,
    @required this.trailing,
    @required this.onTap,
    this.leading,
    this.margin = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ,
      child: ListTile(
        title: Text(txt),
        trailing: trailing,
        onTap: onTap,
        leading: leading,
      ),
    );
  }
}
