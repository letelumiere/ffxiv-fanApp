import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String? documentId; // documentId 추가
  final int? itemId;
  final String? writer;
  final String? content;
  final DateTime? createdAt;
  final String? type;

  Comment({
    this.documentId, // documentId는 선택적
    required this.itemId,
    required this.writer,
    required this.content,
    this.createdAt,
    this.type,
  });

  // Firebase 문서로부터 Comment 객체 생성
  factory Comment.fromJson(Map<String, dynamic> json, String id) {
    return Comment(
      documentId: id, // Firebase에서 가져온 ID를 설정
      itemId: json['itemId'] as int?,
      writer: json['writer'] as String?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
      type: json['type'] as String?,
    );
  }

  // Comment 객체를 Firebase에 저장할 때 사용
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
