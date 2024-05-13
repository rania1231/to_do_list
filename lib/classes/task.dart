class Tache {
  String? id;
  String title;
  String? description;
  bool completed;
  String categoryId;
  DateTime createdAt;
// Getters
  String get getId => id ?? ""; // Use null-safe operator for optional id

  String get getTitle => title;

  String? get getDescription => description;

  bool get isCompleted => completed;

  String get getCategoryId => categoryId;

  DateTime get getCreatedAt => createdAt;



  // Setters
  void setId(String value) {
    id = value;
  }

  set setTitle(String value) {
    title = value;
  }

  set setDescription(String value) {
    description = value;
  }

  set setCompleted(bool value) {
    completed = value;
  }

  set setCategoryId(String value) {
    categoryId = value;
  }

  set setCreatedAt(DateTime value) {
    createdAt = value;
  }
  Tache({
    this.id,
    required this.title,
    this.description,
    required this.completed,
    required this.categoryId,
    required this.createdAt,
  });








}