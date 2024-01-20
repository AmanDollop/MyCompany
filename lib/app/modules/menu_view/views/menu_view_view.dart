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
    return GestureDetector(
      onTap: () {
        CM.unFocusKeyBoard();
      },
      child: WillPopScope(
        onWillPop: () => controller.willPop(),
        child: Scaffold(
          body: Obx(() {
            controller.count.value;
            return ModalProgress(
              inAsyncCall: controller.apiResValue.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Col.inverseSecondary,
                    padding: EdgeInsets.only(
                      top: 16.px,
                      right: 12.px,
                      left: 12.px,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleTextView(),
                        SizedBox(height: 10.px),
                        menusSearchTextFieldView(),
                      ],
                    ),
                  ),
                  Obx(
                    () => controller.menusModal.value != null
                        ? controller.getMenuList.isNotEmpty
                            ? Expanded(
                                child: controller
                                            .searchController.text.isNotEmpty &&
                                        controller.getMenuListForSearch.isEmpty
                                    ? CW.commonNoDataFoundText(
                                        text: 'Menus not found!')
                                    : menusGridView(),
                              )
                            : CW.commonNoDataFoundText(text: 'Menus not found!')
                        : CW.commonNoDataFoundText(
                            text: controller.apiResValue.value
                                ? ''
                                : 'Menus not found!'),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget titleTextView() => Text('What are you looking for?',
      style: Theme.of(Get.context!)
          .textTheme
          .displayLarge
          ?.copyWith(fontSize: 16.px));

  Widget menusSearchTextFieldView() => CW.commonTextField(
        isBorder: true,
        isSearchLabelText: true,
        hintText: 'Search Menus',
        controller: controller.searchController,
        onChanged: (value) => controller.searchOnChange(value: value),
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
        style: Theme.of(Get.context!)
            .textTheme
            .labelSmall
            ?.copyWith(fontWeight: FontWeight.w700, fontSize: 10.px),
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
          Color convertedColor = stringToColor(
              colorString: '${controller.getMenuList[index].backgroundColor}');
          return InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10.px),
            child: Ink(
              height: 100.px,
              padding: EdgeInsets.only(left: 3.px),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 24.px,
                    color: Col.secondary.withOpacity(.05),
                  )
                ],
                color: convertedColor,
                borderRadius: BorderRadius.circular(8.px),
              ),
              child: Ink(
                padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 8.px),
                decoration: BoxDecoration(
                  color: Col.inverseSecondary,
                  borderRadius: BorderRadius.circular(6.px),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40.px,
                      height: 40.px,
                      padding: EdgeInsets.all(2.px),
                      decoration: BoxDecoration(
                        color: convertedColor,
                        borderRadius: BorderRadius.circular(6.px),
                      ),
                      child: Center(
                        child: CW.commonNetworkImageView(
                          isAssetImage: false,
                          path: controller.searchController.text.isNotEmpty
                              ? '${AU.baseUrlForSearchCompanyImage}${controller.getMenuListForSearch[index].menuImage}'
                              : '${AU.baseUrlForSearchCompanyImage}${controller.getMenuList[index].menuImage}',
                          width: 22.px,
                          height: 22.px,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.px),
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
            ),
          );
        },
      );

  Color stringToColor({required String colorString}) {
    // Remove the '#' from the color code
    String formattedColor =
        colorString.startsWith('#') ? colorString.substring(1) : colorString;

    // Parse the hexadecimal value and create a Color object
    return Color(int.parse('0xFF$formattedColor'));
  }
}
