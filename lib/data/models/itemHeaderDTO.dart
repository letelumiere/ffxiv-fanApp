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
      name: json['Name'] as String?,
      id: json['Id'] as int?,
      icon: json['Icon'] as String?,
      levelEquip: json['Level{Equip}'] as int?,
      levelItem: json['Level{Item}'] as int?,
    );
  }
  // JSON 직렬화 (to JSON)
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Id': id,
      'Icon': icon,
      'Level{Equip}': levelEquip,
      'Level{Item}': levelItem,
    };
  }

  @override
  String toString() {
    return 'ItemHeaderDTO(name: $name, id: $id, icon: $icon, level{Equip}: $levelEquip, level{Item}: $levelItem)';
  }
}
