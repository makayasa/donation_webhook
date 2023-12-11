// import 'package:get_server/get_server.dart';

import 'package:get/get.dart';

import '../controllers/abc_controller.dart';

class AbcBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbcController>(
      () => AbcController(),
    );
  }
}
