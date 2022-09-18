import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/core/app_colors.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_members/get_controllers/member_profile_screen_get_controller.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_app_bar.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/standard_divider.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/text_with_format.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../add_new_member/models/member_model.dart';

class MemberProfileScreen extends StatelessWidget {
  final MemberModel memberModel;

  MemberProfileScreen({Key? key, required this.memberModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MemberProfileScreenGetController memberProfileScreenGetController =
        Get.put(MemberProfileScreenGetController(memberModel));
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: StandardAppBar(
            title: memberProfileScreenGetController
                    .newMemberModel.value.firstName +
                ' ' +
                memberProfileScreenGetController.newMemberModel.value.lastName,
            actions: [
              IconButton(onPressed: () {
                memberProfileScreenGetController.deleteMember();
              }, icon: Icon(MdiIcons.delete))
            ],
          )),
      body: SizedBox(
        width: Get.width,
        height: Get.height - kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              memberProfileScreenGetController
                          .newMemberModel.value.profilePicture ==
                      null
                  ? CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    )
                  : CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                          memberProfileScreenGetController
                              .newMemberModel.value.profilePicture!),
                    ),
              SizedBox(
                height: 10,
              ),
              TextWithFormat(
                memberProfileScreenGetController
                        .newMemberModel.value.firstName.capitalize! +
                    ' ' +
                    memberProfileScreenGetController
                        .newMemberModel.value.lastName.capitalize!,
                fontSize: 24,
                color: AppColors.secondaryHeaderColor.shade700,
                bold: true,
              ),
              SizedBox(
                height: 10,
              ),
              StandardDivider(),
              ListTile(
                leading: SizedBox(
                    width: Get.width / 5,
                    child: Center(
                        child: TextWithFormat(
                      'Designation:',
                      bold: true,
                    ))),
                title: Obx(() {
                  return memberProfileScreenGetController
                              .newMemberModel.value.designation !=
                          null
                      ? memberProfileScreenGetController.changeDesignation.value
                          ? TextFormField(
                              controller: memberProfileScreenGetController
                                  .designationController,
                              decoration: InputDecoration(
                                  labelText: 'Designation',
                                  hintText: memberProfileScreenGetController
                                      .newMemberModel.value.designation,
                                  border: OutlineInputBorder()),
                            )
                          : TextWithFormat(
                              memberProfileScreenGetController
                                  .newMemberModel.value.designation!,
                              fontSize: 18,
                              color: Colors.grey.shade700,
                              bold: true,
                            )
                      : Container();
                }),
                trailing: Obx(() {
                  return IconButton(
                    icon:
                        memberProfileScreenGetController.changeDesignation.value
                            ? Icon(Icons.save)
                            : Icon(Icons.edit),
                    onPressed: () {
                      memberProfileScreenGetController.changeDesignation.value =
                          !memberProfileScreenGetController
                              .changeDesignation.value;
                      memberProfileScreenGetController
                              .designationController.text =
                          memberProfileScreenGetController
                              .newMemberModel.value.designation!;
                    },
                  );
                }),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: SizedBox(
                    width: Get.width / 5,
                    child: TextWithFormat('Phone:', bold: true)),
                title: Obx(() {
                  return memberProfileScreenGetController
                          .changePhoneNumber.value
                      ? TextFormField(
                          controller:
                              memberProfileScreenGetController.phoneController,
                          decoration: InputDecoration(
                              labelText: 'Phone',
                              hintText: memberProfileScreenGetController
                                  .newMemberModel.value.phoneNumber,
                              border: OutlineInputBorder()),
                        )
                      : GestureDetector(
                          onLongPress: () {
                            //copy phone to clipboard
                            Clipboard.setData(ClipboardData(
                                    text: "+91" +
                                        memberProfileScreenGetController
                                            .newMemberModel.value.phoneNumber))
                                .then((value) {
                              Get.snackbar(
                                  'Copied', 'Phone number copied to clipboard',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white);
                            });
                          },
                          child: TextWithFormat(
                            memberProfileScreenGetController
                                .newMemberModel.value.phoneNumber,
                            fontSize: 18,
                            color: Colors.grey.shade700,
                            bold: true,
                          ),
                        );
                }),
                trailing: IconButton(
                  icon: memberProfileScreenGetController.changePhoneNumber.value
                      ? Icon(Icons.save)
                      : Icon(Icons.edit),
                  onPressed: () {
                    memberProfileScreenGetController.changePhoneNumber.value =
                        !memberProfileScreenGetController
                            .changePhoneNumber.value;
                    memberProfileScreenGetController.phoneController.text =
                        memberProfileScreenGetController
                            .newMemberModel.value.phoneNumber;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //numberOfSurveysAttended
              ListTile(
                leading: SizedBox(
                    width: Get.width / 5,
                    child: TextWithFormat('Surveys:', bold: true)),
                title: Obx(() {
                  return TextWithFormat(
                    memberProfileScreenGetController
                        .numberOfSurveysAttended.value
                        .toString(),
                    fontSize: 18,
                    color: Colors.grey.shade700,
                    bold: true,
                  );
                }),
              ),
              SizedBox(
                height: 10,
              ),
              //numberOfEventsAttended
              ListTile(
                leading: SizedBox(
                    width: Get.width / 5,
                    child: TextWithFormat('Events:', bold: true)),
                title: Obx(() {
                  return TextWithFormat(
                    memberProfileScreenGetController
                        .numberOfEventsAttended.value
                        .toString(),
                    fontSize: 18,
                    color: Colors.grey.shade700,
                    bold: true,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
