class ItemDTO {
  String? documentId; // Firestore Document ID
  int? additionalData;
  int? adjective;
  int? aetherialReduce;
  bool? alwaysCollectable;
  int? article;
  List<int>? baseParam; // 배열
  int? baseParamModifier;
  List<int>? baseParamValue; // 배열
  List<int>? baseParamValueSpecial; // 배열
  List<int>? baseParamSpecial; // 배열
  int? block;
  int? blockRate;
  bool? canBeHq;
  int? castTimeSec; // CastTime<s>
  int? classJobCategory;
  int? classJobRepair; // ClassJob{Repair}
  int? classJobUse; // ClassJob{Use}
  int? cooldownSec; // Cooldown<s>
  int? damageMag; // Damage{Mag}
  int? damagePhys; // Damage{Phys}
  int? defenseMag; // Defense{Mag}
  int? defensePhys; // Defense{Phys}
  String? description; // Description
  int? delayMs; // Delay<ms>
  int? desynth;
  int? dyeCount;
  int? equipRestriction;
  int? equipSlotCategory;
  int? filterGroup;
  int? grandCompany;
  int? id; // ID
  int? icon;
  bool? isAdvancedMeldingPermitted;
  bool? isCollectable;
  bool? isCrestWorthy;
  bool? isGlamourous;
  bool? isIndisposable;
  bool? isPvP;
  bool? isUnique;
  bool? isUntradable;
  int? itemAction;
  int? itemSearchCategory;
  int? itemSeries;
  int? itemSortCategory;
  int? itemSpecialBonus;
  int? itemSpecialBonusParam; // ItemSpecialBonus{Param}
  int? itemUICategory;
  int? itemGlamour; // Item{Glamour}
  int? itemRepair; // Item{Repair}
  int? levelEquip; // Level{Equip}
  int? levelItem; // Level{Item}
  bool? lot;
  int? materiaSlotCount;
  int? materializeType;
  String? modelMain; // Model{Main}
  String? modelSub; // Model{Sub}
  String? name; // Name
  String? plural; // Plural
  int? priceLow; // Price{Low}
  int? possessivePronoun; // PossessivePronoun
  int? priceMid; // Price{Mid}
  int? pronoun; // Pronoun
  int? rarity; // Rarity
  int? requiredPvpRank; // RequiredPvpRank
  String? singular; // Singular
  int? stackSize; // StackSize
  int? startsWithVowel; // StartsWithVowel
  int? subStatCategory; // SubStatCategory

  ItemDTO({
    this.documentId,
    this.additionalData,
    this.adjective,
    this.aetherialReduce,
    this.alwaysCollectable,
    this.article,
    this.baseParam,
    this.baseParamModifier,
    this.baseParamValue,
    this.baseParamValueSpecial,
    this.baseParamSpecial,
    this.block,
    this.blockRate,
    this.canBeHq,
    this.castTimeSec,
    this.classJobCategory,
    this.classJobRepair,
    this.classJobUse,
    this.cooldownSec,
    this.damageMag,
    this.damagePhys,
    this.defenseMag,
    this.defensePhys,
    this.description,
    this.delayMs,
    this.desynth,
    this.dyeCount,
    this.equipRestriction,
    this.equipSlotCategory,
    this.filterGroup,
    this.grandCompany,
    this.id,
    this.icon,
    this.isAdvancedMeldingPermitted,
    this.isCollectable,
    this.isCrestWorthy,
    this.isGlamourous,
    this.isIndisposable,
    this.isPvP,
    this.isUnique,
    this.isUntradable,
    this.itemAction,
    this.itemSearchCategory,
    this.itemSeries,
    this.itemSortCategory,
    this.itemSpecialBonus,
    this.itemSpecialBonusParam,
    this.itemUICategory,
    this.itemGlamour,
    this.itemRepair,
    this.levelEquip,
    this.levelItem,
    this.lot,
    this.materiaSlotCount,
    this.materializeType,
    this.modelMain,
    this.modelSub,
    this.name,
    this.plural,
    this.priceLow,
    this.possessivePronoun,
    this.priceMid,
    this.pronoun,
    this.rarity,
    this.requiredPvpRank,
    this.singular,
    this.stackSize,
    this.startsWithVowel,
    this.subStatCategory,
  });

