import 'package:get/get.dart';

import '../storage/storage_manager.dart';


abstract class BaseController extends GetxController {
  StorageManager box = StorageManager.instance;

  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void openLoading() {
    print("openLoading");
    _isLoading.refresh();
    _isLoading.value = true;
  }

  void closeLoading() {
    print("closeLoading");
    _isLoading.refresh();
    _isLoading.value = false;
  }
}
