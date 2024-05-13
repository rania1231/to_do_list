class Task {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final String categoryId;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.categoryId,
    required this.createdAt,
  });
}