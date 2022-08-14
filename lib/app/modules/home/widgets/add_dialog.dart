import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:todo/app/core/utils/extensions.dart';

import '../controller.dart';

class AddDialog extends StatelessWidget {

  final homeCtrl = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: (){
                        Get.back();
                        homeCtrl.editController.clear();
                        homeCtrl.changeTask(null);
                      },
                      icon: const Icon(Icons.close),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent)
                    ),
                      onPressed: (){
                        if(homeCtrl.formKey.currentState!.validate()){
                          if(homeCtrl.task.value == null){
                            EasyLoading.showError('Please select task type');
                          }
                          else{
                            var success = homeCtrl.updateTask(
                              homeCtrl.task.value!,
                              homeCtrl.editController.text,
                            );
                            if(success){
                              EasyLoading.showSuccess('TODO item added successfully');
                              Get.back();
                              homeCtrl.changeTask(null);
                            }
                            else{
                              EasyLoading.showError('TODO item already exist');
                            }
                            homeCtrl.editController.clear();
                          }
                        }
                      },
                      child: Text('Done',
                      style: TextStyle(fontSize: 14.0.sp),
                      ))
                ],
              ),
      ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: Text(
                    'Add a New Task',
                  style: TextStyle(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.bold,
                  ),

                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextFormField(
                  controller: homeCtrl.editController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    )
                  ),
                  autofocus: true,
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'Please enter your TODO item';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 5.0.wp,
                  left: 5.0.wp,
                  right: 5.0.wp,
                  bottom: 2.0.wp,
                ),
                child: Text('select a task type ',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...homeCtrl.tasks.map((element) =>
                Obx(
                    () => InkWell(
                    onTap: () =>
                      homeCtrl.changeTask(element),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3.0.wp,
                          horizontal: 5.0.wp,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                  IconData(
                                    element.icon,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  color: HexColor.fromHex(element.color)),
                              SizedBox(
                                width: 3.0.wp,
                              ),
                              Text(
                                  element.title,
                                  style: TextStyle(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.bold,
                                  )),
                              if(homeCtrl.task.value == element)
                                const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ).toList()
            ],
          ),
        ),
      ),
    );
  }
}
