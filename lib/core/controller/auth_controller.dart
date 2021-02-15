import 'package:flutterstarterkit/core/storage/storage_manager.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../model/user_model.dart';
import '../repository/auth_repository.dart';
import 'base_controller.dart';

class AuthController extends BaseController {
  static AuthController _instance = AuthController._init();
  static AuthController get instance => _instance;

  final repository = AuthRepository.instance;
  Rx<User> _authUser;
  String _email;
  String _name;
  RxBool _isLogin = false.obs;
  String _token;

  User get authUser => _authUser.value;
  bool get isLogin => _isLogin.value;
  String get email => _email;
  String get name => _name;
  String get token => _token;

  AuthController._init() {
    _token = StorageManager.instance.getData(key: "auth_token") ?? null;

    print("token");
    print(_token);

    if (_token != null) {
      _isLogin.value = true;
    } else {
      _isLogin.value = false;
      _token = null;
    }
  }

  Future<dynamic> login({String email, String password, bool rememberMe}) async {
    openLoading();
    _isLogin.value = false;

    if (!GetUtils.isEmail(email) || password == null || password.length < 6) return false;

    dynamic result = await repository.login(email: email, password: password, rememberMe: rememberMe);

    print("auth controller");
    print(result);

    closeLoading();
    if (result is Map) {
      print("is Map");
      print("auth_user");
      print(result["auth_user"].toString());
      print("auth_token");
      print(result["auth_token"]);

      _isLogin.value = true;
      _email = email;
      User user = User.fromJson(result['auth_user'] as Map);
      print("user üretildi");
      print(user.toJson());
      _authUser = user.obs;
      print("set authuser geldi");
      _token = result['auth_token'];

      print("true geldi");

      return true;
    }
    print("false geldi");

    return result;
  }

  bool loginWithGoogle() {
    return true;
  }

  bool loginWithFacebook() {
    return true;
  }

  bool resetPassword() {
    return true;
  }

  Future<void> logout() async {
    openLoading();
    await Future.delayed(Duration(seconds: 1));
    _authUser = null;
    _email = null;
    // _username = null;
    _token = null;
    // _refreshToken = null;
    _isLogin.value = false;
    await repository.logout();
    closeLoading();
  }

  bool register({String email, String password}) {
    return false;
  }

  bool isTokenExpired() {
    return JwtDecoder.isExpired(_token);
  }

  Map<dynamic, dynamic> decodeToken() {
    return JwtDecoder.decode(_token);
  }
}
