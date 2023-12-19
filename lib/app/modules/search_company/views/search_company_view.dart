import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/search_company_controller.dart';

class SearchCompanyView extends GetView<SearchCompanyController> {
  const SearchCompanyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CM.unFocusKeyBoard();
      },
      child: Scaffold(
        appBar: CW.commonAppBarView(
          title: '',
          isLeading: true,
          onBackPressed: () {},
        ),
        body: Obx(() {
          controller.count.value;
          return Padding(
            padding: EdgeInsets.all(12.px),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                searchTextField(),
                controller.searchController.text.isEmpty
                    ? Center(
                      child: CW.commonNetworkImageView(
                      path: 'assets/images/search_your_company.png',
                      isAssetImage: true,
                      width: 184.px,
                      height: 184.px),
                    )
                    : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 20.px),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () =>controller.clickOnCompany(index:index),
                            borderRadius: BorderRadius.circular(6.px),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: listTileLeadingLogoView(),
                              title:  listTileTitleTextView(index:index),
                              subtitle: listTileSubTitleTextView(index:index),
                            ),
                          ),
                          CW.commonDividerView()
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox()
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget searchTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.searchController,
        labelText: 'Search your Company',
        hintText: 'Search your Company',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/search_icon.png'),
        suffixIcon: commonIconImage(imagePath: 'assets/icons/audio_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget commonIconImage({required String imagePath}) => SizedBox(
        width: 24.px,
        height: 24.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: imagePath, isAssetImage: true, width: 24.px, height: 24.px),
        ),
      );

  Widget listTileLeadingLogoView() => Container(
        height: 50.px,
        width: 50.px,
        decoration: BoxDecoration(
          color: Col.primary,
          borderRadius: BorderRadius.circular(8.px),
        ),
        child: commonIconImage(imagePath: 'assets/images/logo.png'),
      );

  Widget listTileTitleTextView({required int index}) => Text(
        'Company Name',
        style: Theme.of(Get.context!).textTheme.titleLarge,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget listTileSubTitleTextView({required int index}) => Text(
        '1st Floor, Parshwa Towar, Above Kotak Mahendra Bank, Sural (Gujrat, India)',
        style: Theme.of(Get.context!).textTheme.labelMedium,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
}
