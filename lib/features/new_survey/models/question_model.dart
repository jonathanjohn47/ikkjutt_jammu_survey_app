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
      answer: json['answer'] == null
          ? null
          : double.parse(json['answer'].toString()),
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
  int questionNumber;
  FreeTextQuestionModel? freeTextQuestionModel;
  TrueFalseQuestionModel? trueFalseQuestionModel;
  SelectOneOptionQuestion? selectOneOptionQuestion;
  SelectMultipleOptionsQuestion? selectMultipleOptionsQuestion;
  NumberTypeQuestion? numberTypeQuestion;
  int questionType;

  QuestionModel({
    required this.questionNumber,
    this.freeTextQuestionModel,
    this.trueFalseQuestionModel,
    this.selectOneOptionQuestion,
    this.selectMultipleOptionsQuestion,
    this.numberTypeQuestion,
    required this.questionType,
  }) : assert(freeTextQuestionModel != null ||
            trueFalseQuestionModel != null ||
            selectOneOptionQuestion != null ||
            selectMultipleOptionsQuestion != null ||
            numberTypeQuestion != null);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      questionNumber: json['question_number'],
      freeTextQuestionModel: json['free_text_question_model'] != null
          ? FreeTextQuestionModel.fromJson(
              json['free_text_question_model'] as Map<String, dynamic>)
          : null,
      trueFalseQuestionModel: json['true_false_question_model'] != null
          ? TrueFalseQuestionModel.fromJson(
              json['true_false_question_model'] as Map<String, dynamic>)
          : null,
      selectOneOptionQuestion: json['select_one_option_question'] != null
          ? SelectOneOptionQuestion.fromJson(
              json['select_one_option_question'] as Map<String, dynamic>)
          : null,
      selectMultipleOptionsQuestion: json['select_multiple_options_question'] !=
              null
          ? SelectMultipleOptionsQuestion.fromJson(
              json['select_multiple_options_question'] as Map<String, dynamic>)
          : null,
      numberTypeQuestion: json['number_type_question'] != null
          ? NumberTypeQuestion.fromJson(
              json['number_type_question'] as Map<String, dynamic>)
          : null,
      questionType: json['question_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_number': questionNumber,
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
      'question_type': questionType,
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
    Random random = Random();
    return QuestionModel(
      questionNumber: random.nextInt(100),
      freeTextQuestionModel: FreeTextQuestionModel(
        questionText: "How are you?",
        answerText: "I am good.",
      ),
      questionType: 1,
    );
  }

  factory QuestionModel.emptyTrueFalseQuestion() {
    Random random = Random();

    return QuestionModel(
      questionNumber: random.nextInt(100),
      trueFalseQuestionModel: TrueFalseQuestionModel(
        questionText: "Are you good?",
        answer: true,
      ),
      questionType: 2,
    );
  }

  factory QuestionModel.emptySelectOneOptionQuestion() {
    Random random = Random();
    return QuestionModel(
      questionNumber: random.nextInt(100),
      selectOneOptionQuestion: SelectOneOptionQuestion(
        questionText: "What is your favorite color?",
        answer: "Red",
        options: ["Red", "Green", "Blue"],
      ),
      questionType: 3,
    );
  }

  factory QuestionModel.emptySelectMultipleOptionsQuestion() {
    Random random = Random();
    return QuestionModel(
      questionNumber: random.nextInt(100),
      selectMultipleOptionsQuestion: SelectMultipleOptionsQuestion(
        questionText: "What are your favorite colors?",
        answers: ["Red", "Green", "Blue"],
        options: ["Green", "Blue"],
      ),
      questionType: 4,
    );
  }

  factory QuestionModel.emptyNumberTypeQuestion() {
    Random random = Random();
    return QuestionModel(
      questionNumber: random.nextInt(100),
      numberTypeQuestion: NumberTypeQuestion(
        questionText: "How old are you?",
        answer: 20,
      ),
      questionType: 5,
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
