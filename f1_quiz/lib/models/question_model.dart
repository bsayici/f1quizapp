class Question {
  final String id;
  final String title;
  final Map<String, bool> options;
  final String category;

  Question({
    required this.id,
    required this.title,
    required this.options,
    required this.category,
  });

  @override
  String toString() {
    return 'Question(id: $id, title: $title, category: $category)';
  }
}
