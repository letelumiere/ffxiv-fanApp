import 'package:ffixv/data/models/itemLevel.dart';
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
                levelItem: _currentItems[index].levelItem,
                onTap: () => _onItemSelected(_currentItems[index]),
              );
            },
          ),
        ),
        _buildPaginationControls(),
      ],
    );
  }

  // Pagination controls with limited page buttons (previous 2, current, next 2)
  Widget _buildPaginationControls() {
    int totalPages = (widget.itemHeaderDtos.length / _pageSize).ceil();
    int startPage = (_currentPage - 2).clamp(0, totalPages - 1);
    int endPage = (_currentPage + 2).clamp(0, totalPages - 1);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous button
        if (_currentPage > 0) ElevatedButton(
          onPressed: _goToPreviousPage,
          child: const Text('Previous'),
        ),
        // Page buttons (only show 2 before and 2 after current page)
        ...List.generate(endPage - startPage + 1, (index) {
          int pageIndex = startPage + index;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton(
              onPressed: () => _goToPage(pageIndex),
              style: ElevatedButton.styleFrom(
                backgroundColor: pageIndex == _currentPage ? Colors.blue : Colors.grey, // Highlight current page
              ),
              child: Text('${pageIndex + 1}'),
            ),
          );
        }),
        // Next button
        if (_currentPage < totalPages - 1) ElevatedButton(
          onPressed: _goToNextPage,
          child: const Text('Next'),
        ),
      ],
    );
  }

  // Loads the current page data based on the page number
  void _loadPageData() {
    setState(() {
      final start = _currentPage * _pageSize;
      final end = start + _pageSize;
      _currentItems = widget.itemHeaderDtos.sublist(start, end.clamp(0, widget.itemHeaderDtos.length));
    });
  }

  // Goes to the previous page
  void _goToPreviousPage() {
    setState(() {
      _currentPage--;
      _loadPageData();
    });
  }

  // Goes to the next page
  void _goToNextPage() {
    setState(() {
      _currentPage++;
      _loadPageData();
    });
  }

  // Goes to a specific page
  void _goToPage(int pageIndex) {
    setState(() {
      _currentPage = pageIndex;
      _loadPageData();
    });
  }

  // Callback when an item is selected
  void _onItemSelected(ItemHeaderDTO selectedItem) {
    widget.onItemSelected(selectedItem);
  }
}

class _ItemListTileContainer extends StatelessWidget {
  final String? icon;
  final String? name;
  final int? id;
  final int? levelItem;
  final VoidCallback onTap;

  const _ItemListTileContainer({
    super.key,
    this.icon,
    this.name,
    this.id,
    this.levelItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Image.asset('assets/icons/BlueMage.png', width: 40, height: 40) : null, //storage에 파일 업로드 후 asset 주소 바꿀 것
      title: Text(name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold)),
      //subtitle: Text('ID: $id'),   // 한글어 외국어 병행 시, 이쪽엔 외국어 표기
      //trailing: Text("$levelItem", style: TextStyle(color: Colors.amber)),  //아이템 레벨, 착용 레벨 표시 되도록
      onTap: onTap,
    );
  }
}
