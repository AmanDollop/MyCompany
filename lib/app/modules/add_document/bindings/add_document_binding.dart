import 'package:get/get.dart';

import '../controllers/add_document_controller.dart';

class AddDocumentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDocumentController>(
      () => AddDocumentController(),
    );
  }
}
