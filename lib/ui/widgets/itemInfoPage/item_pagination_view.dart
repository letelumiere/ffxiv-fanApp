import 'package:flutter/material.dart';
import 'package:ffixv/ui/widgets/itemInfoPage/item_search_condition_layout.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';

class ItemPaginationView extends StatefulWidget {
  final List<ItemHeaderDTO> itemHeaderDtos;
  final void Function(ItemHeaderDTO) onItemSelected; //콜백 추가

  const ItemPaginationView({super.key, required this.itemHeaderDtos, required this.onItemSelected});

  @override
  _ItemPaginationViewState createState() => _ItemPaginationViewState();
}

class _ItemPaginationViewState extends State<ItemPaginationView> {
  static const int _initialLoadCount = 15;
  static const int _pageSize = 10;
  
  final ScrollController _scrollController = ScrollController();
  List<ItemHeaderDTO> _items = [];
  bool _isLoading = false;
  ItemHeaderDTO? _selectedItem; //선택된 아이템을 관리하는 상태


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
            onTap: () => _onItemSelected(_items[index]),
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

  void _onItemSelected(ItemHeaderDTO selectedItem){
    print(selectedItem.id);

    widget.onItemSelected(selectedItem); //부모에게 선택된 아이템 전달
  }
}

class _ItemListTileContainer extends StatelessWidget {
  final int? icon;
  final String? name;
  final int? id;
  final VoidCallback onTap; //onTap콜백 추가

  const _ItemListTileContainer({
    super.key,
    this.icon,
    this.name,
    this.id,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
//      leading: icon != null ? Image.asset("assets/images/$icon.png", width: 40, height: 40) : null,
      leading: icon != null ? Image.asset('assets/icons/BlueMage.png', width: 40, height: 40) : null,  //추후 HQ스왑 기능 추가 
      title: Text(name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('ID: $id'),
      onTap: onTap,
    );
  }
}
