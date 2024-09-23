import 'package:flutter/material.dart';
import 'item_header.dart';
import 'item_category_section.dart';
import 'item_stats_section.dart';
import 'item_require_section.dart';
import 'additional_stats_section.dart';
import 'materia_section.dart';
import 'repair_section.dart';
import 'description_section.dart';
import 'tradable_section.dart';
import 'package:ffixv/data/models/itemDTO.dart';

class ItemDetailLayout extends StatefulWidget {
  final ItemDTO itemDto;
  final Map<String, dynamic> xivStringMap;
  final void Function(String message) callback;

  ItemDetailLayout({required this.itemDto, required this.xivStringMap, required this.callback, Key? key}) : super(key: key);

  @override
  State<ItemDetailLayout> createState() => _ItemDetailLayoutState();
}

class _ItemDetailLayoutState extends State<ItemDetailLayout> {
  @override
  Widget build(BuildContext context) {
    // 필요한 데이터 초기화 및 가공
    final itemDto = widget.itemDto;
    final Map<String, dynamic> xivStringMap = widget.xivStringMap;

    print(xivStringMap);
    print(xivStringMap["itemUICategory"]);


    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemHeader(name: itemDto.name ?? 'N/A'),
                ItemCategorySection(
                  itemUICategory: xivStringMap["itemUICategory"] ?? "",
                  isUnique: itemDto.isUnique ?? false,
                  isUntradable: itemDto.isUntradable ?? false, 
                  xivString: '',
                ),
                const SizedBox(height: 10),
                ItemStatsSection(baseParamList: itemDto.baseParam),
                ItemRequireSection(
                  levelItem: itemDto.levelItem ?? 0,
                  levelEquip: itemDto.levelEquip ?? 0,
                  requireJob: itemDto.classJobCategory ?? 0, 
                  xivString: xivStringMap["classJob"] ?? "",
                ),
                const SizedBox(height: 10),
                if (itemDto.baseParamValue != null && itemDto.baseParamValue!.any((value) => value != 0))
                  AdditionalStatsSection(baseParamValueList: itemDto.baseParamValue),
                const SizedBox(height: 10),
                if (itemDto.materiaSlotCount! > 0)
                  MateriaSection(materiaSlotCount: itemDto.materiaSlotCount ?? 0),
                const SizedBox(height: 10),
                if (itemDto.classJobRepair != 0)
                  RepairSection(
                    classJobRepair: itemDto.classJobRepair ?? 0,
                    boolsMap: {
                      "IsDesynthesizable": itemDto.desynth,
                      "IsDyeable": itemDto.dyeCount,
                    },
                    materializeType: itemDto.materializeType!,
                    levelEquip: itemDto.levelEquip!,
                  ),
                const SizedBox(height: 10),
                if (itemDto.description != null && itemDto.description != "No description available")
                  DescriptionSection(description: itemDto.description!),
                const SizedBox(height: 10),
                TradableSection(
                  priceLow: itemDto.priceLow! ?? 0,
                  isUntradable: itemDto.isUntradable ?? false,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
