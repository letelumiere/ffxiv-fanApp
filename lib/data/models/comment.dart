import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final int? itemId;
  final String? writer;
  final String? content;
  final DateTime? createdAt;
  final String? type;

  Comment({
    required this.itemId,
    required this.writer,
    required this.content,
    this.createdAt,
    this.type,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      itemId: json['itemId'] as int?,
      writer: json['writer'] as String?,
      content: json['content'] as String?,
      createdAt: ['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'writer': writer,
      'content': content,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'type': type,
    };
  }
}
