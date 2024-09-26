import 'package:ffixv/data/models/itemDTO.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';
import 'package:ffixv/data/models/itemSearchCriteria.dart';
import 'package:ffixv/data/services/item_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemViewModel extends ChangeNotifier {    //페이지의 상태 변경에 관여
  final ItemService _itemService;

  ItemViewModel(this._itemService);

  List<ItemHeaderDTO> _itemHeaders = [];
  ItemDTO? _itemDto;
  ItemSearchCriteria? criteria;
  int? page;
  int? limit;

  Future<void> fetchItemDetail() async {}

  Future<void> fetchItemHeaders(criteria, page, limit) async {

  }
}