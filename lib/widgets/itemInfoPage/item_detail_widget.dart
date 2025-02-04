import 'package:ffxiv/providers/item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'itemDetailSections/item_header.dart';
import 'itemDetailSections/item_category_section.dart';
import 'itemDetailSections/item_stats_section.dart';
import 'itemDetailSections/item_require_section.dart';
import 'itemDetailSections/additional_stats_section.dart';
import 'itemDetailSections/materia_section.dart';
import 'itemDetailSections/repair_section.dart';
import 'itemDetailSections/description_section.dart';
import 'itemDetailSections/tradable_section.dart';
import 'package:ffxiv/data/models/item_dto.dart';

class ItemDetailLayout extends StatefulWidget {
  final ItemDTO itemDto;
  final void Function(String message) callback;

  const ItemDetailLayout(
      {required this.itemDto, required this.callback, super.key});

  @override
  State<ItemDetailLayout> createState() => _ItemDetailLayoutState();
}

class _ItemDetailLayoutState extends State<ItemDetailLayout> {
  late Future<String?> imageUrlFuture;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<ItemViewModel>(context, listen: false);
    imageUrlFuture = viewModel.getImageUrl(widget.itemDto.icon);
  }

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
                ItemHeader(itemDto: itemDto, itemImage: imageUrlFuture),
                ItemCategorySection(itemDto: itemDto),
                const SizedBox(height: 10),
                ItemStatsSection(
                  itemDto: itemDto,
                ),
                ItemRequireSection(itemDto: itemDto),
                const SizedBox(height: 10),
//               if (itemDto.baseParamValue0!= null && itemDto.baseParamValue0!.any((value) => value != 0))
                AdditionalStatsSection(
                  itemDto: itemDto,
                ),
                const SizedBox(height: 10),
                if (itemDto.materiaSlotCount > 0)
                  MateriaSection(itemDto: itemDto),
                const SizedBox(height: 10),
                if (itemDto.classJobRepair != "")
                  RepairSection(itemDto: itemDto),
                const SizedBox(height: 10),
                if (itemDto.description != null &&
                    itemDto.description != "No description available")
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
