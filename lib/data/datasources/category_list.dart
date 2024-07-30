

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


var itemStatsMap = {
  "Cooldown<s>" :0.0,
  "Damage{Mag}" :0.0, 
  "Damage{Phys}": 0.0,
  "Defense{Mag}": 0.0,
  "Defense{Phys}": 0.0,
  "Delay<ms>": 0.0,
};


var miscellaneousMap = {
  "AlwaysCollectable" : false,
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


var baseParam = [0, 0, 0, 0, 0, 0]; //능력치(힘,민첩 등 수치인가?)
var baseParamValue = [0, 0, 0, 0, 0, 0];  //추가 능력치 (활력, 극대화 등)
var baseParamValueSpecial = [0, 0, 0, 0, 0, 0]; //BaseParamValue{Special}
var baseParamSpecial = [0, 0, 0, 0, 0, 0]; //BaseParam{Special}


/*

function p.Test()
    item = {}
    item.Name = "Savage Aim Materia VI"
    item.ID = 12345
    item.Link = "Project:Sandsea"
    item.ClassJobCategory = {"arcanist", "scholar"}
    item.LevelEquip = 26
    item.LevelItem = 45
    item.ItemRepair = "grade 5 dark matter"
    item.IsIndisposable = 1
    item.IconID = 10000
    item.ClassJobRepair = "weaver"
    item.Description = "A big weapon."
    item.IsCrestWorthy = 1
    item.StackSize = 16
    item.BlockRate = 100
    item.HqBlockRate = 120
    item.HqCooldownS = 19
    item.MateriaSlotCount = 2
    item.ItemKind = "Medicines & Meals"
    item.ItemUICategory = "Gladiator's Arm"
    item.IsAdvancedMeldingPermitted = 1
    item.AlwaysCollectable = 1
    item.CanBeHq = true
    item.DamageMag = 15
    item.Stats = {
        ["Strength"] = {["NQ"] = 16, ["HQ"] = 26},
        ["DirectHitRate"] = {["NQ"] = 19}
    }
    item.Recipes = {
    	{
	    	["CanHq"] = true,
    		["ID"] = 199,
    		["ClassJob"] = "blacksmith",
    		["ClassJobLevel"] = 100,
    		["IsExpert"] = false,
    		["AmountResult"] = 15,
    		["Stars"] = 3,
    		["SuggestedControl"] = 1,
    		["RequiredControl"] = 2,
    		["Ingredients"] = {
    			{"Grade 5 Dark Matter", 15},
    		}
    	},
    }
    
    local t = table_header()
    local trs = create_trs(item, false)
    for i, tr in ipairs(trs) do
        t:node(tr)
    end
    return t
end

ref
https://finalfantasy.fandom.com/wiki/Module:XIVAPI/Sandbox
*/