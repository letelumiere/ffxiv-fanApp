class ItemHeaderDTO {
  String? name;
  int? id;
  String? icon;
  int? levelEquip;
  int? levelItem;

  // 기본 생성자
  ItemHeaderDTO({this.name, this.id, this.icon, this.levelEquip, this.levelItem});
  // JSON 역직렬화 (from JSON)
  factory ItemHeaderDTO.fromJson(Map<String, dynamic> json) {
    return ItemHeaderDTO(
      name: json['name'] as String?,
      id: json['id'] as int?,
      icon: json['icon'] as String?,
      levelEquip: json['level{Equip}'] as int?,
      levelItem: json['level{Item}'] as int?,
    );
  }
  // JSON 직렬화 (to JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'icon': icon,
      'level{Equip}': levelEquip,
      'level{Item}': levelItem,
    };
  }

  @override
  String toString() {
    return 'ItemHeaderDTO(name: $name, id: $id, icon: $icon, level{Equip}: $levelEquip, level{Item}: $levelItem)';
  }
}
