/*
* app name : Handy Assistant
* author : Thathsara Hewage
* finished date : 8-14-2022
* */


import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo/app/data/services/storage/services.dart';
import 'package:todo/app/modules/home/binding.dart';
import 'package:todo/app/modules/home/view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TODO app',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),

      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

