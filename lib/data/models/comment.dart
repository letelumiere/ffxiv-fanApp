import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final int? itemNo;
  final String? writer;
  final String? content;
  final DateTime? createdAt;
  final String? type;

  Comment({
    required this.itemNo,
    required this.writer,
    required this.content,
    this.createdAt,
    this.type,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      itemNo: json['itemNo'] as int?,
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
      'itemNo': itemNo,
      'writer': writer,
      'content': content,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'type': type,
    };
  }
}
