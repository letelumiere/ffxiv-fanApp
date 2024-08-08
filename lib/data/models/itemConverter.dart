import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';

class ItemConverter {
  // ItemDTO를 ItemHeaderDTO로 변환하는 메서드
  static ItemHeaderDTO convertToItemHeaderDTO(ItemDTO itemDTO) {
    return ItemHeaderDTO(
      id: itemDTO.id ?? 0,
      name: itemDTO.name ?? 'Unknown',
      icon: itemDTO.icon ?? 0,
    );
  }
}
