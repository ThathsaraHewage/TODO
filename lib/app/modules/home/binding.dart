/*
* app name : Handy Assistant
* author : Thathsara Hewage
* finished date : 8-14-2022
* */

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:todo/app/data/providers/task/provider.dart';
import 'package:todo/app/data/services/storage/repository.dart';
import 'package:todo/app/modules/home/controller.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        taskRepository: TaskRepository(
          taskProvider : TaskProvider(),
        ),
    ));
  }

}