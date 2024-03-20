// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';

class MyDropdown<T> extends StatelessWidget {
  final List<T> items;
  final List<String> nameList;
  final T? selectedItem;
  String hintText;
  final TextEditingController textEditingController;
  FormFieldValidator<String>? validator;
  bool isOpenValue;
  final Function(T? value) clickOnListOfDropDown;
  GestureTapCallback onTapForTextFiled;

  MyDropdown({
    Key? key,
    required this.items,
    required this.nameList,
    required this.selectedItem,
    required this.hintText,
    required this.textEditingController,
    required this.isOpenValue,
    required this.clickOnListOfDropDown,
    required this.onTapForTextFiled,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isOpen = false;
    return StatefulBuilder(
      builder: (context, setState) {
        isOpen = isOpenValue;
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CW.commonTextField(
              isSearchLabelText: false,
              hintText: hintText,
              controller: textEditingController,
              validator: validator,
              readOnly: true,
              suffixIcon: InkWell(
                onTap: onTapForTextFiled,
                borderRadius: BorderRadius.circular(30.px),
                child: Icon(
                    isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: isOpen ? Col.primary : Col.gTextColor),
              ),
              // onTap: onTapForTextFiled,
            ),
            AnimatedCrossFade(
                firstChild: Container(
                  margin: EdgeInsets.only(top: 10.px),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Col.primary, width: .5.px),
                    color: Col.gCardColor,
                    borderRadius: BorderRadius.circular(12.px),
                  ),
                  constraints: BoxConstraints(maxHeight: 150.px),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: nameList.length,
                    padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 4.px),
                    itemBuilder: (context, index) {
                      // if(selectedItem == nameList[index]){
                      //   String valueToMove = nameList.removeAt(index);
                      //   nameList.insert(0, valueToMove);
                      // }
                      return GestureDetector(
                        onTap: () {
                          // Call onChanged callback and pass the selected item
                          clickOnListOfDropDown(items[index]);
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(bottom: index == nameList.length - 1 ? 0.px : 6.px),
                          padding: EdgeInsets.all(selectedItem == nameList[index] ? 10.px : 6.px),
                          decoration: BoxDecoration(
                              color: selectedItem == nameList[index]
                                  ? Col.primary.withOpacity(.1)
                                  : null,
                              borderRadius: BorderRadius.circular(4.px)),
                          child: Row(
                            children: [
                              if (selectedItem == nameList[index])
                                Icon(Icons.check, color: Col.primary, size: 16.px),
                              SizedBox(width: 6.px),
                              Flexible(
                                child: Text(
                                  nameList[index],
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: selectedItem == nameList[index] ? Col.primary : Col.gTextColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                secondChild: const SizedBox(),
                crossFadeState: isOpen?CrossFadeState.showFirst:CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(microseconds: 1),
            ),
            // Visibility(
            //   visible: isOpen,
            //   child: Container(
            //     margin: EdgeInsets.only(top: 10.px),
            //     decoration: BoxDecoration(
            //       // border: Border.all(color: Col.primary, width: .5.px),
            //       color: Col.gCardColor,
            //       borderRadius: BorderRadius.circular(12.px),
            //     ),
            //     constraints: BoxConstraints(maxHeight: 150.px),
            //     child: ListView.builder(
            //       shrinkWrap: true,
            //       itemCount: nameList.length,
            //       padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 4.px),
            //       itemBuilder: (context, index) {
            //         // if(selectedItem == nameList[index]){
            //         //   String valueToMove = nameList.removeAt(index);
            //         //   nameList.insert(0, valueToMove);
            //         // }
            //         return GestureDetector(
            //           onTap: () {
            //             // Call onChanged callback and pass the selected item
            //             clickOnListOfDropDown(items[index]);
            //           },
            //           child: Container(
            //             alignment: Alignment.centerLeft,
            //             margin: EdgeInsets.only(bottom: index == nameList.length - 1 ? 0.px : 6.px),
            //             padding: EdgeInsets.all(selectedItem == nameList[index] ? 10.px : 6.px),
            //             decoration: BoxDecoration(
            //                 color: selectedItem == nameList[index]
            //                     ? Col.primary.withOpacity(.1)
            //                     : null,
            //                 borderRadius: BorderRadius.circular(4.px)),
            //             child: Row(
            //               children: [
            //                 if (selectedItem == nameList[index])
            //                   Icon(Icons.check, color: Col.primary, size: 16.px),
            //                 SizedBox(width: 6.px),
            //                 Flexible(
            //                   child: Text(
            //                     nameList[index],
            //                     style: Theme.of(context).textTheme.labelSmall?.copyWith(
            //                             fontWeight: FontWeight.w600,
            //                             color: selectedItem == nameList[index] ? Col.primary : Col.gTextColor),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}

class MyDropdownForMultiValue<T> extends StatelessWidget {
  final List<T> items;
  final List<String> nameList;
  final List<T> selectedItems;
  String hintText;
  String? validatorTitle;
  bool isOpenValue;
  final Function(List<T> values) clickOnListOfDropDown;
  GestureTapCallback onTapForTextFiled;

  MyDropdownForMultiValue({
    Key? key,
    required this.items,
    required this.nameList,
    required this.selectedItems,
    required this.hintText,
    required this.isOpenValue,
    required this.clickOnListOfDropDown,
    required this.onTapForTextFiled,
    this.validatorTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isOpen = false;
    return StatefulBuilder(builder: (context, setState) {
      isOpen = isOpenValue;
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.only(top: 12.px, bottom: 12.px, left: 16.px, right: 10.px),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: isOpenValue ? Col.primary : Col.gray,
              ),
              borderRadius: BorderRadius.circular(10.px),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: selectedItems.isNotEmpty
                      ? Wrap(
                          spacing: 10.px,runSpacing: 10.px,
                          children: List.generate(selectedItems.length, (index) {
                            // final item = items[index];
                            // final isSelected = selectedItems.contains(item);
                            return /*ChoiceChip(
                          avatar: Icon(Icons.close, color: Col.primary),
                          showCheckmark: false,
                          selectedColor: Col.gCardColor,
                          elevation: 0,
                          label: Flexible(child: Text('${selectedItems[index]}',style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Col.primary))),
                          selected: true,
                          onSelected: (bool selected) {
                            if (selected) {
                              // selectedItems.add(item);
                            } else {
                              selectedItems.removeAt(index);
                            }
                            clickOnListOfDropDown(selectedItems);
                          },
                        )*/
                              Container(
                              padding: EdgeInsets.all(6.px),
                              // margin: EdgeInsets.only(bottom: 10.px,right: 10.px),
                              decoration: BoxDecoration(color: Col.gCardColor, borderRadius: BorderRadius.circular(6.px)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${selectedItems[index]}',
                                      style: Theme.of(context).textTheme.labelLarge,
                                      // overflow: TextOverflow.ellipsis,
                                      // maxLines: 1,
                                    ),
                                  ),
                                  InkWell(
                                     borderRadius: BorderRadius.circular(8.px),
                                     onTap: () {
                                       selectedItems.removeAt(index);
                                       clickOnListOfDropDown(selectedItems);
                                     },
                                    child: Container(
                                      width: 16.px,
                                      height: 16.px,
                                      margin: EdgeInsets.only(left: 10.px),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: CW.commonLinearGradientForButtonsView(),
                                      ),
                                      child: Icon(Icons.close, size: 12.px, color: Col.gBottom),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        )
                      : Text(
                          hintText,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Col.inverseSecondary),
                        ),
                ),
                InkWell(
                  onTap: onTapForTextFiled,
                  borderRadius: BorderRadius.circular(20.px),
                  child: Icon(
                      isOpen
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: isOpen
                          ? Col.primary
                          : Col.gTextColor,size: 24.px),
                )
              ],
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(
              margin: EdgeInsets.only(top: 10.px),
              decoration: BoxDecoration(
                // border: Border.all(color: Col.primary, width: .5.px),
                color: Col.gCardColor,
                borderRadius: BorderRadius.circular(12.px),
              ),
              constraints: BoxConstraints(maxHeight: 150.px),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: nameList.length,
                padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 4.px),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      T selectedItem = items[index];
                      if (selectedItems.contains(selectedItem)) {
                        selectedItems.remove(selectedItem);
                      } else {
                        selectedItems.add(selectedItem);
                      }
                      // Call onChanged callback and pass the selected items list
                      clickOnListOfDropDown(selectedItems);
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: index == nameList.length - 1 ? 0.px : 6.px),
                      padding: EdgeInsets.all(6.px),
                      decoration: BoxDecoration(
                        color: selectedItems.contains(items[index])
                            ? Col.primary.withOpacity(.1)
                            : null,
                        borderRadius: BorderRadius.circular(4.px),
                      ),
                      child: Row(
                        children: [
                          // CW.commonCheckBoxView(
                          //   changeValue: selectedItems.contains(items[index]),
                          //   onChanged: (bool? value) {
                          //     T selectedItem = items[index];
                          //     if (value!) {
                          //       selectedItems.add(selectedItem);
                          //     } else {
                          //       selectedItems.remove(selectedItem);
                          //     }
                          //     // Call onChanged callback and pass the selected items list
                          //     clickOnListOfDropDown(selectedItems);
                          //   },
                          //   visualDensity: VisualDensity(
                          //       horizontal: -4.px, vertical: -4.px),
                          // ),
                          Icon(Icons.check,
                              color: selectedItems.contains(items[index])
                                  ? Col.primary
                                  : Col.gTextColor, size: 16.px),
                          SizedBox(width: 6.px),
                          Flexible(
                            child: Text(
                              nameList[index],
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color:  selectedItems.contains(items[index])
                                    ? Col.primary
                                    : Col.gTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            secondChild: const SizedBox(),
            crossFadeState: isOpen?CrossFadeState.showFirst:CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 500),
            reverseDuration: const Duration(microseconds: 1),
          ),
          /*Visibility(
            visible: isOpen,
            child: Container(
              margin: EdgeInsets.only(top: 10.px),
              decoration: BoxDecoration(
                // border: Border.all(color: Col.primary, width: .5.px),
                color: Col.gCardColor,
                borderRadius: BorderRadius.circular(12.px),
              ),
              constraints: BoxConstraints(maxHeight: 150.px),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: nameList.length,
                padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 4.px),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      T selectedItem = items[index];
                      if (selectedItems.contains(selectedItem)) {
                        selectedItems.remove(selectedItem);
                      } else {
                        selectedItems.add(selectedItem);
                      }
                      // Call onChanged callback and pass the selected items list
                      clickOnListOfDropDown(selectedItems);
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: index == nameList.length - 1 ? 0.px : 6.px),
                      padding: EdgeInsets.all(6.px),
                      decoration: BoxDecoration(
                        color: selectedItems.contains(items[index])
                            ? Col.primary.withOpacity(.1)
                            : null,
                        borderRadius: BorderRadius.circular(4.px),
                      ),
                      child: Row(
                        children: [
                          // CW.commonCheckBoxView(
                          //   changeValue: selectedItems.contains(items[index]),
                          //   onChanged: (bool? value) {
                          //     T selectedItem = items[index];
                          //     if (value!) {
                          //       selectedItems.add(selectedItem);
                          //     } else {
                          //       selectedItems.remove(selectedItem);
                          //     }
                          //     // Call onChanged callback and pass the selected items list
                          //     clickOnListOfDropDown(selectedItems);
                          //   },
                          //   visualDensity: VisualDensity(
                          //       horizontal: -4.px, vertical: -4.px),
                          // ),
                          Icon(Icons.check,
                              color: selectedItems.contains(items[index])
                                  ? Col.primary
                                  : Col.gTextColor, size: 16.px),
                          SizedBox(width: 6.px),
                          Flexible(
                            child: Text(
                              nameList[index],
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color:  selectedItems.contains(items[index])
                                        ? Col.primary
                                        : Col.gTextColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),*/
        ],
      );
    });
  }
}
