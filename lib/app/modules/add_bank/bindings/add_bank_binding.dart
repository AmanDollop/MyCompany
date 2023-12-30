import 'package:get/get.dart';

import '../controllers/add_bank_controller.dart';

class AddBankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBankController>(
      () => AddBankController(),
    );
  }
}
