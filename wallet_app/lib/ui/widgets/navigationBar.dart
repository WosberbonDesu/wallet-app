import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';


Widget bottomBarHomePage(List<IconData> icons,Color colorActive,Color colorInactive,int _currentIndex,
    Function func,){




  return AnimatedBottomNavigationBar(
      icons: icons,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      activeColor: colorActive,
      inactiveColor: colorInactive,
      activeIndex: _currentIndex,
      onTap: (i) => func);
}



