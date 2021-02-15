import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterstarterkit/core/view/base_view.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(onPageBuilder: (context, controller, authController, mainController) {
      return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(),
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
                  "Çıkış Yap",
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
