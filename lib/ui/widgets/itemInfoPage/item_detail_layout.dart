import 'package:ffixv/data/datasources/category_list.dart';
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
  final void Function(String message) callback;

  ItemDetailLayout({required this.itemDto, required this.callback, Key? key}) : super(key: key);

  @override
  State<ItemDetailLayout> createState() => _ItemDetailLayoutState();
}

class _ItemDetailLayoutState extends State<ItemDetailLayout> {
  @override
  Widget build(BuildContext context) {
    final itemDto = widget.itemDto;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemHeader(itemDto: itemDto),
                ItemCategorySection(itemDto: itemDto),
                const SizedBox(height: 10),
                ItemStatsSection(itemDto: itemDto,),
                ItemRequireSection(itemDto: itemDto),
                const SizedBox(height: 10),
//               if (itemDto.baseParamValue0!= null && itemDto.baseParamValue0!.any((value) => value != 0))
                  AdditionalStatsSection(itemDto: itemDto,),
                const SizedBox(height: 10),
                if (itemDto.materiaSlotCount > 0)
                  MateriaSection(itemDto: itemDto),
                const SizedBox(height: 10),
                if (itemDto.classJobRepair != "")
                  RepairSection(itemDto: itemDto),
                const SizedBox(height: 10),
                if (itemDto.description != null && itemDto.description != "No description available")
                  DescriptionSection(itemDto: itemDto),
                const SizedBox(height: 10),
                TradableSection(itemDto: itemDto),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
