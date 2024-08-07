import 'package:flutter/material.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';

class ItemPaginationView extends StatefulWidget {
  final List<ItemHeaderDTO> itemHeaderDtos;

  const ItemPaginationView({super.key, required this.itemHeaderDtos});

  @override
  State<ItemPaginationView> createState() => _ItemPaginationViewState();
}

class _ItemPaginationViewState extends State<ItemPaginationView> {
  final ScrollController _scrollController = ScrollController();
  List<ItemHeaderDTO> items = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    items = widget.itemHeaderDtos.take(15).toList(); // 초기 아이템 로드
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      controller: _scrollController,
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index < items.length) {
          final item = items[index];
          return _ItemListTileContainer(
            icon: item.icon,
            name: item.name,
            id: item.id,
          );
        } else {
          return isLoading ? const CircularProgressIndicator() : const SizedBox();
        }
      },
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      final newItems = widget.itemHeaderDtos.skip(items.length).take(10).toList();

      setState(() {
        items.addAll(newItems);
        isLoading = false;
      });
    }
  }
}

class _ItemListTileContainer extends StatelessWidget {
  final int? icon;
  final String? name;
  final int? id;

  const _ItemListTileContainer({
    super.key,
    required this.icon,
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Uncomment and provide the correct path to your image assets
        // Image.asset("assets/images/$icon.png", width: 40, height: 40),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text('ID: $id'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
