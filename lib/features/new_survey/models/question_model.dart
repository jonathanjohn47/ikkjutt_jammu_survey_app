class FreeTextQuestionModel {
  String questionText;
  String? answerText;
  double? latitude;
  double? longitude;

  FreeTextQuestionModel({
    required this.questionText,
    this.answerText,
    this.latitude,
    this.longitude,
  });

  factory FreeTextQuestionModel.fromJson(Map<String, dynamic> json) {
    return FreeTextQuestionModel(
      questionText: json['question_text'],
      answerText: json['answer_text'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_text': questionText,
      'answer_text': answerText,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class TrueFalseQuestionModel {
  String questionText;
  bool? answer;
  double latitude;
  double longitude;

  TrueFalseQuestionModel({
    required this.questionText,
    this.answer,
    required this.latitude,
    required this.longitude,
  });

  factory TrueFalseQuestionModel.fromJson(Map<String, dynamic> json) {
    return TrueFalseQuestionModel(
      questionText: json['question_text'],
      answer: json['answer'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_text': questionText,
      'answer': answer,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class SelectOneOptionQuestion {
  String questionText;
  String? answer;
  double latitude;
  double longitude;
  List<String> options;

  SelectOneOptionQuestion({
    required this.questionText,
    this.answer,
    required this.latitude,
    required this.longitude,
    required this.options,
  });

  factory SelectOneOptionQuestion.fromJson(Map<String, dynamic> json) {
    return SelectOneOptionQuestion(
      questionText: json['question_text'],
      answer: json['answer'],
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      options: List<String>.from(json['options']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_text': questionText,
      'answer': answer,
      'latitude': latitude,
      'longitude': longitude,
      'options': options,
    };
  }
}

class SelectMultipleOptionsQuestion {
  String questionText;
  List<String>? answers;
  double latitude;
  double longitude;
  List<String> options;

  SelectMultipleOptionsQuestion({
    required this.questionText,
    this.answers,
    required this.latitude,
    required this.longitude,
    required this.options,
  });

  factory SelectMultipleOptionsQuestion.fromJson(Map<String, dynamic> json) {
    return SelectMultipleOptionsQuestion(
      questionText: json['question_text'],
      answers: List<String>.from(json['answers']),
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      options: List<String>.from(json['options']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_text': questionText,
      'answers': answers,
      'latitude': latitude,
      'longitude': longitude,
      'options': options,
    };
  }
}

class NumberTypeQuestion {
  String questionText;
  double? answer;
  double latitude;
  double longitude;

  NumberTypeQuestion({
    required this.questionText,
    this.answer,
    required this.latitude,
    required this.longitude,
  });

  factory NumberTypeQuestion.fromJson(Map<String, dynamic> json) {
    return NumberTypeQuestion(
      questionText: json['question_text'],
      answer: double.parse(json['answer'].toString()),
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_text': questionText,
      'answer': answer,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class QuestionModel {
  FreeTextQuestionModel? freeTextQuestionModel;
  TrueFalseQuestionModel? trueFalseQuestionModel;
  SelectOneOptionQuestion? selectOneOptionQuestion;
  SelectMultipleOptionsQuestion? selectMultipleOptionsQuestion;
  NumberTypeQuestion? numberTypeQuestion;

  QuestionModel({
    this.freeTextQuestionModel,
    this.trueFalseQuestionModel,
    this.selectOneOptionQuestion,
    this.selectMultipleOptionsQuestion,
    this.numberTypeQuestion,
  }) : assert(freeTextQuestionModel != null ||
            trueFalseQuestionModel != null ||
            selectOneOptionQuestion != null ||
            selectMultipleOptionsQuestion != null ||
            numberTypeQuestion != null);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      freeTextQuestionModel: json['free_text_question_model'] != null
          ? FreeTextQuestionModel.fromJson(json['free_text_question_model'])
          : null,
      trueFalseQuestionModel: json['true_false_question_model'] != null
          ? TrueFalseQuestionModel.fromJson(json['true_false_question_model'])
          : null,
      selectOneOptionQuestion: json['select_one_option_question'] != null
          ? SelectOneOptionQuestion.fromJson(json['select_one_option_question'])
          : null,
      selectMultipleOptionsQuestion:
          json['select_multiple_options_question'] != null
              ? SelectMultipleOptionsQuestion.fromJson(
                  json['select_multiple_options_question'])
              : null,
      numberTypeQuestion: json['number_type_question'] != null
          ? NumberTypeQuestion.fromJson(json['number_type_question'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'free_text_question_model': freeTextQuestionModel != null
          ? freeTextQuestionModel!.toJson()
          : null,
      'true_false_question_model': trueFalseQuestionModel != null
          ? trueFalseQuestionModel!.toJson()
          : null,
      'select_one_option_question': selectOneOptionQuestion != null
          ? selectOneOptionQuestion!.toJson()
          : null,
      'select_multiple_options_question': selectMultipleOptionsQuestion != null
          ? selectMultipleOptionsQuestion!.toJson()
          : null,
      'number_type_question':
          numberTypeQuestion != null ? numberTypeQuestion!.toJson() : null,
    };
  }

  String get questionText {
    if (freeTextQuestionModel != null) {
      return freeTextQuestionModel!.questionText;
    } else if (trueFalseQuestionModel != null) {
      return trueFalseQuestionModel!.questionText;
    } else if (selectOneOptionQuestion != null) {
      return selectOneOptionQuestion!.questionText;
    } else if (selectMultipleOptionsQuestion != null) {
      return selectMultipleOptionsQuestion!.questionText;
    } else if (numberTypeQuestion != null) {
      return numberTypeQuestion!.questionText;
    } else {
      return "";
    }
  }
}
