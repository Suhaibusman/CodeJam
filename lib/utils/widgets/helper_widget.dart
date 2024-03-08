import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:codejam/utils/themes/color_theme.dart';


reusableBackButton() {
  return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: white,
      ));
}