  // JSON 데이터를 ItemDTO 객체로 변환하는 팩토리 생성자
  factory ItemDTO.fromJson(Map<String, dynamic> json) {
    return ItemDTO(
      documentId: json['DocumentID'] as String?,
      additionalData: json['AdditionalData'] as int?,
      adjective: json['Adjective'] as int?,
      aetherialReduce: json['AetherialReduce'] as int?,
      alwaysCollectable: json['AlwaysCollectable'] as bool?,
      article: json['Article'] as int?,
      baseParam: (json['BaseParam'] as List<dynamic>?)?.map((e) => e as int).toList(),
      baseParamModifier: json['BaseParamModifier'] as int?,
      baseParamValue: (json['BaseParamValue'] as List<dynamic>?)?.map((e) => e as int).toList(),
      baseParamValueSpecial: (json['BaseParamValueSpecial'] as List<dynamic>?)?.map((e) => e as int).toList(),
      baseParamSpecial: (json['BaseParamSpecial'] as List<dynamic>?)?.map((e) => e as int).toList(),
      block: json['Block'] as int?,
      blockRate: json['BlockRate'] as int?,
      canBeHq: json['CanBeHq'] as bool?,
      castTimeSec: json['CastTimeSec'] as int?,
      classJobCategory: json['ClassJobCategory'] as int?,
      classJobRepair: json['ClassJobRepair'] as int?,
      classJobUse: json['ClassJobUse'] as int?,
      cooldownSec: json['CooldownSec'] as int?,
      damageMag: json['DamageMag'] as int?,
      damagePhys: json['DamagePhys'] as int?,
      defenseMag: json['DefenseMag'] as int?,
      defensePhys: json['DefensePhys'] as int?,
      description: json['Description'] as String?,
      delayMs: json['DelayMs'] as int?,
      desynth: json['Desynth'] as int?,
      dyeCount: json['DyeCount'] as int?,
      equipRestriction: json['EquipRestriction'] as int?,
      equipSlotCategory: json['EquipSlotCategory'] as int?,
      filterGroup: json['FilterGroup'] as int?,
      grandCompany: json['GrandCompany'] as int?,
      id: json['ID'] as int?,
      icon: json['Icon'] as int?,
      isAdvancedMeldingPermitted: json['IsAdvancedMeldingPermitted'] as bool?,
      isCollectable: json['IsCollectable'] as bool?,
      isCrestWorthy: json['IsCrestWorthy'] as bool?,
      isGlamourous: json['IsGlamourous'] as bool?,
      isIndisposable: json['IsIndisposable'] as bool?,
      isPvP: json['IsPvP'] as bool?,
      isUnique: json['IsUnique'] as bool?,
      isUntradable: json['IsUntradable'] as bool?,
      itemAction: json['ItemAction'] as int?,
      itemSearchCategory: json['ItemSearchCategory'] as int?,
      itemSeries: json['ItemSeries'] as int?,
      itemSortCategory: json['ItemSortCategory'] as int?,
      itemSpecialBonus: json['ItemSpecialBonus'] as int?,
      itemSpecialBonusParam: json['ItemSpecialBonusParam'] as int?,
      itemUICategory: json['ItemUICategory'] as int?,
      itemGlamour: json['ItemGlamour'] as int?,
      itemRepair: json['ItemRepair'] as int?,
      levelEquip: json['LevelEquip'] as int?,
      levelItem: json['LevelItem'] as int?,
      lot: json['Lot'] as bool?,
      materiaSlotCount: json['MateriaSlotCount'] as int?,
      materializeType: json['MaterializeType'] as int?,
      modelMain: json['ModelMain'] as String?,
      modelSub: json['ModelSub'] as String?,
      name: json['Name'] as String?,
      plural: json['Plural'] as String?,
      priceLow: json['PriceLow'] as int?,
      possessivePronoun: json['PossessivePronoun'] as int?,
      priceMid: json['PriceMid'] as int?,
      pronoun: json['Pronoun'] as int?,
      rarity: json['Rarity'] as int?,
      requiredPvpRank: json['RequiredPvpRank'] as int?,
      singular: json['Singular'] as String?,
      stackSize: json['StackSize'] as int?,
      startsWithVowel: json['StartsWithVowel'] as int?,
      subStatCategory: json['SubStatCategory'] as int?,
    );
  }

  // ItemDTO 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'DocumentID': documentId,
      'AdditionalData': additionalData,
      'Adjective': adjective,
      'AetherialReduce': aetherialReduce,
      'AlwaysCollectable': alwaysCollectable,
      'Article': article,
      'BaseParam': baseParam,
      'BaseParamModifier': baseParamModifier,
      'BaseParamValue': baseParamValue,
      'BaseParamValueSpecial': baseParamValueSpecial,
      'BaseParamSpecial': baseParamSpecial,
      'Block': block,
      'BlockRate': blockRate,
      'CanBeHq': canBeHq,
      'CastTimeSec': castTimeSec,
      'ClassJobCategory': classJobCategory,
      'ClassJobRepair': classJobRepair,
      'ClassJobUse': classJobUse,
      'CooldownSec': cooldownSec,
      'DamageMag': damageMag,
      'DamagePhys': damagePhys,
      'DefenseMag': defenseMag,
      'DefensePhys': defensePhys,
      'Description': description,
      'DelayMs': delayMs,
      'Desynth': desynth,
      'DyeCount': dyeCount,
      'EquipRestriction': equipRestriction,
      'EquipSlotCategory': equipSlotCategory,
      'FilterGroup': filterGroup,
      'GrandCompany': grandCompany,
      'ID': id,
      'Icon': icon,
      'IsAdvancedMeldingPermitted': isAdvancedMeldingPermitted,
      'IsCollectable': isCollectable,
      'IsCrestWorthy': isCrestWorthy,
      'IsGlamourous': isGlamourous,
      'IsIndisposable': isIndisposable,
      'IsPvP': isPvP,
      'IsUnique': isUnique,
      'IsUntradable': isUntradable,
      'ItemAction': itemAction,
      'ItemSearchCategory': itemSearchCategory,
      'ItemSeries': itemSeries,
      'ItemSortCategory': itemSortCategory,
      'ItemSpecialBonus': itemSpecialBonus,
      'ItemSpecialBonusParam': itemSpecialBonusParam,
      'ItemUICategory': itemUICategory,
      'ItemGlamour': itemGlamour,
      'ItemRepair': itemRepair,
      'LevelEquip': levelEquip,
      'LevelItem': levelItem,
      'Lot': lot,
      'MateriaSlotCount': materiaSlotCount,
      'MaterializeType': materializeType,
      'ModelMain': modelMain,
      'ModelSub': modelSub,
      'Name': name,
      'Plural': plural,
      'PriceLow': priceLow,
      'PossessivePronoun': possessivePronoun,
      'PriceMid': priceMid,
      'Pronoun': pronoun,
      'Rarity': rarity,
      'RequiredPvpRank': requiredPvpRank,
      'Singular': singular,
      'StackSize': stackSize,
      'StartsWithVowel': startsWithVowel,
      'SubStatCategory': subStatCategory,
    };
  }
}
