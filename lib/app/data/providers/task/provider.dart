import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/data/services/storage/services.dart';
import 'package:todo/app/core/utils/keys.dart';

class TaskProvider{
  StorageService _storage = Get.find<StorageService>();

  //read all tasks from storage
  List<Task> readTasks(){
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString()).
    forEach((e)=> tasks.add(Task.fromJson(e)));
    return tasks;
  }

  //write a new task
  void writeTasks(List<Task> tasks){
    _storage.write(taskKey, jsonEncode(tasks));
  }

}