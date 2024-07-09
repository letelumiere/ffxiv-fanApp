import 'package:ffixv/data/datasources/category_list.dart';
import 'package:ffixv/ui/widgets/item_listTile_container.dart';
import 'package:flutter/material.dart';

class ItemPaginationLayout extends StatefulWidget {
  const ItemPaginationLayout({super.key});
  @override

  State<ItemPaginationLayout> createState() => _ItemPaginationLayoutState();
}

class _ItemPaginationLayoutState extends State<ItemPaginationLayout> {
  final ScrollController _scrollController = ScrollController();
  List<String> items = List.generate(15, (index) => '${index + 1}번쨰 위젯');
  bool isLoading = false;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
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
      itemCount: items.length+1,
      itemBuilder: (context, index){
        if(index<items.length){
          return ItemListTileContainer();
        }else{
          return isLoading ? const CircularProgressIndicator() : const SizedBox();
        }
      },
    );
  }
  void _onScroll(){
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      _loadData();
    }
  }

  Future<void> _loadData() async{
    if(!isLoading){
      setState(() {
        isLoading = true;
      });

      await Future.delayed(Duration(seconds: 4));
      List<String> newItems = List.generate(10, (index) => '새로추가된 ${items.length + index + 1}번쨰 위젯');

      setState(() {
        items.addAll(newItems);
        isLoading = false;
      });
    }
  }
}