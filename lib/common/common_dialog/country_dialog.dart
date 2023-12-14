import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_model/country_model.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';

import '../../app/modules/home/controllers/home_controller.dart';

// ignore: must_be_immutable
/*class CountryDialog extends GetView<HomeController> {
  Function(Country)? getSelectedCountry;
  CountryDialog({super.key, this.getSelectedCountry});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: !controller.isEmpty.value
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: controller.searchController.text.trim().isNotEmpty
                    ? controller.searchCountryList.length
                    : controller.countryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      getSelectedCountry?.call(
                          controller.searchController.text.trim().isNotEmpty
                              ? controller.searchCountryList[index]
                              : controller.countryList[index]);
                      controller.searchController.text = "";
                      Get.back();
                    },
                    borderRadius: BorderRadius.circular(2.px),
                    child: Column(
                      children: [
                        SizedBox(height: 5.px),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.px),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5.px),
                                child: CW.commonNetworkImageView(
                                    height: 20.px,
                                    width: 30.px,
                                    path:
                                        "${UC.baseUrl}${controller.searchController.text.trim().isNotEmpty ? controller.searchCountryList[index].flag : controller.countryList[index].flag}",
                                    isAssetImage: false),
                              ),
                              SizedBox(width: 6.px),
                              Text(
                                controller.searchController.text
                                        .trim()
                                        .isNotEmpty
                                    ? controller.searchCountryList[index]
                                            .countryCode ??
                                        ""
                                    : controller
                                            .countryList[index].countryCode ??
                                        "",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              SizedBox(width: 10.px),
                              Flexible(
                                child: Text(
                                  controller.searchController.text
                                          .trim()
                                          .isNotEmpty
                                      ? controller.searchCountryList[index]
                                              .countryName ??
                                          ""
                                      : controller
                                              .countryList[index].countryName ??
                                          "",
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!(index ==
                            (controller.searchController.text.trim().isNotEmpty
                                ? controller.searchCountryList.length - 1
                                : controller.countryList.length - 1)))
                          SizedBox(
                            width: double.infinity,
                            child: CW.commonDividerView(
                                height: 0.px,
                                color: Col.secondary,
                                rightPadding: 0.px,
                                leftPadding: 0.px,
                                wight: .5.px),
                          ),
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Text(C.textNoResultFound,
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
      );
    });
  }
}*/
