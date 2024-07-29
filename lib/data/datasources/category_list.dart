

enum itemCategory {
  Arms,
  Tools,
  Armor,
  Accessories,
  MedicineMeals,
  Materials,
  Other
}

var menuCategoryList = [
  "items"
  "settings"
];

var itemCategory2List = [
  "Arms",
  "Tools",
  "Armor",
  "Accessories",
  "Medicine & Meals",
  "Materials",
  "Other"
];

var itemCategory3Map = {
  "Arms" : ["A","B","C"],
  "Tools" : ["A","B"],
  "Armor" : ["A","B","C"],
  "Accessories" : ["DD"],
  "Medicine & Meals" : ["FF"],
  "Materials" : ["CC"],
  "Other" : ["EX"],
};


var itemStats = {
  "Cooldown<s>" :0.0,
  "Damage{Mag}" :0.0,
  "Damage{Phys}": 0.0,
  "Defense{Mag}": 0.0,
  "Defense{Phys}": 0.0,
  "Delay<ms>": 0.0,
};


var mishellious = {
  "IsAdvancedMeldingPermitted" : false,
  "IsCollectable" : false,
  "IsCrestWorthy" : false,
  "IsGlamourous" : false,
  "IsIndisposable" : false,
  "IsPvP" : false,
  "IsUnique" :  false,
  "IsUntradable" : false,
  "CanBeHq" : false,
};


var baseParam = [0, 0, 0, 0, 0, 0];
var baseParamValue = [0, 0, 0, 0, 0, 0];
var baseParamValueSpecial = [0, 0, 0, 0, 0, 0]; //BaseParamValue{Special}
var baseParamSpecial = [0, 0, 0, 0, 0, 0]; //BaseParam{Special}

