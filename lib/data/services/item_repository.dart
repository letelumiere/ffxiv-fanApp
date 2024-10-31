import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffxiv/data/models/itemDTO.dart';
import 'package:ffxiv/data/models/itemHeaderDTO.dart';
import 'package:ffxiv/data/models/itemSearchCriteria.dart';
 
class ItemRepository {
  final CollectionReference _itemsCollection;
  
  ItemRepository(FirebaseFirestore firestore) 
      : _itemsCollection = firestore.collection('Item');

  Future<ItemDTO?> getItemDetail(int itemId) async {
    try {
      QuerySnapshot snapshot = await _itemsCollection.where('ID', isEqualTo: itemId).get();
      print("Query Result: ${snapshot.docs}");

      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data() as Map<String, dynamic>;

      var transformedData = {
        'documentId': data['DocumentID'] ?? '',  // 기본값을 빈 문자열로 설정
        'additionalData': data['AdditionalData'] ?? 0,
        'adjective': data['Adjective'] ?? 0,
        'aetherialReduce': data['AetherialReduce'] ?? 0,
        'alwaysCollectable': data['AlwaysCollectable'] ?? false,
        'article': data['Article'] ?? 0,
        'baseParamModifier': data['BaseParamModifier'] ?? 0,
        'baseParamValue[0]': data['BaseParamValue[0]'] ?? 0,
        'baseParamValue[1]': data['BaseParamValue[1]'] ?? 0,
        'baseParamValue[2]': data['BaseParamValue[2]'] ?? 0,
        'baseParamValue[3]': data['BaseParamValue[3]'] ?? 0,
        'baseParamValue[4]': data['BaseParamValue[4]'] ?? 0,
        'baseParamValue[5]': data['BaseParamValue[5]'] ?? 0,
        'baseParamValue{Special}[0]': data['BaseParamValue{Special}[0]'] ?? 0,
        'baseParamValue{Special}[1]': data['BaseParamValue{Special}[1]'] ?? 0,
        'baseParamValue{Special}[2]': data['BaseParamValue{Special}[2]'] ?? 0,
        'baseParamValue{Special}[3]': data['BaseParamValue{Special}[3]'] ?? 0,
        'baseParamValue{Special}[4]': data['BaseParamValue{Special}[4]'] ?? 0,
        'baseParamValue{Special}[5]': data['BaseParamValue{Special}[5]'] ?? 0,
        'baseParam[0]': data['BaseParam[0]'] ?? '',
        'baseParam[1]': data['BaseParam[1]'] ?? '',
        'baseParam[2]': data['BaseParam[2]'] ?? '',
        'baseParam[3]': data['BaseParam[3]'] ?? '',
        'baseParam[4]': data['BaseParam[4]'] ?? '',
        'baseParam[5]': data['BaseParam[5]'] ?? '',
        'baseParamSpecial[0]': data['BaseParam{Special}[0]'] ?? '',
        'baseParamSpecial[1]': data['BaseParam{Special}[1]'] ?? '',
        'baseParamSpecial[2]': data['BaseParam{Special}[2]'] ?? '',
        'baseParamSpecial[3]': data['BaseParam{Special}[3]'] ?? '',
        'baseParamSpecial[4]': data['BaseParam{Special}[4]'] ?? '',
        'baseParamSpecial[5]': data['BaseParam{Special}[5]'] ?? '',        
        'block': data['Block'] ?? 0,
        'blockRate': data['BlockRate'] ?? 0,
        'canBeHq': data['CanBeHq'] ?? false,
        'castTimeSec': data['CastTimeSec'] ?? 0,
        'classJobCategory': data['ClassJobCategory'] ?? 0,
        'classJobRepair': data['ClassJobRepair'] ?? 0,
        'classJobUse': data['ClassJobUse'] ?? 0,
        'cooldownSec': data['CooldownSec'] ?? 0,
        'damageMag': data['DamageMag'] ?? 0,
        'damagePhys': data['DamagePhys'] ?? 0,
        'defenseMag': data['DefenseMag'] ?? 0,
        'defensePhys': data['DefensePhys'] ?? 0,
        'description': data['Description'] ?? '',
        'delayMs': data['DelayMs'] ?? 0,
        'desynth': data['Desynth'] ?? 0,
        'dyeCount': data['DyeCount'] ?? 0,
        'equipRestriction': data['EquipRestriction'] ?? 0,
        'equipSlotCategory': data['EquipSlotCategory'] ?? 0,
        'filterGroup': data['FilterGroup'] ?? 0,
        'grandCompany': data['GrandCompany'] ?? 0,
        'id': data['ID'] ?? 0,
        'icon': data['Icon'] ?? 0,
        'isAdvancedMeldingPermitted': data['IsAdvancedMeldingPermitted'] ?? false,
        'isCollectable': data['IsCollectable'] ?? false,
        'isCrestWorthy': data['IsCrestWorthy'] ?? false,
        'isGlamourous': data['IsGlamourous'] ?? false,
        'isIndisposable': data['IsIndisposable'] ?? false,
        'isPvP': data['IsPvP'] ?? false,
        'isUnique': data['IsUnique'] ?? false,
        'isUntradable': data['IsUntradable'] ?? false,
        'itemAction': data['ItemAction'] ?? 0,
        'itemSearchCategory': data['ItemSearchCategory'] ?? 0,
        'itemSeries': data['ItemSeries'] ?? 0,
        'itemSortCategory': data['ItemSortCategory'] ?? 0,
        'itemSpecialBonus': data['ItemSpecialBonus'] ?? 0,
        'itemSpecialBonusParam': data['ItemSpecialBonusParam'] ?? 0,
        'itemUICategory': data['ItemUICategory'] ?? 0,
        'itemGlamour': data['ItemGlamour'] ?? 0,
        'itemRepair': data['ItemRepair'] ?? 0,
        'level{Equip}': data['Level{Equip}'] ?? 0,
        'level{Item}': data['Leve{lItem}'] ?? 0,
        'lot': data['Lot'] ?? false,
        'materiaSlotCount': data['MateriaSlotCount'] ?? 0,
        'materializeType': data['MaterializeType'] ?? 0,
        'model{Main}': data['Model{Main}'] ?? '',
        'model{Sub}': data['Model{Sub}'] ?? '',
        'name': data['Name'] ?? '',
        'plural': data['Plural'] ?? '',
        'priceLow': data['PriceLow'] ?? 0,
        'possessivePronoun': data['PossessivePronoun'] ?? 0,
        'priceMid': data['PriceMid'] ?? 0,
        'pronoun': data['Pronoun'] ?? 0,
        'rarity': data['Rarity'] ?? 0,
        'requiredPvpRank': data['RequiredPvpRank'] ?? 0,
        'singular': data['Singular'] ?? '',
        'stackSize': data['StackSize'] ?? 0,
        'startsWithVowel': data['StartsWithVowel'] ?? 0,
        'subStatCategory': data['SubStatCategory'] ?? 0,
      };



      // 변환된 데이터 출력
      print("Transformed Data: $transformedData");

        return ItemDTO.fromJson(data);
      }
      return null;
    } catch (e) {
      _handleError(e);
      return null;
    }
  }

