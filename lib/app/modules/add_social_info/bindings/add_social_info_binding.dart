import 'package:get/get.dart';

import '../controllers/add_social_info_controller.dart';

class AddSocialInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSocialInfoController>(
      () => AddSocialInfoController(),
    );
  }
}
