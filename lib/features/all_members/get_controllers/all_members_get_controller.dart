import 'package:get/get.dart';

import '../../add_new_member/models/member_model.dart';

class AllMembersGetController extends GetxController {
  RxList<MemberModel> allMembers = <MemberModel>[].obs;

  void fetchAllMembers() {
    for (int i = 0; i < 10; i++) {
      allMembers.add(MemberModel.empty());
    }
  }

  @override
  void onInit() {
    fetchAllMembers();
    super.onInit();
  }
}
