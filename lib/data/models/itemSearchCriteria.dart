class ItemSearchCriteria {
  String? name;
  String? classJob;
  String? equipSlot;
  String? itemCategory;
  int? minLevelEquip;
  int? maxLevelEquip;
  int? minLevelItem;
  int? maxLevelItem;

  ItemSearchCriteria({
    this.name, 
    this.classJob, 
    this.equipSlot, 
    this.itemCategory, 
    this.minLevelEquip, 
    this.maxLevelEquip, 
    this.minLevelItem, 
    this.maxLevelItem
  });
}