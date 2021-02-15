import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../controller/base_controller.dart';
import '../controller/main_controller.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  double dynamicHeight({double height}) => Get.height * height;
  double dynamicWidth({double width}) => Get.width * width;
  bool isPhone() => GetPlatform.isMobile;
  bool isVertical() => Get.context.isPortrait;
}

// ignore: must_be_immutable
class BaseView<T> extends StatefulWidget {
  final Widget Function(BuildContext context, T controller, AuthController authController, MainController mainController) onPageBuilder;
  final BaseController controller;
  final Function(T controller) onModelReady;
  final VoidCallback onDispose;

  BaseView({Key key, @required this.onPageBuilder, this.controller, this.onModelReady, this.onDispose}) : super(key: key);
  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends BaseState<BaseView> {
  @override
  void initState() {
    super.initState();
    if (widget.onModelReady != null) widget.onModelReady(widget.controller);
  }

  @override
  void dispose() {
    // widget.controller.dispose();
    if (widget.onDispose != null) widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (AuthController.instance.isLoading == true) {
        return Scaffold(
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: dynamicHeight(height: 0.1),
                    width: dynamicWidth(width: 0.2),
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "yükleniyor...",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent[400]),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return widget.onPageBuilder(context, widget.controller, AuthController.instance, MainController.instance);
    });
  }
}