Future<List<ItemHeaderDTO>> getItemHeaders(ItemSearchCriteria criteria, DocumentSnapshot? lastDocument, int limit) async {
  try {
    // 기본 쿼리 설정
    Query query = _itemsCollection.orderBy('Name'); // orderBy를 먼저 호출

    if(criteria.itemUICategory != null){
      query = query.where('ItemUICategory', isEqualTo: criteria.itemUICategory);
    }

    // 검색 조건에 따른 필터 추가
    if (criteria.name != null && criteria.name!.isNotEmpty) {
      query = query.where('Name', isGreaterThanOrEqualTo: criteria.name);
    }

    // 마지막 문서가 있으면 쿼리 설정
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    // 쿼리 실행
    QuerySnapshot snapshot = await query.get();

    // 결과를 ItemHeaderDTO로 변환하여 리스트로 반환
    return snapshot.docs.map((doc) {
      return ItemHeaderDTO.fromJson(doc.data() as Map<String, dynamic>, doc);
    }).toList();
  } catch (e) {
    _handleError(e);
    return [];
  }
}

  Future<List<ItemHeaderDTO>> getItemHeadersNameCategory(String itemName, String itemCategory) async {
    print("Repository's query, 'getItemHeadersNameCategory' parameter = ${itemName} ${itemCategory}");
    try {
      // 기본 쿼리 설정
      Query query = _itemsCollection.orderBy('Name'); // orderBy를 먼저 호출

      if(itemCategory != null && itemCategory.isNotEmpty){
        query = query.where('ItemUICategory', isEqualTo: itemCategory);
      }

      // 검색 조건에 따른 필터 추가
      if (itemName != null && itemName.isNotEmpty) {
//        query.where('Name', isGreaterThanOrEqualTo: itemName)
//            .where('Name', isLessThanOrEqualTo: '$itemName\uf8ff');
          query.where('Name', isEqualTo: itemName);
      }

      // 마지막 문서가 있으면 쿼리 설정
  //    if (lastDocument != null) {
  //      query = query.startAfterDocument(lastDocument);
  //    }

      // 쿼리 실행
      QuerySnapshot snapshot = await query.limit(10).get();

      // 결과를 ItemHeaderDTO로 변환하여 리스트로 반환
      return snapshot.docs.map((doc) {
        return ItemHeaderDTO.fromJson(doc.data() as Map<String, dynamic>, doc);
      }).toList();
    } catch (e) {
      _handleError(e);
      return [];
    }
  }


  Query itemQueryBuilder(ItemSearchCriteria criteria) {  
    Query query = _itemsCollection;

    if (criteria.name != null && criteria.name!.isNotEmpty) {
      query = query
          .where('Name', isGreaterThanOrEqualTo: criteria.name)
          .where('Name', isLessThanOrEqualTo: criteria.name! + '\uf8ff')
          .orderBy('Name');
    }

    if (criteria.classJob != null && criteria.classJob!.isNotEmpty) {
      query = query.where('ClassJob', isEqualTo: criteria.classJob);
    }

    if (criteria.minLevelEquip != null && criteria.maxLevelEquip != null) {
      query = query
          .where('Level{Equip}', isGreaterThanOrEqualTo: criteria.minLevelEquip)
          .where('Level{Equip}', isLessThanOrEqualTo: criteria.maxLevelEquip);
    }

    if (criteria.minLevelItem != null && criteria.maxLevelItem != null) {
      query = query
          .where('Level{Item}', isGreaterThanOrEqualTo: criteria.minLevelItem)
          .where('Level{Item}', isLessThanOrEqualTo: criteria.maxLevelItem);
    }

    return query;
  }

  void _handleError(Object e) {
    print('repository error: $e');
  }
}



