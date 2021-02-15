import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controller/main_controller.dart';
import '../../../core/view/base_view.dart';
import '../controller/drawer_menu_controller.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  DrawerMenuController drawerMenuController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      controller: DrawerMenuController.instance,
      onModelReady: (controller) => drawerMenuController = controller,
      onPageBuilder: (context, controller, authController, mainController) {
        return Drawer(
          elevation: 0.5,
          child: ListView(
            children: [
              buildDrawerHeader(mainController),
              buildDrawerMenuItems(),
            ],
          ),
        );
      },
    );
  }

  Widget buildDrawerMenuItems() {
    return Column(
      children: [
        ListTile(
          focusColor: Colors.grey,
          title: Text('Home Page'),
          leading: Icon(Icons.home),
          onTap: () => Get.offAllNamed('/'),
          trailing: Icon(Icons.arrow_right_outlined),
        ),
      ],
    );
  }

  DrawerHeader buildDrawerHeader(MainController mainController) {
    return DrawerHeader(
        padding: EdgeInsets.zero,
        child: Container(
          color: mainController.getThemePrimaryColor(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 10,
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      child: Icon(
                        Icons.person,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Text(
                      'Username',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.login_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () => print("logout"),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
