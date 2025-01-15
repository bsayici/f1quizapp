import 'package:http/http.dart' as http;
import './question_model.dart';
import 'dart:convert';

class DBconnect {
  final url = Uri.parse(
      'https://f1quiz-2db4e-default-rtdb.europe-west1.firebasedatabase.app/questions.json');

  Future<List<Question>> fetchQuestions({String? category}) async {
    return http.get(url).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = Question(
          id: key,
          title: value['title'],
          options: Map.castFrom(value['options']),
          category: value['category'] ??
              'general',
        );

        if (category == null || newQuestion.category == category) {
          newQuestions.add(newQuestion);
        }
      });
      return newQuestions;
    });
  }

  Future<List<String>> fetchCategories() async {
    return http.get(url).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      Set<String> categories = {};

      data.forEach((key, value) {
        categories.add(value['category'] ?? 'general');
      });

      return categories.toList()..sort();
    });
  }

  Future<void> addQuestion(
      String title, Map<String, bool> options, String category) async {
    final questionData = {
      'title': title,
      'options': options,
      'category': category,
    };

    http.post(url, body: json.encode(questionData));
  }
}
