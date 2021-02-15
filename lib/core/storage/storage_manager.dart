import 'package:get_storage/get_storage.dart';

class StorageManager {
  GetStorage _storage = GetStorage();

  static StorageManager _instance;
  static StorageManager get instance {
    if (_instance == null) _instance = StorageManager._init();
    return _instance;
  }

  StorageManager._init();

  int getIntData({String key}) {
    if (this.hasData(key)) {
      return _storage.read(key);
    }
    return 0;
  }

  bool getBoolData({String key}) {
    if (this.hasData(key)) {
      return _storage.read(key);
    }
    return false;
  }

  dynamic getData({String key}) {
    if (this.hasData(key)) {
      return _storage.read(key);
    }
    return null;
  }

  dynamic getDataWithCheckTime({String key}) {
    if (this.hasData(key)) {
      Map<String, dynamic> data = _storage.read(key);
      String time = data['time'];
      if (this.checkTime(time: time)) {
        return data;
      }
    }
    return null;
  }

  Future<void> setData({String key, dynamic data}) async {
    await _storage.write(key, data);
  }

  Future<void> setDataWithTime({String key, dynamic data, int time = 24}) async {
    Map<String, dynamic> storageData = {
      "data": data,
      "time": DateTime.now().add(Duration(hours: time)).toString(),
    };
    await _storage.write(key, storageData);
  }

  bool hasData(String key) {
    return _storage.hasData(key);
  }

  Future<bool> deleteData({String key}) async {
    await _storage.remove(key);
    return true;
  }

  bool checkTime({String time}) {
    DateTime date = DateTime.tryParse(time);
    DateTime now = DateTime.now();
    bool diff = now.difference(date).isNegative;
    return diff;
  }
}
