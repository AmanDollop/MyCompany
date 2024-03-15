import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/menu_view_controller.dart';

class MenuViewView extends GetView<MenuViewController> {
  const MenuViewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: WillPopScope(
        onWillPop: () => controller.willPop(),
        child: GestureDetector(
          onTap: () => CM.unFocusKeyBoard(),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Obx(() {
                controller.count.value;
                return ModalProgress(
                  inAsyncCall: controller.apiResValue.value,
                  child: controller.apiResValue.value
                      ? menusListViewForShimmer()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedCrossFade(
                              firstChild: Padding(
                                padding: EdgeInsets.only(top: 16.px, right: 12.px, left: 12.px),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    titleTextView(),
                                    SizedBox(height: 10.px),
                                    menusSearchTextFieldView(),
                                  ],
                                ),
                              ),
                              secondChild: const SizedBox(),
                              crossFadeState: controller.hideSearchFieldValue.value
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 500),
                            ),
                            Obx(
                              () => controller.menusModal.value != null
                                  ? controller.getMenuList.isNotEmpty
                                      ? Expanded(
                                          child: controller.searchController.text.isNotEmpty && controller.getMenuListForSearch.isEmpty
                                              ? CW.commonNoDataFoundText(text: 'Menus not found!')
                                              : menusGridView(),
                                        )
                                      : CW.commonNoDataFoundText(text: 'Menus not found!',
                              ) : CW.commonNoDataFoundText(text: controller.apiResValue.value ? '' : 'Menus not found!'),
                            ),
                          ],
                        ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget titleTextView() => Text('What are you looking for?', style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(fontSize: 16.px,color: Col.inverseSecondary));

  Widget menusSearchTextFieldView() => CW.commonTextField(
        isBorder: true,
        isSearchLabelText: true,
        hintText: 'Search Menus',
        controller: controller.searchController,
        onChanged: (value) => controller.searchOnChange(value: value),
        suffixIcon: controller.searchController.text.isNotEmpty
            ? SizedBox(
                width: 24.px,
                height: 24.px,
                child: InkWell(
                  onTap: () {
                    controller.searchController.clear();
                    controller.count.value = 0;
                  },
                  child: Center(
                    child: CW.commonNetworkImageView(
                        path: 'assets/icons/cancel_white_icon.png',
                        color: Col.text,
                        isAssetImage: true,
                        width: 12.px,
                        height: 12.px),
                  ),
                ),
              )
            : const SizedBox(),
        prefixIcon: SizedBox(
          width: 24.px,
          height: 24.px,
          child: Center(
            child: CW.commonNetworkImageView(
                path: 'assets/icons/search_icon.png',
                isAssetImage: true,
                width: 24.px,
                height: 24.px),
          ),
        ),
      );

  Widget cardTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget menusGridView() => GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(10.px),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.searchController.text.isNotEmpty
            ? controller.getMenuListForSearch.length
            : controller.getMenuList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.px,
          mainAxisSpacing: 10.px,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => controller.clickOnCard(index: index),
            borderRadius: BorderRadius.circular(10.px),
            child: Ink(
              padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 8.px),
              decoration: BoxDecoration(
                color: Col.gCardColor,
                borderRadius: BorderRadius.circular(6.px),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 26.px,
                      height: 26.px,
                      child: CW.commonCachedNetworkImageView(
                        imageColor: Col.primary,
                        path: controller.searchController.text.isNotEmpty
                            ? '${AU.baseUrlForSearchCompanyImage}${controller.getMenuListForSearch[index].menuImage}'
                            : '${AU.baseUrlForSearchCompanyImage}${controller.getMenuList[index].menuImage}',
                      ),
                    ),
                  ),
                  SizedBox(height: 6.px),
                  Flexible(
                    child: cardTextView(
                      text: controller.searchController.text.isNotEmpty
                          ? '${controller.getMenuListForSearch[index].menuName}'
                          : '${controller.getMenuList[index].menuName}',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  Widget menusListViewForShimmer() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16.px, right: 12.px, left: 12.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CW.commonShimmerViewForImage(height: 24.px),
              SizedBox(height: 10.px),
              CW.commonShimmerViewForImage(height: 44.px),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.px),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 16,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.px,
              mainAxisSpacing: 10.px,
            ),
            itemBuilder: (context, index) {
              return Container(
                  height: 100.px,
                  padding: EdgeInsets.symmetric(horizontal: 8.px),
                  decoration: BoxDecoration(
                      color: Col.gCardColor,
                      borderRadius: BorderRadius.circular(6.px),
                      boxShadow: [
                      BoxShadow(
                        blurRadius: 24.px,
                        color: Col.secondary.withOpacity(.05),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CW.commonShimmerViewForImage(height: 36.px,width: 36.px),
                      SizedBox(height: 6.px),
                      CW.commonShimmerViewForImage(height: 10.px,width: 80.px,radius: 2.px),
                    ],
                  )
              );
            },
          ),
        ),
      ],
    );
  }

}
