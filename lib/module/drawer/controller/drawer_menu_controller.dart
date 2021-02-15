import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controller/base_controller.dart';

class DrawerMenuController extends BaseController {
  static DrawerMenuController _instance = DrawerMenuController._init();
  static DrawerMenuController get instance => _instance;

  DrawerMenuController._init();

  RxBool openMenu = false.obs;
  Rx<Widget> openMenuIcon = Icon(Icons.arrow_right_outlined).obs;

  openingMenu() {
    openMenu.value = true;
    openMenuIcon.value = Icon(Icons.arrow_drop_down_rounded);
  }

  closingMenu() {
    openMenu.value = false;
    openMenuIcon.value = Icon(Icons.arrow_right_outlined);
  }
}
