import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterstarterkit/core/view/base_view.dart';
import 'package:flutterstarterkit/module/drawer/view/drawer_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(onPageBuilder: (context, controller, authController, mainController) {
      return Scaffold(
        appBar: AppBar(),
        drawer: DrawerMenu(),
        body: Center(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Home Page"),
              FlatButton(
                color: Colors.blue,
                onPressed: () async {
                  await authController.logout();
                  Get.offAndToNamed("/login");
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
        ),
      );
    });
  }
}
