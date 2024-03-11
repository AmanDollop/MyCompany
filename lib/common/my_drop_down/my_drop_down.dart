// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
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
  String? validatorTitle;
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
    this.validatorTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isOpen = false;
    return StatefulBuilder(builder: (context, setState) {
      isOpen = isOpenValue;
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CW.commonTextField(
            isSearchLabelText: false,
            hintText: hintText,
            controller: textEditingController,
            validator: (value) => V.isValid(value: value, title: validatorTitle ?? ''),
            readOnly: true,
            suffixIcon: Icon(isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: Col.secondary),
            onTap: onTapForTextFiled,
          ),
          Visibility(
            visible: isOpen,
            child: Container(
              margin: EdgeInsets.only(top: 10.px),
              decoration: BoxDecoration(
                border: Border.all(color: Col.primary,width: .5.px),
                color: Col.inverseSecondary,
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
                      margin: EdgeInsets.only(bottom: index == nameList.length - 1? 0.px: 6.px),
                      padding: EdgeInsets.all(selectedItem == nameList[index]
                          ? 10.px
                          : 6.px),
                      decoration: BoxDecoration(
                          color: selectedItem == nameList[index]
                              ? Col.primary.withOpacity(.2)
                              : null,
                          borderRadius: BorderRadius.circular(4.px)),
                      child: Row(
                        children: [
                          if(selectedItem == nameList[index])
                            Icon(Icons.check,color: Col.primary,size: 16.px),
                          SizedBox(width: 6.px),
                          Text(
                            nameList[index],
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: selectedItem == nameList[index]
                                    ? Col.primary
                                    : Col.text),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
       );
      },
    );
  }
}