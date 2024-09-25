class ItemDTO {
  final String? documentId;
  final String? additionalData;
  final int adjective;
  final int aetherialReduce;
  final bool alwaysCollectable;
  final int article;
  final int baseParamModifier;
  final int baseParamValue0;
  final int baseParamValue1;
  final int baseParamValue2;
  final int baseParamValue3;
  final int baseParamValue4;
  final int baseParamValue5;
  final int baseParamValueSpecial0;
  final int baseParamValueSpecial1;
  final int baseParamValueSpecial2;
  final int baseParamValueSpecial3;
  final int baseParamValueSpecial4;
  final int baseParamValueSpecial5;
  final String? baseParam0;
  final String? baseParam1;
  final String? baseParam2;
  final String? baseParam3;
  final String? baseParam4;
  final String? baseParam5;
  final String? baseParamSpecial0;
  final String? baseParamSpecial1;
  final String? baseParamSpecial2;
  final String? baseParamSpecial3;
  final String? baseParamSpecial4;
  final String? baseParamSpecial5;
  final int block;
  final int blockRate;
  final bool canBeHq;
  final int castTime;
  final String classJobCategory;
  final String classJobRepair;
  final String classJobUse;
  final int cooldown;
  final int damageMag;
  final int damagePhys;
  final int defenseMag;
  final int defensePhys;
  final int delayMs;
  final String? description;
  final int desynth;
  final bool dyeCount;
  final int equipRestriction;
  final String equipSlotCategory;
  final int filterGroup;
  final String grandCompany;
  final int id;
  final String icon;
  final bool isAdvancedMeldingPermitted;
  final bool isCollectable;
  final bool isCrestWorthy;
  final bool isGlamourous;
  final bool isIndisposable;
  final bool isPvP;
  final bool isUnique;
  final bool isUntradable;
  final String itemAction;
  final String itemSearchCategory;
  final String? itemSeries;
  final int itemSortCategory;
  final String? itemSpecialBonus;
  final int itemSpecialBonusParam;
  final String itemUICategory;
  final String itemGlamour;
  final String itemRepair;
  final int levelEquip;
  final int levelItem;
  final bool lot;
  final int materiaSlotCount;
  final int materializeType;
  final String modelMain;
  final String modelSub;
  final String name;
  final String? plural;
  final int possessivePronoun;
  final int priceLow;
  final int priceMid;
  final int pronoun;
  final int rarity;
  final int requiredPvpRank;
  final int sbyte;
  final String singular;
  final int stackSize;
  final int startsWithVowel;
  final int subStatCategory;
  final int uint16;
  final int empty;
  final int empty1;

  // 생성자
  ItemDTO({
    this.documentId,
    this.additionalData,
    required this.adjective,
    required this.aetherialReduce,
    required this.alwaysCollectable,
    required this.article,
    required this.baseParamModifier,
    required this.baseParamValue0,
    required this.baseParamValue1,
    required this.baseParamValue2,
    required this.baseParamValue3,
    required this.baseParamValue4,
    required this.baseParamValue5,
    required this.baseParamValueSpecial0,
    required this.baseParamValueSpecial1,
    required this.baseParamValueSpecial2,
    required this.baseParamValueSpecial3,
    required this.baseParamValueSpecial4,
    required this.baseParamValueSpecial5,
    this.baseParam0,
    this.baseParam1,
    this.baseParam2,
    this.baseParam3,
    this.baseParam4,
    this.baseParam5,
    this.baseParamSpecial0,
    this.baseParamSpecial1,
    this.baseParamSpecial2,
    this.baseParamSpecial3,
    this.baseParamSpecial4,
    this.baseParamSpecial5,
    required this.block,
    required this.blockRate,
    required this.canBeHq,
    required this.castTime,
    required this.classJobCategory,
    required this.classJobRepair,
    required this.classJobUse,
    required this.cooldown,
    required this.damageMag,
    required this.damagePhys,
    required this.defenseMag,
    required this.defensePhys,
    required this.delayMs,
    this.description,
    required this.desynth,
    required this.dyeCount,
    required this.equipRestriction,
    required this.equipSlotCategory,
    required this.filterGroup,
    required this.grandCompany,
    required this.id,
    required this.icon,
    required this.isAdvancedMeldingPermitted,
    required this.isCollectable,
    required this.isCrestWorthy,
    required this.isGlamourous,
    required this.isIndisposable,
    required this.isPvP,
    required this.isUnique,
    required this.isUntradable,
    required this.itemAction,
    required this.itemSearchCategory,
    this.itemSeries,
    required this.itemSortCategory,
    this.itemSpecialBonus,
    required this.itemSpecialBonusParam,
    required this.itemUICategory,
    required this.itemGlamour,
    required this.itemRepair,
    required this.levelEquip,
    required this.levelItem,
    required this.lot,
    required this.materiaSlotCount,
    required this.materializeType,
    required this.modelMain,
    required this.modelSub,
    required this.name,
    this.plural,
    required this.possessivePronoun,
    required this.priceLow,
    required this.priceMid,
    required this.pronoun,
    required this.rarity,
    required this.requiredPvpRank,
    required this.sbyte,
    required this.singular,
    required this.stackSize,
    required this.startsWithVowel,
    required this.subStatCategory,
    required this.uint16,
    required this.empty,
    required this.empty1,
  });

  // fromJson 메서드
  factory ItemDTO.fromJson(Map<String, dynamic> json) {
    return ItemDTO(
      documentId: json['_id'],
      additionalData: json['AdditionalData'],
      adjective: json['Adjective'],
      aetherialReduce: json['AetherialReduce'],
      alwaysCollectable: json['AlwaysCollectable'],
      article: json['Article'],
      baseParamModifier: json['BaseParamModifier'],
      baseParamValue0: json['BaseParamValue[0]'],
      baseParamValue1: json['BaseParamValue[1]'],
      baseParamValue2: json['BaseParamValue[2]'],
      baseParamValue3: json['BaseParamValue[3]'],
      baseParamValue4: json['BaseParamValue[4]'],
      baseParamValue5: json['BaseParamValue[5]'],
      baseParamValueSpecial0: json['BaseParamValue{Special}[0]'],
      baseParamValueSpecial1: json['BaseParamValue{Special}[1]'],
      baseParamValueSpecial2: json['BaseParamValue{Special}[2]'],
      baseParamValueSpecial3: json['BaseParamValue{Special}[3]'],
      baseParamValueSpecial4: json['BaseParamValue{Special}[4]'],
      baseParamValueSpecial5: json['BaseParamValue{Special}[5]'],
      baseParam0: json['BaseParam[0]'],
      baseParam1: json['BaseParam[1]'],
      baseParam2: json['BaseParam[2]'],
      baseParam3: json['BaseParam[3]'],
      baseParam4: json['BaseParam[4]'],
      baseParam5: json['BaseParam[5]'],
      baseParamSpecial0: json['BaseParam{Special}[0]'],
      baseParamSpecial1: json['BaseParam{Special}[1]'],
      baseParamSpecial2: json['BaseParam{Special}[2]'],
      baseParamSpecial3: json['BaseParam{Special}[3]'],
      baseParamSpecial4: json['BaseParam{Special}[4]'],
      baseParamSpecial5: json['BaseParam{Special}[5]'],
      block: json['Block'],
      blockRate: json['BlockRate'],
      canBeHq: json['CanBeHq'],
      castTime: json['CastTime<s>'],
      classJobCategory: json['ClassJobCategory'],
      classJobRepair: json['ClassJob{Repair}'],
      classJobUse: json['ClassJob{Use}'],
      cooldown: json['Cooldown<s>'],
      damageMag: json['Damage{Mag}'],
      damagePhys: json['Damage{Phys}'],
      defenseMag: json['Defense{Mag}'],
      defensePhys: json['Defense{Phys}'],
      delayMs: json['Delay<ms>'],
      description: json['Description'],
      desynth: json['Desynth'],
      dyeCount: json['DyeCount'],
      equipRestriction: json['EquipRestriction'],
      equipSlotCategory: json['EquipSlotCategory'],
      filterGroup: json['FilterGroup'],
      grandCompany: json['GrandCompany'],
      id: json['ID'],
      icon: json['Icon'],
      isAdvancedMeldingPermitted: json['IsAdvancedMeldingPermitted'],
      isCollectable: json['IsCollectable'],
      isCrestWorthy: json['IsCrestWorthy'],
      isGlamourous: json['IsGlamourous'],
      isIndisposable: json['IsIndisposable'],
      isPvP: json['IsPvP'],
      isUnique: json['IsUnique'],
      isUntradable: json['IsUntradable'],
      itemAction: json['ItemAction'],
      itemSearchCategory: json['ItemSearchCategory'],
      itemSeries: json['ItemSeries'],
      itemSortCategory: json['ItemSortCategory'],
      itemSpecialBonus: json['ItemSpecialBonus'],
      itemSpecialBonusParam: json['ItemSpecialBonus{Param}'],
      itemUICategory: json['ItemUICategory'],
      itemGlamour: json['Item{Glamour}'],
      itemRepair: json['Item{Repair}'],
      levelEquip: json['Level{Equip}'],
      levelItem: json['Level{Item}'],
      lot: json['Lot'],
      materiaSlotCount: json['MateriaSlotCount'],
      materializeType: json['MaterializeType'],
      modelMain: json['Model{Main}'],
      modelSub: json['Model{Sub}'],
      name: json['Name'],
      plural: json['Plural'],
      possessivePronoun: json['PossessivePronoun'],
      priceLow: json['Price{Low}'],
      priceMid: json['Price{Mid}'],
      pronoun: json['Pronoun'],
      rarity: json['Rarity'],
      requiredPvpRank: json['RequiredPvpRank'],
      sbyte: json['Sbyte'],
      singular: json['Singular'],
      stackSize: json['StackSize'],
      startsWithVowel: json['StartsWithVowel'],
      subStatCategory: json['SubStatCategory'],
      uint16: json['Uint16'],
      empty: json['__EMPTY'],
      empty1: json['__EMPTY_1'],
    );
  }

  // toJson 메서드
  Map<String, dynamic> toJson() {
    return {
      "_id": documentId,
      "AdditionalData": additionalData,
      "Adjective": adjective,
      "AetherialReduce": aetherialReduce,
      "AlwaysCollectable": alwaysCollectable,
      "Article": article,
      "BaseParamModifier": baseParamModifier,
      "BaseParamValue[0]": baseParamValue0,
      "BaseParamValue[1]": baseParamValue1,
      "BaseParamValue[2]": baseParamValue2,
      "BaseParamValue[3]": baseParamValue3,
      "BaseParamValue[4]": baseParamValue4,
      "BaseParamValue[5]": baseParamValue5,
      "BaseParamValue{Special}[0]": baseParamValueSpecial0,
      "BaseParamValue{Special}[1]": baseParamValueSpecial1,
      "BaseParamValue{Special}[2]": baseParamValueSpecial2,
      "BaseParamValue{Special}[3]": baseParamValueSpecial3,
      "BaseParamValue{Special}[4]": baseParamValueSpecial4,
      "BaseParamValue{Special}[5]": baseParamValueSpecial5,
      "BaseParam[0]": baseParam0,
      "BaseParam[1]": baseParam1,
      "BaseParam[2]": baseParam2,
      "BaseParam[3]": baseParam3,
      "BaseParam[4]": baseParam4,
      "BaseParam[5]": baseParam5,
      "BaseParam{Special}[0]": baseParamSpecial0,
      "BaseParam{Special}[1]": baseParamSpecial1,
      "BaseParam{Special}[2]": baseParamSpecial2,
      "BaseParam{Special}[3]": baseParamSpecial3,
      "BaseParam{Special}[4]": baseParamSpecial4,
      "BaseParam{Special}[5]": baseParamSpecial5,
      "Block": block,
      "BlockRate": blockRate,
      "CanBeHq": canBeHq,
      "CastTime<s>": castTime,
      "ClassJobCategory": classJobCategory,
      "ClassJob{Repair}": classJobRepair,
      "ClassJob{Use}": classJobUse,
      "Cooldown<s>": cooldown,
      "Damage{Mag}": damageMag,
      "Damage{Phys}": damagePhys,
      "Defense{Mag}": defenseMag,
      "Defense{Phys}": defensePhys,
      "Delay<ms>": delayMs,
      "Description": description,
      "Desynth": desynth,
      "DyeCount": dyeCount,
      "EquipRestriction": equipRestriction,
      "EquipSlotCategory": equipSlotCategory,
      "FilterGroup": filterGroup,
      "GrandCompany": grandCompany,
      "ID": id,
      "Icon": icon,
      "IsAdvancedMeldingPermitted": isAdvancedMeldingPermitted,
      "IsCollectable": isCollectable,
      "IsCrestWorthy": isCrestWorthy,
      "IsGlamourous": isGlamourous,
      "IsIndisposable": isIndisposable,
      "IsPvP": isPvP,
      "IsUnique": isUnique,
      "IsUntradable": isUntradable,
      "ItemAction": itemAction,
      "ItemSearchCategory": itemSearchCategory,
      "ItemSeries": itemSeries,
      "ItemSortCategory": itemSortCategory,
      "ItemSpecialBonus": itemSpecialBonus,
      "ItemSpecialBonus{Param}": itemSpecialBonusParam,
      "ItemUICategory": itemUICategory,
      "Item{Glamour}": itemGlamour,
      "Item{Repair}": itemRepair,
      "Level{Equip}": levelEquip,
      "Level{Item}": levelItem,
      "Lot": lot,
      "MateriaSlotCount": materiaSlotCount,
      "MaterializeType": materializeType,
      "Model{Main}": modelMain,
      "Model{Sub}": modelSub,
      "Name": name,
      "Plural": plural,
      "PossessivePronoun": possessivePronoun,
      "Price{Low}": priceLow,
      "Price{Mid}": priceMid,
      "Pronoun": pronoun,
      "Rarity": rarity,
      "RequiredPvpRank": requiredPvpRank,
      "Sbyte": sbyte,
      "Singular": singular,
      "StackSize": stackSize,
      "StartsWithVowel": startsWithVowel,
      "SubStatCategory": subStatCategory,
      "Uint16": uint16,
      "__EMPTY": empty,
      "__EMPTY_1": empty1,
    };
  }
}
