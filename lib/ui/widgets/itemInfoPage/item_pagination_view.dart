import 'package:flutter/material.dart';
import 'package:ffixv/data/models/itemHeaderDTO.dart';

class ItemPaginationView extends StatefulWidget {
  final List<ItemHeaderDTO> itemHeaderDtos;
  final void Function(ItemHeaderDTO) onItemSelected; // Callback

  const ItemPaginationView({super.key, required this.itemHeaderDtos, required this.onItemSelected});

  @override
  _ItemPaginationViewState createState() => _ItemPaginationViewState();
}

class _ItemPaginationViewState extends State<ItemPaginationView> {
  static const int _pageSize = 10;
  
  int _currentPage = 0;
  List<ItemHeaderDTO> _currentItems = [];
  ItemHeaderDTO? _selectedItem;

  @override
  void initState() {
    super.initState();
    _loadPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _currentItems.length,
            itemBuilder: (context, index) {
              return _ItemListTileContainer(
                icon: _currentItems[index].icon,
                name: _currentItems[index].name,
                id: _currentItems[index].id,
                onTap: () => _onItemSelected(_currentItems[index]),
              );
            },
          ),
        ),
        _buildPaginationControls(),
      ],
    );
  }

  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: _currentPage > 0 ? _goToPreviousPage : null,
          child: const Text('Previous'),
        ),
        Text('Page ${_currentPage + 1}'),
        ElevatedButton(
          onPressed: (_currentPage + 1) * _pageSize < widget.itemHeaderDtos.length ? _goToNextPage : null,
          child: const Text('Next'),
        ),
      ],
    );
  }

  void _loadPageData() {
    setState(() {
      final start = _currentPage * _pageSize;
      final end = start + _pageSize;
      _currentItems = widget.itemHeaderDtos.sublist(start, end.clamp(0, widget.itemHeaderDtos.length));
    });
  }

  void _goToPreviousPage() {
    setState(() {
      _currentPage--;
      _loadPageData();
    });
  }

  void _goToNextPage() {
    setState(() {
      _currentPage++;
      _loadPageData();
    });
  }

  void _onItemSelected(ItemHeaderDTO selectedItem) {
    widget.onItemSelected(selectedItem);
  }
}

class _ItemListTileContainer extends StatelessWidget {
  final int? icon;
  final String? name;
  final int? id;
  final VoidCallback onTap;

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
      leading: icon != null ? Image.asset('assets/icons/BlueMage.png', width: 40, height: 40) : null, 
      title: Text(name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('ID: $id'),
      onTap: onTap,
    );
  }
}
