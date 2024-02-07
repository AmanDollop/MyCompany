import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

class SubTaskShimmerView {
  static Widget shimmerView({required bool apiResValue,required bool apiResValueForSubTaskFilter, required bool apiResValueForSubTask}) => ListView(
    shrinkWrap: true,
    physics: const ScrollPhysics(),
    children: [
      if(apiResValueForSubTaskFilter || apiResValue)
      Card(
        color: Col.inverseSecondary,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px)),
        child: Padding(
          padding: EdgeInsets.all(4.px),
          child: GridView.builder(
            padding: EdgeInsets.all(6.px),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            shrinkWrap: true,
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 3,crossAxisSpacing: 10.px,mainAxisSpacing: 10.px),
            itemBuilder: (context, index) => CW.commonShimmerViewForImage(),
          ),
        ),
      ),
      if(apiResValueForSubTaskFilter || apiResValue)
      SizedBox(height: 16.px),
      if(apiResValueForSubTask || apiResValue)
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          color: Col.inverseSecondary,
          margin: EdgeInsets.only(bottom: 10.px, left: 0.px, right: 0.px, top: 0.px),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px)),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 44.px,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Col.primary.withOpacity(.1),
                  border: Border.all(color: Col.primary, width: 1.px),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6.px),
                    topLeft: Radius.circular(6.px),
                  ),
                ),
                padding: EdgeInsets.only(left: 10.px),
                child: Row(
                  children: [
                    CW.commonShimmerViewForImage(height: 25.px,width: 200.px),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CW.commonShimmerViewForImage(height: 50.px,width: 50.px,radius: 25.px),
                    SizedBox(width: 10.px),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CW.commonShimmerViewForImage(height: 15.px,width: 80.px),
                              CW.commonShimmerViewForImage(height: 15.px,width: 150.px),
                            ],
                          ),
                          SizedBox(height: 5.px),
                          CW.commonShimmerViewForImage(height: 18.px,width: 250.px),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              CW.commonDividerView(height: 0.px, color: Col.gray.withOpacity(.5)),
              Padding(
                padding: EdgeInsets.all(10.px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CW.commonShimmerViewForImage(height: 15.px,width: 80.px),
                              SizedBox(height: 5.px),
                              CW.commonShimmerViewForImage(height: 20.px,width: 250.px),
                            ],
                          ),
                          SizedBox(height: 10.px),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CW.commonShimmerViewForImage(height: 15.px,width: 80.px),
                              SizedBox(height: 5.px),
                              CW.commonShimmerViewForImage(height: 20.px,width: 250.px),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CW.commonShimmerViewForImage(height: 40.px,width: 40.px,radius: 20.px)
                  ],
                ),
              ),
              CW.commonDividerView(height: 0.px, color: Col.gray.withOpacity(.5)),
              Padding(
                padding: EdgeInsets.all(10.px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CW.commonShimmerViewForImage(height: 15.px,width: 100.px),
                              SizedBox(height: 5.px),
                              Row(
                                children: [
                                  CW.commonShimmerViewForImage(height: 10.px,width: 10.px,radius: 5.px),
                                  SizedBox(width: 4.px),
                                  CW.commonShimmerViewForImage(height: 10.px,width: 60.px,radius: 4.px),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 10.px),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CW.commonShimmerViewForImage(height: 15.px,width: 100.px),
                              SizedBox(height: 5.px),
                              Row(
                                children: [
                                  CW.commonShimmerViewForImage(height: 10.px,width: 10.px,radius: 5.px),
                                  SizedBox(width: 4.px),
                                  CW.commonShimmerViewForImage(height: 10.px,width: 60.px,radius: 4.px),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CW.commonShimmerViewForImage(height: 15.px,width: 60.px),
                        SizedBox(height: 4.px),
                        CW.commonShimmerViewForImage(height: 15.px,width: 32.px),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.px),
                child: Row(
                  children: [
                    CW.commonShimmerViewForImage(height: 30.px,width: 30.px),
                    SizedBox(width: 10.px),
                    CW.commonShimmerViewForImage(height: 30.px,width: 30.px),
                    SizedBox(width: 10.px),
                    CW.commonShimmerViewForImage(height: 30.px,width: 30.px),
                    SizedBox(width: 10.px),
                    CW.commonShimmerViewForImage(height: 30.px,width: 30.px),
                    SizedBox(width: 10.px),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      if(apiResValueForSubTask || apiResValue)
      SizedBox(height: 8.h)
    ],
  );
}