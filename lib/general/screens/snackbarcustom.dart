import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SnackBarCustom
{
  static void showInfo(String title,String message) {
    Get.showSnackbar(GetSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.blue,
      icon: const Icon(Icons.refresh),
      duration: const Duration(seconds: 3),
    ));
  }
}