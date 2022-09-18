import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:get/get.dart';
import 'package:ikkjutt_jammu_survey_app/core/app_colors.dart';
import 'package:ikkjutt_jammu_survey_app/widgets/text_with_format.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../add_new_member/models/member_model.dart';
import '../models/question_model.dart';

class NewSurveyGetController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  Rx<DateTime> scheduledAt = DateTime.now().obs;

  RxList<QuestionModel> questions = <QuestionModel>[].obs;

  RxList<MemberModel> allMembers = <MemberModel>[].obs;
  RxList<MemberModel> selectedMembers = <MemberModel>[].obs;

  void pickScheduledAt() {
    DatePicker.showDateTimePicker(
      Get.context!,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2022, 12, 31),
      onConfirm: (date) {
        scheduledAt.value = date;
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void fetchAllMembers() {
    for (int i = 0; i < 10; i++) {
      allMembers.add(MemberModel(
        firstName: 'Member $i',
        lastName: 'Last Name $i',
        phoneNumber: i.toString() * 10,
        address: 'Address $i',
      ));
    }
  }

  void addQuestion() {
    Get.dialog(AlertDialog(
      title: Text('Choose Question Type'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListTile(
            leading: Icon(Icons.text_fields),
            title: Text('Free Text'),
            onTap: () {
              TextEditingController questionTextController =
                  TextEditingController();
              Get.back();
              Get.dialog(AlertDialog(
                title: Text('Free Text Question'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Question Text',
                        border: OutlineInputBorder(),
                      ),
                      controller: questionTextController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Geofence.getCurrentLocation().then((location) {
                              QuestionModel questionModel = QuestionModel(
                                freeTextQuestionModel: FreeTextQuestionModel(
                                  questionText: questionTextController.text,
                                  latitude:
                                      location == null ? 0 : location.latitude,
                                  longitude:
                                      location == null ? 0 : location.longitude,
                                ),
                                questionNumber: questions.length + 1,
                              );
                              questions.add(questionModel);
                              Get.back();
                            });
                          },
                          child: Text('Add'),
                        ),
                      ],
                    )
                  ],
                ),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.check_box),
            title: Text('True False'),
            onTap: () {
              TextEditingController questionTextController =
                  TextEditingController();
              Get.back();
              Get.dialog(AlertDialog(
                title: Text('True False Question'),
                content: SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: questionTextController.text,
                          border: OutlineInputBorder(),
                        ),
                        controller: questionTextController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Geofence.getCurrentLocation().then((location) {
                                QuestionModel questionModel = QuestionModel(
                                  trueFalseQuestionModel:
                                      TrueFalseQuestionModel(
                                    questionText: questionTextController.text,
                                  ),
                                  questionNumber: questions.length + 1,
                                );
                                questions.add(questionModel);
                                Get.back();
                              });
                            },
                            child: Text('Add'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.radio_button_checked),
            title: Text('Select One Option'),
            onTap: () {
              TextEditingController questionTextController =
                  TextEditingController();
              TextEditingController option1Controller = TextEditingController();
              List<String> options = [];
              Get.back();
              Get.dialog(AlertDialog(
                title: Text('Select One Option Question'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Question Text',
                          border: OutlineInputBorder(),
                        ),
                        controller: questionTextController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<List<String>>(
                          stream:
                              Stream.periodic(Duration(milliseconds: 1), (_) {
                            return options;
                          }),
                          builder: (context, snapshot) {
                            return Column(
                              children: [
                                ...options
                                    .map((e) => ListTile(
                                        leading: TextWithFormat(
                                          (options.indexOf(e) + 1).toString(),
                                          color: Colors.grey,
                                          italic: true,
                                        ),
                                        title: TextWithFormat(
                                          e,
                                          bold: true,
                                        )))
                                    .toList(),
                              ],
                            );
                          }),
                      TextButton(
                          onPressed: () {
                            option1Controller.text = '';
                            Get.dialog(AlertDialog(
                              title: TextWithFormat('Add Option'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Option',
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: option1Controller,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          options.add(option1Controller.text);
                                          Get.back();
                                        },
                                        child: Text('Add'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ));
                          },
                          child: TextWithFormat(
                            '+ Add Option',
                            color: AppColors.secondaryHeaderColor.shade700,
                            bold: true,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Geofence.getCurrentLocation().then((location) {
                                QuestionModel questionModel = QuestionModel(
                                  selectOneOptionQuestion:
                                      SelectOneOptionQuestion(
                                    questionText: questionTextController.text,
                                    options: options,
                                  ),
                                  questionNumber: questions.length + 1,
                                );
                                questions.add(questionModel);
                                Get.back();
                              });
                            },
                            child: Text('Add'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.check_box_outline_blank),
            title: Text('Select Multiple Options'),
            onTap: () {
              TextEditingController questionTextController =
                  TextEditingController();
              TextEditingController option1Controller = TextEditingController();
              List<String> options = [];
              Get.back();
              Get.dialog(AlertDialog(
                title: Text('Select Multiple Options Question'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Question Text',
                          border: OutlineInputBorder(),
                        ),
                        controller: questionTextController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<List<String>>(
                          stream:
                              Stream.periodic(Duration(milliseconds: 1), (_) {
                            return options;
                          }),
                          builder: (context, snapshot) {
                            return Column(
                              children: [
                                ...options
                                    .map((e) => ListTile(
                                        leading: TextWithFormat(
                                          (options.indexOf(e) + 1).toString(),
                                          color: Colors.grey,
                                          italic: true,
                                        ),
                                        title: TextWithFormat(
                                          e,
                                          bold: true,
                                        )))
                                    .toList(),
                              ],
                            );
                          }),
                      TextButton(
                          onPressed: () {
                            option1Controller.text = '';
                            Get.dialog(AlertDialog(
                              title: TextWithFormat('Add Option'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Option',
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: option1Controller,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          options.add(option1Controller.text);
                                          Get.back();
                                        },
                                        child: Text('Add'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ));
                          },
                          child: TextWithFormat(
                            '+ Add Option',
                            color: AppColors.secondaryHeaderColor.shade700,
                            bold: true,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Geofence.getCurrentLocation().then((location) {
                                QuestionModel questionModel = QuestionModel(
                                  questionNumber: questions.length + 1,
                                  selectMultipleOptionsQuestion:
                                      SelectMultipleOptionsQuestion(
                                    questionText: questionTextController.text,
                                    options: options,
                                  ),
                                );
                                questions.add(questionModel);
                                Get.back();
                              });
                            },
                            child: Text('Add'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.sortNumericAscending),
            title: Text('Number Type'),
            onTap: () {
              TextEditingController questionTextController =
                  TextEditingController();
              Get.back();
              Get.dialog(AlertDialog(
                title: Text('Number Type Question'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Question Text',
                          border: OutlineInputBorder(),
                        ),
                        controller: questionTextController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Geofence.getCurrentLocation().then((location) {
                                QuestionModel questionModel = QuestionModel(
                                  questionNumber: questions.length + 1,
                                  numberTypeQuestion: NumberTypeQuestion(
                                    questionText: questionTextController.text,
                                  ),
                                );
                                questions.add(questionModel);
                                Get.back();
                              });
                            },
                            child: Text('Add'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
            },
          ),
        ],
      ),
    ));
  }

  void createSurvey() {
    Get.dialog(AlertDialog(
      title: Text('Choose Members'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<MemberModel>>(
                stream: Stream.periodic(Duration(milliseconds: 1), (_) {
                  return selectedMembers;
                }),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      ...allMembers
                          .map((e) => ListTile(
                                leading: e.profilePicture == null
                                    ? CircleAvatar(child: Text(e.firstName[0]))
                                    : CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(e.profilePicture!),
                                      ),
                                title: TextWithFormat(
                                  e.firstName + ' ' + e.lastName,
                                  bold: true,
                                ),
                                onTap: () {
                                  if (selectedMembers.any((element) =>
                                      element.phoneNumber == e.phoneNumber)) {
                                    selectedMembers.remove(e);
                                  } else {
                                    selectedMembers.add(e);
                                  }
                                },
                                trailing: selectedMembers.any((element) =>
                                        element.phoneNumber == e.phoneNumber)
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    : null,
                              ))
                          .toList(),
                    ],
                  );
                }),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () {}, child: Text('Cancel')),
        TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: Text('Submit')),
      ],
    ));
  }

  @override
  void onInit() {
    fetchAllMembers();
    super.onInit();
  }
}
