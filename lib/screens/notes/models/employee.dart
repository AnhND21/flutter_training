// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Employee {
  int id;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;
  final Color? noteBackgroudColor;
  Employee({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.noteBackgroudColor,
  });

  Employee copyWith({
    int? id,
    String? title,
    String? content,
    String? createdAt,
    String? updatedAt,
    Color? noteBackgroudColor,
  }) {
    return Employee(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      noteBackgroudColor: noteBackgroudColor ?? this.noteBackgroudColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'noteBackgroudColor': noteBackgroudColor?.value,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      noteBackgroudColor: map['noteBackgroudColor'] != null
          ? Color(map['noteBackgroudColor'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Employee(id: $id, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, noteBackgroudColor: $noteBackgroudColor)';
  }

  @override
  bool operator ==(covariant Employee other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.noteBackgroudColor == noteBackgroudColor;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        noteBackgroudColor.hashCode;
  }
}
