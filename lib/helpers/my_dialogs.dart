import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MyDialogs{
  static sucess({required String msg}){
  Get.snackbar('Sucess',msg ,colorText: Colors.white,backgroundColor: Colors.green.withOpacity(.6));
  }
  static error({required String msg}){
  Get.snackbar('Error',msg ,colorText: Colors.white,backgroundColor: Colors.redAccent.withOpacity(.6));
  }
  static warning({required String msg}){
  Get.snackbar('Info',msg ,colorText: Colors.white);
  }
}