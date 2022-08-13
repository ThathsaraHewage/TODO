import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/modules/detail/view.dart';
import 'package:todo/app/modules/home/controller.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;
  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var squareWidth = Get.width - 12.0.wp;
    final color = HexColor.fromHex(task.color);

    return GestureDetector(
      onTap: (){
        homeCtrl.changeTask(task);
        homeCtrl.changeToDos(task.todos ?? []);
        Get.to(() => DetailPage());
      },
      child: Container(
        width: squareWidth/2,
        height: squareWidth,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: const Offset(0, 7),
            )
          ]
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              StepProgressIndicator(
                totalSteps: homeCtrl.isToDosEmpty(task) ? 1 : task.todos!.length,
                currentStep: homeCtrl.isToDosEmpty(task) ? 0 : homeCtrl.getDoneToDo(task),
                size: 5,
                padding: 0,
                selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5),color],
                ),
                unselectedGradientColor: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white],
                ),
              ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                  IconData(
                      task.icon,
                      fontFamily: 'MaterialIcons'
                  ),
              color: color),
            ),
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp
                    ),
                    overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 2.0.wp,
                    ),
                    Text('${task.todos?.length ?? 0} Task',
                        style: const TextStyle(
                          color: Colors.grey,
                        )
                  ),

                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
