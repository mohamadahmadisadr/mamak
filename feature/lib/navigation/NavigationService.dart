import 'package:get/get.dart';

class NavigationServiceImpl implements NavigationServiceRepository {
  @override
  Future<dynamic>? navigateTo<T>(String routeName, [T? result]) {
    return Get.toNamed(routeName, arguments: result);
  }

  @override
  pop<T>([T? result]) {
    Get.back(result: result);
  }


  @override
  Future? replaceTo<T>(String routeName, [T? result]) {
    return Get.offNamed(routeName, arguments: result);
  }

  @override
  Future? off<T>(String routeName, [T? result]) {
    return Get.offAllNamed(routeName, arguments: result);
  }
}

abstract class NavigationServiceRepository {
  Future<dynamic>? navigateTo<T>(String routeName, [T? result]);

  Future<dynamic>? replaceTo<T>(String routeName, [T? result]);

  Future<dynamic>? off<T>(String routeName, [T? result]);

  void pop<T>([T? result]);
}
