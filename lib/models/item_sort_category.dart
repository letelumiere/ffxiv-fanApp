class ItemSortCategory {
  final int id;
  final int sortValue;

  ItemSortCategory({
    required this.id,
    required this.sortValue,
  });

  // Factory constructor to create an ItemSortCategory from a Firestore document
  factory ItemSortCategory.fromMap(Map<String, dynamic> data) {
    return ItemSortCategory(
      id: data['key'],  // 'key'를 ID로 사용
      sortValue: data['0'],  // '0' 필드가 sort 값
    );
  }

  // Firestore에 저장할 때 데이터를 Map으로 변환
  Map<String, dynamic> toMap() {
    return {
      'key': id,
      '0': sortValue,
    };
  }
}
