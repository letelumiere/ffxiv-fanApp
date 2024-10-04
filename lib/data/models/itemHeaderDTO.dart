import 'package:cloud_firestore/cloud_firestore.dart';

class ItemHeaderDTO {
  String? name;
  int? id;
  String? icon;
  int? levelEquip;
  int? levelItem;
  DocumentSnapshot<Object?>? documentSnapshot; // DocumentSnapshot의 타입을 수정

  // 기본 생성자
  ItemHeaderDTO({
    this.name,
    this.id,
    this.icon,
    this.levelEquip,
    this.levelItem,
    this.documentSnapshot,
  });

  // JSON 역직렬화 (from JSON)
  factory ItemHeaderDTO.fromJson(Map<String, dynamic> json, DocumentSnapshot<Object?>? doc) {
    return ItemHeaderDTO(
      name: json['Name'] as String?,
      id: json['ID'] as int?,
      icon: json['Icon'] as String?,
      levelEquip: json['Level{Equip}'] as int?,
      levelItem: json['Level{Item}'] as int?,
      documentSnapshot: doc, // DocumentSnapshot 할당
    );
  }

  // JSON 직렬화 (to JSON)
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'ID': id,
      'Icon': icon,
      'Level{Equip}': levelEquip,
      'Level{Item}': levelItem,
    };
  }

  @override
  String toString() {
    return 'ItemHeaderDTO(name: $name, id: $id, icon: $icon, levelEquip: $levelEquip, levelItem: $levelItem, documentSnapshot: $documentSnapshot)';
  }
}
