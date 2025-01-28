import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/viewModel/item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:ffxiv/models/item_header_dto.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:provider/provider.dart';

class ItemPaginationView extends StatefulWidget {
  final Function(ItemHeaderDTO) onItemSelected;
  final String uiCategory;
  final String? searchTerm;

  const ItemPaginationView({
    super.key,
    required this.onItemSelected,
    required this.uiCategory,
    this.searchTerm,
  });

  @override
  State<ItemPaginationView> createState() => _ItemPaginationViewState();
}

class _ItemPaginationViewState extends State<ItemPaginationView> {
  late Query<Object?> _query;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<ItemViewModel>(context, listen: false);
    print("itemPagination parameter searchTerm = ${widget.searchTerm}");
    _initializeQuery(
        widget.uiCategory, viewModel.searchTerm); // 초기 카테고리로 쿼리 초기화
  }

  @override
  void didUpdateWidget(covariant ItemPaginationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final viewModel = Provider.of<ItemViewModel>(context, listen: false);

    print("if didUpdated , parameter has printed this");
    print(
        "SearchTerm oldWidget = ${oldWidget.searchTerm} searchTerm viewModel = ${viewModel.searchTerm}");
    print(
        "Category oldWidget = ${widget.uiCategory} category Widget = ${widget.uiCategory}");

    if (oldWidget.uiCategory != widget.uiCategory ||
        oldWidget.searchTerm != viewModel.searchTerm) {
      _initializeQuery(widget.uiCategory, viewModel.searchTerm);
    }
  }

  void _initializeQuery(String category, String? searchTerm) {
    print(
        "Initializing query with category = $category and searchTerm: $searchTerm");

    // 기본 쿼리 설정
    _query = FirebaseFirestore.instance
        .collection('Item')
        .where('ItemUICategory', isEqualTo: category);

    // 검색어가 있을 경우 추가 조건 적용
    if (searchTerm != null && searchTerm.isNotEmpty) {
      _query = _query
          .orderBy('Name') // 검색 대상 필드를 먼저 정렬
          .where('Name', isGreaterThanOrEqualTo: searchTerm) // 검색어가 포함된 이름
          .where('Name',
              isLessThanOrEqualTo: '$searchTerm\uf8ff'); // 검색어로 끝나는 이름
    }

    // 쿼리 초기화 확인
    print("Current query: $_query");
    print("\n");
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ItemViewModel>(context);
    print("=== itemPaginationView Build ===");
    print("${widget.uiCategory}, ${widget.searchTerm}");

    return Column(
      children: [
        // 헤더 추가
        Container(
          color: const Color.fromARGB(255, 70, 70, 70),
          padding: const EdgeInsets.all(8.0),
          child: const Row(
            children: [
              SizedBox(width: 40), // 아이콘 크기와 동일하게 여백을 추가
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 8.0), // 리스트의 아이템 텍스트 위치와 맞추기 위해 패딩 추가
                  child: Text(
                    '아이템 이름',
                    //style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '요구 레벨',
                  textAlign: TextAlign.center,
                  //style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  textAlign: TextAlign.center,
                  '아이템 레벨',
                  //style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FirestorePagination(
            query: _query,
            itemBuilder: (context, snapshot, index) {
              final doc = snapshot[index];
              final data = doc.data() as Map<String, dynamic>;
              final itemHeader = ItemHeaderDTO.fromJson(
                  data, doc); // 'DocumentSnapshot'을 인자로 넘기고 'fromJson' 사용
              print('${itemHeader.name} ${itemHeader.icon} ');

              return FutureBuilder<String?>(
                  future: viewModel.getImageUrl(itemHeader.icon ?? ''),
                  builder: (context, imageSnapshot) {
                    String? imageUrl;

                    if (imageSnapshot.connectionState == ConnectionState.done) {
                      if (imageSnapshot.hasError) {
                        // 에러가 발생한 경우
                        print(
                            "Error getting image URL: ${imageSnapshot.error}");
                        imageUrl = null; // 에러 발생 시 null로 설정
                      } else {
                        imageUrl = imageSnapshot.data; // 정상적으로 로드된 경우
                      }
                    } else if (imageSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      // 여전히 로딩 중일 때는 기본 아이콘을 표시할 수 있습니다.
                      imageUrl = null; // 이 경우 기본 아이콘을 표시하도록 설정
                    }
                    return InkWell(
                      onTap: () {
                        widget.onItemSelected(itemHeader);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 20), // 왼쪽에 공백 추가
                            // 아이템 이름
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  imageUrl != null
                                      ? Image.network(
                                          imageUrl,
                                          width: 40,
                                          height: 40,
                                          errorBuilder: (BuildContext context,
                                              Object error,
                                              StackTrace? stackTrace) {
                                            return const SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(Icons
                                                    .error)); // 오류 발생 시 아이콘 표시
                                          },
                                        ) // 아이콘 표시
                                      : const SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Icon(Icons.error)), // 빈 공간
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      itemHeader.name ?? 'Unknown',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // 요구 레벨
                            Expanded(
                              flex: 1,
                              child: Text(
                                "${itemHeader.levelEquip}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.amber),
                              ),
                            ),
                            // 아이템 레벨
                            Expanded(
                              flex: 1,
                              child: Text(
                                "${itemHeader.levelItem}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.amber),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            viewType: ViewType.list,
            isLive: true,
            onEmpty: Builder(builder: (context) {
              return const Center(child: Text('No items found.'));
            }), // 데이터가 없을 때 처리
          ),
        ),
      ],
    );
  }
}
