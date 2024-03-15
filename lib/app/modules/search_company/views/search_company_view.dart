import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/gradient_image_convert.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/search_company_controller.dart';

class SearchCompanyView extends GetView<SearchCompanyController> {
  const SearchCompanyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: GestureDetector(
        onTap: () {
          CM.unFocusKeyBoard();
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Obx(() {
              controller.count.value;
              return Padding(
                padding: EdgeInsets.all(12.px),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search Company',
                      style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 16.px),
                    ),
                    SizedBox(height: 16.px),
                    searchTextField(),
                    controller.searchController.text.isEmpty
                        ? Expanded(child: commonSearchImageView())
                        : controller.apiResponseValue.value
                            ? Expanded(child: Center(child: CW.commonProgressBarView(color: Col.primary),),)
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
                                : controller.searchController.text.length >= 3
                                ? Expanded(child: CW.commonNoDataFoundText())
                                : Expanded(child: commonSearchImageView()),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget searchTextField() => CW.commonTextField(
        fillColor: Col.primary.withOpacity(.2),
        controller: controller.searchController,
        focusNode: controller.focusNodeForSearch,
        isSearchLabelText: true,
        hintText: 'Search your Company',
        prefixIconPath: 'assets/icons/search_icon.png',
        // suffixIcon: commonIconImage(imagePath: 'assets/icons/audio_icon.png',color: Col.inverseSecondary),
        onChanged: (value) => controller.searchOnChanged(value: value),
      );

  Widget commonSearchImageView() => Center(
        child: CW.commonNetworkImageView(
            path: 'assets/images/search_your_company.png',
            isAssetImage: true,
            width: 184.px,
            height: 184.px),
      );

  Widget commonIconImage({required String imagePath, bool? isAssetImage, double? width, double? height,Color? color}) =>
      SizedBox(
        width: width ?? 24.px,
        height: height ?? 24.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: imagePath,
              isAssetImage: isAssetImage ?? true,
              width: width ?? 24.px,
              errorImage: 'assets/images/logo.png',
              height: height ?? 24.px,color: color),
        ),
      );

  Widget listTileLeadingLogoView({required int index}) => Container(
        height: 50.px,
        width: 50.px,
        decoration: BoxDecoration(
          color: Col.primary,
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
        style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Col.inverseSecondary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget listTileSubTitleTextView({required int index}) => Text(
        controller.searchCompanyList?[index].companyAddress != null &&
                controller.searchCompanyList![index].companyAddress!.isNotEmpty
            ? '${controller.searchCompanyList?[index].companyAddress}'
            : 'Company Address Not Found!',
        style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(color: Col.gray),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

}