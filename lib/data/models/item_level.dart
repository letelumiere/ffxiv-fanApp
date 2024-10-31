class ItemLevel {
  final int id;
  final Map<String, int> attributes;

  ItemLevel({
    required this.id,
    required this.attributes,
  });

  // Factory constructor to create an ItemLevel from a map (Firestore document)
  factory ItemLevel.fromMap(Map<String, dynamic> data) {
    return ItemLevel(
      id: data['key'],  // Assuming 'key' is the ID
      attributes: {
        'Strength': data['0'] ?? 0,
        'Dexterity': data['1'] ?? 0,
        'Vitality': data['2'] ?? 0,
        'Intelligence': data['3'] ?? 0,
        'Mind': data['4'] ?? 0,
        'Piety': data['5'] ?? 0,
        'HP': data['6'] ?? 0,
        'MP': data['7'] ?? 0,
        'TP': data['8'] ?? 0,
        'GP': data['9'] ?? 0,
        'CP': data['10'] ?? 0,
        // ... add all other attributes as needed
        'PhysicalDamage': data['11'] ?? 0,
        'MagicalDamage': data['12'] ?? 0,
        'Delay': data['13'] ?? 0,
        // Continue with all the remaining attributes
      },
    );
  }

  // Convert the ItemLevel object to a map to store in Firestore
  Map<String, dynamic> toMap() {
    return {
      'key': id,
      '0': attributes['Strength'],
      '1': attributes['Dexterity'],
      '2': attributes['Vitality'],
      '3': attributes['Intelligence'],
      '4': attributes['Mind'],
      '5': attributes['Piety'],
      '6': attributes['HP'],
      '7': attributes['MP'],
      '8': attributes['TP'],
      '9': attributes['GP'],
      '10': attributes['CP'],
      // Continue mapping the remaining attributes
    };
  }
}
