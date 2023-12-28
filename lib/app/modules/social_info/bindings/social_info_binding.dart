import 'package:get/get.dart';

import '../controllers/social_info_controller.dart';

class SocialInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocialInfoController>(
      () => SocialInfoController(),
    );
  }
}
