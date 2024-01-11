import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
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
          title: 'Search Company',
          isLeading: false,
          titleSpacing: 12.px,
          onBackPressed: () {},
        ),
        body: Obx(() {
          controller.count.value;
          return Padding(
            padding: EdgeInsets.all(12.px),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                searchTextField(),
                controller.searchController.text.isEmpty
                    ? commonSearchImageView()
                    : controller.apiResponseValue.value
                        ? CW.commonProgressBarView(color: Col.primary)
                        : controller.searchCompanyList != null && controller.searchCompanyList!.isNotEmpty
                            ? Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(vertical: 20.px),
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.searchCompanyList?.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () => controller.clickOnCompany(index: index),
                                        borderRadius: BorderRadius.circular(6.px),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: listTileLeadingLogoView(index: index),
                                          title: listTileTitleTextView(index: index),
                                          subtitle: listTileSubTitleTextView(index: index),
                                        ),
                                      ),
                                      CW.commonDividerView()
                                    ],
                                  );
                                },
                              ),
                            )
                            : controller.searchController.text.length >= 3? CW.commonNoDataFoundText() : commonSearchImageView(),
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
        isSearchLabelText: true,
        hintText: 'Search your Company',
        prefixIcon: commonIconImage(imagePath: 'assets/icons/search_icon.png'),
        suffixIcon: commonIconImage(imagePath: 'assets/icons/audio_icon.png'),
        onChanged: (value) => controller.searchOnChanged(value: value),
      );

  Widget commonSearchImageView() => Center(
        child: CW.commonNetworkImageView(
            path: 'assets/images/search_your_company.png',
            isAssetImage: true,
            width: 184.px,
            height: 184.px),
      );

  Widget commonIconImage({required String imagePath, bool? isAssetImage, double? width, double? height}) =>
      SizedBox(
        width: width ?? 24.px,
        height: height ?? 24.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: imagePath,
              isAssetImage: isAssetImage ?? true,
              width: width ?? 24.px,
              height: height ?? 24.px),
        ),
      );

  Widget listTileLeadingLogoView({required int index}) => Container(
        height: 50.px,
        width: 50.px,
        decoration: BoxDecoration(
          color: Col.gray.withOpacity(.6),
          borderRadius: BorderRadius.circular(8.px),
        ),
        child: commonIconImage(
            imagePath: '${AU.baseUrlForSearchCompanyImage}${controller.searchCompanyList?[index].companyLogo}',
            isAssetImage: false,
            height: 44.px,
            width: 44.px),
      );

  Widget listTileTitleTextView({required int index}) => Text(
        controller.searchCompanyList?[index].companyName != null &&
                controller.searchCompanyList![index].companyName!.isNotEmpty
            ? '${controller.searchCompanyList?[index].companyName}'
            : 'Company Name Not Found!',
        style: Theme.of(Get.context!).textTheme.titleLarge,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget listTileSubTitleTextView({required int index}) => Text(
        controller.searchCompanyList?[index].companyAddress != null &&
                controller.searchCompanyList![index].companyAddress!.isNotEmpty
            ? '${controller.searchCompanyList?[index].companyAddress}'
            : 'Company Address Not Found!',
        style: Theme.of(Get.context!).textTheme.labelMedium,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

}
