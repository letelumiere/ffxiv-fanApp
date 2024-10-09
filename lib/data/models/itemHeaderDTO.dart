import 'package:cloud_firestore/cloud_firestore.dart';

class ItemHeaderDTO {
  String? name;
  int? itemId;
  String? icon;
  String? itemUICategory; // 추가된 파라미터
  int? levelEquip;
  int? levelItem;
  DocumentSnapshot<Object?>? documentSnapshot;

  // 기본 생성자
  ItemHeaderDTO({
    this.name,
    this.itemId,
    this.icon,
    this.levelEquip,
    this.levelItem,
    this.itemUICategory, // 추가된 파라미터
    this.documentSnapshot,
  });

  // JSON 역직렬화 (from JSON)
  factory ItemHeaderDTO.fromJson(Map<String, dynamic> json, DocumentSnapshot<Object?>? doc) {
    return ItemHeaderDTO(
      name: json['Name'] as String?,
      itemId: json['ID'] as int?,
      icon: json['Icon'] as String?,
      levelEquip: json['Level{Equip}'] as int?,
      levelItem: json['Level{Item}'] as int?,
      itemUICategory: json['ItemUICategory'] as String?, // JSON에서 카테고리 할당
      documentSnapshot: doc,
    );
  }

  // JSON 직렬화 (to JSON)
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'ID': itemId,
      'Icon': icon,
      'Level{Equip}': levelEquip,
      'Level{Item}': levelItem,
      'ItemUICategory': itemUICategory, // 카테고리 포함
    };
  }

  @override
  String toString() {
    return 'ItemHeaderDTO(name: $name, id: $itemId, icon: $icon, levelEquip: $levelEquip, levelItem: $levelItem, itemUICategory: $itemUICategory, documentSnapshot: $documentSnapshot)';
  }
}
