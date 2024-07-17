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
  List<int>? baseParamValueSpecial; //BaseParamValue{Special}	
  List<int>? baseParamSpecial; //BaseParam{Special}	
  int? block;
  int? blockRate;	
  bool? canBeHq;	
  int? castTimeSec; //CastTime<s>	
  int? classJobCategory;	
  int? classJobRepair; //ClassJob{Repair}	
  int? classJobUse; //ClassJob{Use}	
  int? cooldownSec; //Cooldown<s>	
  int? damageMag; //Damage{Mag}	
  int? damagePhys; //Damage{Phys}	
  int? defenseMag; //Defense{Mag}	
  int? defensePhys; //Defense{Phys}	
  int? delayMs; //Delay<ms>	
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
  int? itemSpecialBonusParam; //ItemSpecialBonus{Param}	
  int? itemUICategory;	
  int? itemGlamour; //Item{Glamour}	
  int? itemRepair; //Item{Repair} 

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
      documentId: json['documentId'] as String?,
      additionalData: json['additionalData'] as int?,
      adjective: json['adjective'] as int?,
      aetherialReduce: json['aetherialReduce'] as int?,
      alwaysCollectable: json['alwaysCollectable'] as int?,
      article: json['article'] as int?,
      baseParam: (json['baseParam'] as List<dynamic>?)?.map((e) => e as int).toList(),
      baseParamModifier: json['baseParamModifier'] as String?,
      baseParamValue: (json['baseParamValue'] as List<dynamic>?)?.map((e) => e as int).toList(),
      baseParamValueSpecial: (json['baseParamValueSpecial'] as List<dynamic>?)?.map((e) => e as int).toList(),
      baseParamSpecial: (json['baseParamSpecial'] as List<dynamic>?)?.map((e) => e as int).toList(),
      block: json['block'] as int?,
      blockRate: json['blockRate'] as int?,
      canBeHq: json['canBeHq'] as bool?,
      castTimeSec: json['castTimeSec'] as int?,
      classJobCategory: json['classJobCategory'] as int?,
      classJobRepair: json['classJobRepair'] as int?,
      classJobUse: json['classJobUse'] as int?,
      cooldownSec: json['cooldownSec'] as int?,
      damageMag: json['damageMag'] as int?,
      damagePhys: json['damagePhys'] as int?,
      defenseMag: json['defenseMag'] as int?,
      defensePhys: json['defensePhys'] as int?,
      delayMs: json['delayMs'] as int?,
      description: json['description'] as String?,
      desynth: json['desynth'] as int?,
      dyeCount: json['dyeCount'] as int?,
      equipRestriction: json['equipRestriction'] as int?,
      equipSlotCategory: json['equipSlotCategory'] as int?,
      filterGroup: json['filterGroup'] as int?,
      grandCompany: json['grandCompany'] as int?,
      id: json['id'] as int?,
      icon: json['icon'] as int?,
      isAdvancedMeldingPermitted: json['isAdvancedMeldingPermitted'] as bool?,
      isCollectable: json['isCollectable'] as bool?,
      isCrestWorthy: json['isCrestWorthy'] as bool?,
      isGlamourous: json['isGlamourous'] as bool?,
      isIndisposable: json['isIndisposable'] as bool?,
      isPvP: json['isPvP'] as bool?,
      isUnique: json['isUnique'] as bool?,
      isUntradable: json['isUntradable'] as bool?,
      itemAction: json['itemAction'] as int?,
      itemSearchCategory: json['itemSearchCategory'] as int?,
      itemSeries: json['itemSeries'] as int?,
      itemSortCategory: json['itemSortCategory'] as int?,
      itemSpecialBonus: json['itemSpecialBonus'] as int?,
      itemSpecialBonusParam: json['itemSpecialBonusParam'] as int?,
      itemUICategory: json['itemUICategory'] as int?,
      itemGlamour: json['itemGlamour'] as int?,
      itemRepair: json['itemRepair'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'additionalData': additionalData,
      'adjective': adjective,
      'aetherialReduce': aetherialReduce,
      'alwaysCollectable': alwaysCollectable,
      'article': article,
      'baseParam': baseParam,
      'baseParamModifier': baseParamModifier,
      'baseParamValue': baseParamValue,
      'baseParamValueSpecial': baseParamValueSpecial,
      'baseParamSpecial': baseParamSpecial,
      'block': block,
      'blockRate': blockRate,
      'canBeHq': canBeHq,
      'castTimeSec': castTimeSec,
      'classJobCategory': classJobCategory,
      'classJobRepair': classJobRepair,
      'classJobUse': classJobUse,
      'cooldownSec': cooldownSec,
      'damageMag': damageMag,
      'damagePhys': damagePhys,
      'defenseMag': defenseMag,
      'defensePhys': defensePhys,
      'delayMs': delayMs,
      'description': description,
      'desynth': desynth,
      'dyeCount': dyeCount,
      'equipRestriction': equipRestriction,
      'equipSlotCategory': equipSlotCategory,
      'filterGroup': filterGroup,
      'grandCompany': grandCompany,
      'id': id,
      'icon': icon,
      'isAdvancedMeldingPermitted': isAdvancedMeldingPermitted,
      'isCollectable': isCollectable,
      'isCrestWorthy': isCrestWorthy,
      'isGlamourous': isGlamourous,
      'isIndisposable': isIndisposable,
      'isPvP': isPvP,
      'isUnique': isUnique,
      'isUntradable': isUntradable,
      'itemAction': itemAction,
      'itemSearchCategory': itemSearchCategory,
      'itemSeries': itemSeries,
      'itemSortCategory': itemSortCategory,
      'itemSpecialBonus': itemSpecialBonus,
      'itemSpecialBonusParam': itemSpecialBonusParam,
      'itemUICategory': itemUICategory,
      'itemGlamour': itemGlamour,
      'itemRepair': itemRepair,
    };
  }
}
