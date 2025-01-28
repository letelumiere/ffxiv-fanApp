class ItemUICategory {
  final int key;
  final String xivString;
  final String icon;
  final int orderMinor;
  final int orderMajor;

  ItemUICategory({
    required this.key,
    required this.xivString,
    required this.icon,
    required this.orderMinor,
    required this.orderMajor,
  });

  // Factory method to create an instance from JSON (Firebase data)
  factory ItemUICategory.fromJson(Map<String, dynamic> json) {
    return ItemUICategory(
      key: json['key'] as int,
      xivString: json['xivString'] as String,
      icon: json['icon'] as String,
      orderMinor: json['order{Minor}'] as int,
      orderMajor: json['order{Major}'] as int,
    );
  }

  // Method to convert an instance to JSON format (for Firebase)
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'xivString': xivString,
      'icon': icon,
      'order{Minor}': orderMinor,
      'order{Major}': orderMajor,
    };
  }
}
