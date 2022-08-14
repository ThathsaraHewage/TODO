/*
* app name : Handy Assistant
* author : Thathsara Hewage
* finished date : 8-14-2022
* */

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/data/services/storage/repository.dart';

class HomeController extends GetxController{
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final tabIndex = 0.obs;
  final deleting = false.obs;
  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);
  final doingToDos = <dynamic>[].obs;
  final doneToDos = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks,(_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeChipIndex(int value){
        chipIndex.value = value;
  }

  void changeDeleting(bool value){
    deleting.value = value;
  }

  void deleteTask(Task task){
    tasks.remove(task);
  }

  void changeTask(Task? select){
    task.value = select;
  }

  bool addTask(Task task){
    if(tasks.contains(task)){
      return false;
    }
    tasks.add(task);
    return true;
  }

  updateTask(Task task, String title){
    var todos = task.todos ?? [];
    if(containTodo(todos,title)){
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();

    return true;

  }

  bool containTodo(List todos, String title){
    return todos.any((element) => element['title'] == title);
  }

  void changeToDos(List<dynamic>select){
    doingToDos.clear();
    doneToDos.clear();

    for(int i=0; i< select.length; i++){
      var todo = select[i];
      var status = todo['done'];

      if(status == true){
        doneToDos.add(todo);
      }
      else{
        doingToDos.add(todo);
      }
    }
  }

  bool addToDo(String title){
    var todo = {'title': title, 'done': false};
    var doneToDo = {'title': title, 'done': true};

    if(doingToDos.any((element) => mapEquals<String,dynamic>(todo, element))){
      return false;
    }

    if(doneToDos.any((element) => mapEquals<String, dynamic>(todo,element))){
      return true;
    }

    doingToDos.add(todo);
    return true;
  }

  void updateToDos(){
    var newToDos =  <Map<String, dynamic>>[];
    newToDos.addAll([
      ...doingToDos,
    ...doneToDos
    ]);

    var newTask = task.value!.copyWith(todos: newToDos);
    int oldIdx = tasks.indexOf(task.value);
    tasks[oldIdx] = newTask;
    tasks.refresh();
  }

  void doneToDo(String title){
    var doingToDo = {'title': title, 'done': false};
    int index = doingToDos.indexWhere((element) =>
        mapEquals<String,dynamic>(doingToDo,element));

    doingToDos.removeAt(index);
    var doneToDo = {'title': title, 'done': true};
    doneToDos.add(doneToDo);
    doingToDos.refresh();
    doneToDos.refresh();
  }

  void deleDoneToDo(dynamic doneToDo) {
      int index =  doneToDos.indexWhere((element) =>
      mapEquals<String,dynamic>(doneToDo,element));
      doneToDos.removeAt(index);
      doneToDos.refresh();
  }

  bool isToDosEmpty(Task task){
    return task.todos == null || task.todos!.isEmpty;
  }

  int getDoneToDo(Task task){
    var res = 0;
    for(int i=0; i< task.todos!.length; i++){
      if(task.todos![i]['done'] == true){
        res +=1;
      }
    }
    return res;
  }

  void changeTabIndex(int index){
    tabIndex.value = index;
  }

  int getTotalTask(){
    var res = 0;
    for(int i=0; i<tasks.length; i++){
      if(tasks[i].todos != null){
        res += tasks[i].todos!.length;
      }
    }
    return res;
  }

  int getTotalDoneTask(){
    var res = 0;
    for(int i=0 ; i< tasks.length; i++){
      if(tasks[i].todos != null){
        for(int k = 0; k < tasks[i].todos!.length; k++){
          if(tasks[i].todos![k]['done'] == true){
            res += 1;
          }
        }
      }
    }
    return res;
  }
}