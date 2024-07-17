class Item {
  String? documentId;
  int? additionalData;
  int? adjective;
  int? aetherialReduce;
  int? alwaysCollectable;
  int? article;
  List<int>? baseParam;
  String? baseParamModifier;
  List<int>? baseParamValue;
  List<int>? baseParamValueSpecial; // BaseParamValue{Special}
  List<int>? baseParamSpecial; // BaseParam{Special}
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
  int? delayMs; // Delay<ms>
  String? description;
  int? desynth;
  int? dyeCount;
  int? equipRestriction;
  int? equipSlotCategory;
  int? filterGroup;
  int? grandCompany;
  int? id;
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

  Item({
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
    this.delayMs,
    this.description,
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
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      documentId: json['Document ID'] as String?,
      additionalData: json['AdditionalData'] as int?,
      adjective: json['Adjective'] as int?,
      aetherialReduce: json['AetherialReduce'] as int?,
      alwaysCollectable: json['AlwaysCollectable'] as int?,
      article: json['Article'] as int?,
      baseParam: (json['BaseParam'] as List<dynamic>?)?.map((e) => e as int).toList(),
      baseParamModifier: json['BaseParamModifier'] as String?,
      baseParamValue: (json['BaseParamValue'] as List<dynamic>?)?.map((e) => e as int).toList(),
      baseParamValueSpecial: (json['BaseParamValue{Special}'] as List<dynamic>?)?.map((e) => e as int).toList(),
      baseParamSpecial: (json['BaseParam{Special}'] as List<dynamic>?)?.map((e) => e as int).toList(),
      block: json['Block'] as int?,
      blockRate: json['BlockRate'] as int?,
      canBeHq: json['CanBeHq'] as bool?,
      castTimeSec: json['CastTime<s>'] as int?,
      classJobCategory: json['ClassJobCategory'] as int?,
      classJobRepair: json['ClassJob{Repair}'] as int?,
      classJobUse: json['ClassJob{Use}'] as int?,
      cooldownSec: json['Cooldown<s>'] as int?,
      damageMag: json['Damage{Mag}'] as int?,
      damagePhys: json['Damage{Phys}'] as int?,
      defenseMag: json['Defense{Mag}'] as int?,
      defensePhys: json['Defense{Phys}'] as int?,
      delayMs: json['Delay<ms>'] as int?,
      description: json['Description'] as String?,
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
      itemSpecialBonusParam: json['ItemSpecialBonus{Param}'] as int?,
      itemUICategory: json['ItemUICategory'] as int?,
      itemGlamour: json['Item{Glamour}'] as int?,
      itemRepair: json['Item{Repair}'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Document ID': documentId,
      'AdditionalData': additionalData,
      'Adjective': adjective,
      'AetherialReduce': aetherialReduce,
      'AlwaysCollectable': alwaysCollectable,
      'Article': article,
      'BaseParam': baseParam,
      'BaseParamModifier': baseParamModifier,
      'BaseParamValue': baseParamValue,
      'BaseParamValue{Special}': baseParamValueSpecial,
      'BaseParam{Special}': baseParamSpecial,
      'Block': block,
      'BlockRate': blockRate,
      'CanBeHq': canBeHq,
      'CastTime<s>': castTimeSec,
      'ClassJobCategory': classJobCategory,
      'ClassJob{Repair}': classJobRepair,
      'ClassJob{Use}': classJobUse,
      'Cooldown<s>': cooldownSec,
      'Damage{Mag}': damageMag,
      'Damage{Phys}': damagePhys,
      'Defense{Mag}': defenseMag,
      'Defense{Phys}': defensePhys,
      'Delay<ms>': delayMs,
      'Description': description,
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
      'ItemSpecialBonus{Param}': itemSpecialBonusParam,
      'ItemUICategory': itemUICategory,
      'Item{Glamour}': itemGlamour,
      'Item{Repair}': itemRepair,
    };
  }
}
