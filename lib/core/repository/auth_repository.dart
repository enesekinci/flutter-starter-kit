import '../network/network_manager.dart';
import '../storage/storage_manager.dart';

class AuthRepository {
  final network = NetworkManager.instance;

  static AuthRepository _instance;
  static AuthRepository get instance {
    if (_instance == null) _instance = AuthRepository._init();
    return _instance;
  }

  AuthRepository._init();

  Future<dynamic> login({String email, String password, bool rememberMe}) async {
    dynamic response = await network.post(
      path: "/login",
      data: {"email": email, "password": password},
      // options: Options(headers: {
      // 'Authorization': 'Bearer ' + AuthController.instance.token,
      // })
    );

    print("auth repo");
    print(response);

    print(response is Map);

    if (response['status'] != false) {
      final result = response["result"];
      // User authUser = User.fromJson(result["auth_user"]);
      print("fromJson geçti");
      if (rememberMe) {
        print("auth repo token => " + result['auth_token']);
        StorageManager.instance.setData(key: "auth_token", data: result['auth_token']);
        StorageManager.instance.setData(key: "auth_user", data: result["auth_user"]);
      }

      print("repo returnden önce");
      print(result["auth_user"]);

      return {
        "auth_user": result["auth_user"],
        "auth_token": result['auth_token'],
        // "email": authUser.email,
        // "username": authUser.username ?? null,
      };
    }

    return response['message'];
  }

  Future<void> logout() async {
    await StorageManager.instance.deleteData(key: "auth_token");
    await StorageManager.instance.deleteData(key: "auth_user");
  }
}
