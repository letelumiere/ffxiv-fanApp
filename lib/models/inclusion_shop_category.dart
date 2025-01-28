class InclusionShopCategory {
  final int id;
  final String name;
  final String classJobCategory;
  final String inclusionShopSeries;

  InclusionShopCategory({
    required this.id,
    required this.name,
    required this.classJobCategory,
    required this.inclusionShopSeries,
  });

  // Factory constructor to create an InclusionShopCategory from a Firestore document
  factory InclusionShopCategory.fromMap(Map<String, dynamic> data) {
    return InclusionShopCategory(
      id: data['key'], // 'key'를 ID로 사용
      name: data['0'] ?? '', // '0' 필드가 Name
      classJobCategory: data['1'] ?? '', // '1' 필드가 ClassJobCategory
      inclusionShopSeries: data['2'] ?? '', // '2' 필드가 InclusionShopSeries
    );
  }

  // Firestore에 저장할 때 데이터를 Map으로 변환
  Map<String, dynamic> toMap() {
    return {
      'key': id,
      '0': name,
      '1': classJobCategory,
      '2': inclusionShopSeries,
    };
  }
}
