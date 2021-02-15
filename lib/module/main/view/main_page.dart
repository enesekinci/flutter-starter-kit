import 'package:flutter/widgets.dart';
import 'package:flutterstarterkit/core/controller/auth_controller.dart';
import 'package:flutterstarterkit/module/home/view/home_page.dart';
import 'package:flutterstarterkit/module/login/view/login_page.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AuthController.instance.isLogin == true ? HomePage() : LoginPage();
    });
  }
}
