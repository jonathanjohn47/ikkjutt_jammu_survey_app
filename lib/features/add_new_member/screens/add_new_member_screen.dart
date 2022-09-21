import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_button.dart';

import '../../../widgets/standard_app_bar.dart';
import '../get_controllers/add_new_member_get_controller.dart';

class AddNewMemberScreen extends StatelessWidget {
  AddNewMemberScreen({Key? key}) : super(key: key);

  AddNewMemberGetController addNewMemberGetController =
      Get.put(AddNewMemberGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: StandardAppBar(
            title: 'Add New Member',
          )),
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Obx(() {
                        return addNewMemberGetController.profilePicLink.value ==
                                "assets/images/profile.png"
                            ? CircleAvatar(
                                radius: 80,
                                backgroundImage: AssetImage(
                                    addNewMemberGetController
                                        .profilePicLink.value))
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(File(
                                    addNewMemberGetController
                                        .profilePicLink.value)));
                      }),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: FloatingActionButton(
                          onPressed: () {},
                          child: Icon(Icons.add_a_photo),
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                  controller: addNewMemberGetController.firstNameController,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                  controller: addNewMemberGetController.lastNameController,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  controller: addNewMemberGetController.phoneNumberController,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  controller: addNewMemberGetController.addressController,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Designation',
                    border: OutlineInputBorder(),
                  ),
                  controller: addNewMemberGetController.designationController,
                ),
                SizedBox(
                  height: 10,
                ),
                StandardButton(
                  onPressed: () {
                    addNewMemberGetController.addNewMember();
                  },
                  text: 'Add Member',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
