import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/common/common_widgets/cw.dart';
import '../controllers/add_document_controller.dart';

class AddDocumentView extends GetView<AddDocumentController> {
  const AddDocumentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: 'Document',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton()),
      body: const Center(
        child: Text(
          'Document',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
