import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_frontend_mybarber/const/colors.const.dart';

class CustomNavigationBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final String heroTag;
  const CustomNavigationBar({
    Key key,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      previousPageTitle: '',
      transitionBetweenRoutes: false,
      heroTag: heroTag,
      actionsForegroundColor: Colors.white,
      border: null,
      backgroundColor: ColorApp.primaryColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(0);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
