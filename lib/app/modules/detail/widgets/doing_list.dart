/*
* app name : Handy Assistant
* author : Thathsara Hewage
* finished date : 8-14-2022
* */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/core/utils/extensions.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> homeCtrl.doingToDos.isEmpty && homeCtrl.doingToDos.isEmpty
            ? Column(
                children: [
                  Image.asset('assets/image/task.png',
                  fit: BoxFit.cover,
                  width: 45.0.wp,),
                  Text('Add Task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0.sp,
                  ),)
                ],
              )
           : ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children:[
                  ...homeCtrl.doingToDos.map((element) =>
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 3.0.wp,
                        horizontal: 9.0.wp,
                      ),
                      child: Row(
                        children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith((states) => Colors.grey),
                                value: element['done'],
                                onChanged: (value){
                                  homeCtrl.doneToDo(element['title']);
                                },
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.0.wp
                            ),
                            child: Text(
                              element['title'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          )],),)
                    ).toList(),
                  if(homeCtrl.doneToDos.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                      child: const Divider(thickness: 2,),
                    )
                ]
           )
    );
  }
}
