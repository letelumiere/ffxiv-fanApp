import 'package:flutter/material.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';

class ItemPaginationView extends StatefulWidget {
  final List<ItemHeaderDTO> itemHeaderDtos;

  const ItemPaginationView({Key? key, required this.itemHeaderDtos}) : super(key: key);

  @override
  _ItemPaginationViewState createState() => _ItemPaginationViewState();
}

class _ItemPaginationViewState extends State<ItemPaginationView> {
  static const int _initialLoadCount = 15;
  static const int _pageSize = 10;
  
  final ScrollController _scrollController = ScrollController();
  List<ItemHeaderDTO> _items = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _items.length + (_isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < _items.length) {
          return _ItemListTileContainer(
            icon: _items[index].icon,
            name: _items[index].name,
            id: _items[index].id,
          );
        } else {
          return Center(child: const CircularProgressIndicator());
        }
      },
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _items = widget.itemHeaderDtos.take(_initialLoadCount).toList();
    });
  }

  Future<void> _loadMoreData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    final newItems = widget.itemHeaderDtos
        .skip(_items.length)
        .take(_pageSize)
        .toList();

    setState(() {
      _items.addAll(newItems);
      _isLoading = false;
    });
  }
}

class _ItemListTileContainer extends StatelessWidget {
  final int? icon;
  final String? name;
  final int? id;

  const _ItemListTileContainer({
    super.key,
    this.icon,
    this.name,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Image.asset("assets/images/$icon.png", width: 40, height: 40) : null,
      title: Text(name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('ID: $id'),
    );
  }
}
