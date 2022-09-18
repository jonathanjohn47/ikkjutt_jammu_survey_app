import 'dart:math';

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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_text': questionText,
      'answer_text': answerText,
    };
  }
}

class TrueFalseQuestionModel {
  String questionText;
  bool? answer;

  TrueFalseQuestionModel({
    required this.questionText,
    this.answer,
  });

  factory TrueFalseQuestionModel.fromJson(Map<String, dynamic> json) {
    return TrueFalseQuestionModel(
      questionText: json['question_text'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_text': questionText,
      'answer': answer,
    };
  }
}

class SelectOneOptionQuestion {
  String questionText;
  String? answer;

  List<String> options;

  SelectOneOptionQuestion({
    required this.questionText,
    this.answer,
    required this.options,
  });

  factory SelectOneOptionQuestion.fromJson(Map<String, dynamic> json) {
    return SelectOneOptionQuestion(
      questionText: json['question_text'],
      answer: json['answer'],
      options: List<String>.from(json['options']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_text': questionText,
      'answer': answer,
      'options': options,
    };
  }
}

class SelectMultipleOptionsQuestion {
  String questionText;
  List<String>? answers;

  List<String> options;

  SelectMultipleOptionsQuestion({
    required this.questionText,
    this.answers,
    required this.options,
  });

  factory SelectMultipleOptionsQuestion.fromJson(Map<String, dynamic> json) {
    return SelectMultipleOptionsQuestion(
      questionText: json['question_text'],
      answers: List<String>.from(json['answers']),
      options: List<String>.from(json['options']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_text': questionText,
      'answers': answers,
      'options': options,
    };
  }
}

class NumberTypeQuestion {
  String questionText;
  double? answer;

  NumberTypeQuestion({
    required this.questionText,
    this.answer,
  });

  factory NumberTypeQuestion.fromJson(Map<String, dynamic> json) {
    return NumberTypeQuestion(
      questionText: json['question_text'],
      answer: double.parse(json['answer'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_text': questionText,
      'answer': answer,
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

  String get answerText {
    if (freeTextQuestionModel != null) {
      return freeTextQuestionModel!.answerText!;
    } else if (trueFalseQuestionModel != null) {
      return trueFalseQuestionModel!.answer.toString();
    } else if (selectOneOptionQuestion != null) {
      return selectOneOptionQuestion!.answer.toString();
    } else if (selectMultipleOptionsQuestion != null) {
      return selectMultipleOptionsQuestion!.answers!.join(", ");
    } else if (numberTypeQuestion != null) {
      return numberTypeQuestion!.answer.toString();
    } else {
      return "";
    }
  }

  factory QuestionModel.emptyFreeTextQuestion() {
    return QuestionModel(
      freeTextQuestionModel: FreeTextQuestionModel(
        questionText: "How are you?",
        answerText: "I am good.",
      ),
    );
  }

  factory QuestionModel.emptyTrueFalseQuestion() {
    return QuestionModel(
      trueFalseQuestionModel: TrueFalseQuestionModel(
        questionText: "Are you good?",
        answer: true,
      ),
    );
  }

  factory QuestionModel.emptySelectOneOptionQuestion() {
    return QuestionModel(
      selectOneOptionQuestion: SelectOneOptionQuestion(
        questionText: "What is your favorite color?",
        answer: "Red",
        options: ["Red", "Green", "Blue"],
      ),
    );
  }

  factory QuestionModel.emptySelectMultipleOptionsQuestion() {
    return QuestionModel(
      selectMultipleOptionsQuestion: SelectMultipleOptionsQuestion(
        questionText: "What are your favorite colors?",
        answers: ["Red", "Green", "Blue"],
        options: ["Red", "Green", "Blue"],
      ),
    );
  }

  factory QuestionModel.emptyNumberTypeQuestion() {
    return QuestionModel(
      numberTypeQuestion: NumberTypeQuestion(
        questionText: "How old are you?",
        answer: 20,
      ),
    );
  }

  factory QuestionModel.empty() {
    Random random = Random();
    int randomNumber = random.nextInt(5);
    switch (randomNumber) {
      case 0:
        return QuestionModel.emptyFreeTextQuestion();
      case 1:
        return QuestionModel.emptyTrueFalseQuestion();
      case 2:
        return QuestionModel.emptySelectOneOptionQuestion();
      case 3:
        return QuestionModel.emptySelectMultipleOptionsQuestion();
      case 4:
        return QuestionModel.emptyNumberTypeQuestion();
      default:
        return QuestionModel.emptyFreeTextQuestion();
    }
  }
}
