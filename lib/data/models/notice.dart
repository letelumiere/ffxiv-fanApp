import 'package:cloud_firestore/cloud_firestore.dart';

class Notice {
  final String? documentId;
  final String? content;
  final DateTime? createdAt; // DateTime으로 수정

  Notice({this.content, this.createdAt, this.documentId});

  // fromJson 메서드
  factory Notice.fromJson(Map<String, dynamic> json, String id) {
    return Notice(
      documentId: id,
      content: json['content'] as String?,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp)
              .toDate() // Timestamp를 DateTime으로 변환
          : null,
    );
  }

  // toJson 메서드
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : null, // DateTime을 Timestamp로 변환
    };
  }
}
