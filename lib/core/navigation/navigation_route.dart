import 'package:get/get.dart';

import '../../module/login/view/login_page.dart';
import '../../module/main/view/main_page.dart';

class NavigationRoute {
  static NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  final List<GetPage> routes = [
    GetPage(name: "/", page: () => MainPage(), transition: Transition.cupertino),
    GetPage(name: "/login", page: () => LoginPage(), transition: Transition.cupertino),
  ];
}
