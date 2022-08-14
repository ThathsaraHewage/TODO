/*
* app name : Handy Assistant
* author : Thathsara Hewage
* finished date : 8-14-2022
* */

import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/data/providers/task/provider.dart';

class TaskRepository{
  TaskProvider taskProvider;

  //constructor
  TaskRepository({required this.taskProvider});

  List<Task> readTasks() => taskProvider.readTasks();

  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}