import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemInfoViewModel extends ChangeNotifier {
  final ItemService _itemService;

  ItemInfoViewModel(this._itemService);

  List<ItemHeaderDTO> _itemHeaders = [];
  


}