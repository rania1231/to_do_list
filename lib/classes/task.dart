import 'package:cloud_firestore/cloud_firestore.dart';

class Tache {
  String? id;
  String title;
  String? description;
  bool completed;
  String categoryId;
  Timestamp createdAt;
// Getters
  String get getId => id ?? ""; // Use null-safe operator for optional id

  String get getTitle => title;

  String? get getDescription => description;

  bool get isCompleted => completed;

  String get getCategoryId => categoryId;

  Timestamp get getCreatedAt => createdAt;



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

  set setCreatedAt(Timestamp value) {
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

  factory Tache.fromFirestore(Map<String, dynamic> data) => Tache(
    title: data['title'],
    description: data['description'] ,
    completed: data['completed'] ,
    categoryId: data['categorie'] ,
    createdAt: data['createdAt'] ,
    id: data['id'] ,
  );






}