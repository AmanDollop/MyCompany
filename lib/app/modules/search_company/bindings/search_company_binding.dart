import 'package:get/get.dart';

import '../controllers/search_company_controller.dart';

class SearchCompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchCompanyController>(
      () => SearchCompanyController(),
    );
  }
}
