import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/features/all_members/get_controllers/all_members_get_controller.dart';

import '../../../widgets/standard_app_bar.dart';
import 'member_profile_screen.dart';

class AllMembersScreen extends StatelessWidget {
  AllMembersScreen({Key? key}) : super(key: key);

  AllMembersGetController allMembersGetController =
      Get.put(AllMembersGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: StandardAppBar(
            title: 'All Members',
          )),
      body: ListView.builder(
        itemCount: allMembersGetController.allMembers.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: allMembersGetController.allMembers[index].profilePicture ==
                    null
                ? CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.png'))
                : CircleAvatar(
                    backgroundImage: NetworkImage(allMembersGetController
                        .allMembers[index].profilePicture!),
                  ),
            title: Text(allMembersGetController.allMembers[index].firstName +
                ' ' +
                allMembersGetController.allMembers[index].lastName),
            subtitle: allMembersGetController.allMembers[index].designation !=
                    null
                ? Text(allMembersGetController.allMembers[index].designation!)
                : null,
            onTap: () {
              Get.to(() => MemberProfileScreen(
                    memberModel: allMembersGetController.allMembers[index],
                  ));
            },
          );
        },
      ),
    );
  }
}
