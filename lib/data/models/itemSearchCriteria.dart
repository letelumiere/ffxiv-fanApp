class ItemSearchCriteria {
  String? name;
  String? classJob;
  String? equipSlot;
  String? itemCategory;
  int? minLevelEquip;
  int? maxLevelEquip;
  int? minLevelItem;
  int? maxLevelItem;

  // 생성자
  ItemSearchCriteria({
    this.name, 
    this.classJob, 
    this.equipSlot, 
    this.itemCategory, 
    this.minLevelEquip, 
    this.maxLevelEquip, 
    this.minLevelItem, 
    this.maxLevelItem
  });

  // JSON 변환용 fromJson
  factory ItemSearchCriteria.fromJson(Map<String, dynamic> json) {
    return ItemSearchCriteria(
      name: json['Name'] as String?,
      classJob: json['ClassJob'] as String?,
      equipSlot: json['EquipSlot'] as String?,
      itemCategory: json['ItemCategory'] as String?,
      minLevelEquip: json['InLevelEquip'] as int?,
      maxLevelEquip: json['MaxLevelEquip'] as int?,
      minLevelItem: json['MinLevelItem'] as int?,
      maxLevelItem: json['MaxLevelItem'] as int?,
    );
  }

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'ClassJob': classJob,
      'EquipSlot': equipSlot,
      'ItemCategory': itemCategory,
      'MinLevelEquip': minLevelEquip,
      'MaxLevelEquip': maxLevelEquip,
      'MinLevelItem': minLevelItem,
      'MaxLevelItem': maxLevelItem,
    };
  }

  // copyWith 메서드 (불변 객체 지원)
  ItemSearchCriteria copyWith({
    String? name,
    String? classJob,
    String? equipSlot,
    String? itemCategory,
    int? minLevelEquip,
    int? maxLevelEquip,
    int? minLevelItem,
    int? maxLevelItem,
  }) {
    return ItemSearchCriteria(
      name: name ?? this.name,
      classJob: classJob ?? this.classJob,
      equipSlot: equipSlot ?? this.equipSlot,
      itemCategory: itemCategory ?? this.itemCategory,
      minLevelEquip: minLevelEquip ?? this.minLevelEquip,
      maxLevelEquip: maxLevelEquip ?? this.maxLevelEquip,
      minLevelItem: minLevelItem ?? this.minLevelItem,
      maxLevelItem: maxLevelItem ?? this.maxLevelItem,
    );
  }
}
