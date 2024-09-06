class ItemUICategory {
  final int id;
  final String name;
  final String iconPath;
  final int orderMinor;
  final int orderMajor;

  ItemUICategory({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.orderMinor,
    required this.orderMajor,
  });

  // Factory constructor to create an ItemUICategory from a Firestore document
  factory ItemUICategory.fromMap(Map<String, dynamic> data) {
    return ItemUICategory(
      id: data['key'],  // 'key'를 ID로 사용
      name: data['0'] ?? '',  // '0' 필드가 Name
      iconPath: data['1'] ?? '',  // '1' 필드가 Icon Path
      orderMinor: data['2'] ?? 0,  // '2' 필드가 Order{Minor}
      orderMajor: data['3'] ?? 0,  // '3' 필드가 Order{Major}
    );
  }

  // Firestore에 저장할 때 데이터를 Map으로 변환
  Map<String, dynamic> toMap() {
    return {
      'key': id,
      '0': name,
      '1': iconPath,
      '2': orderMinor,
      '3': orderMajor,
    };
  }
}
