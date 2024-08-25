

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


  List<String> classList = [
      "검술사",        // Gladiator
      "격투사",        // Pugi
      "도끼술사",      // Marauder
      "창술사",        // Lancer
      "궁술사",        // Archer
      "환술사",        // Conjurer
      "주술사",        // Thaumaturge
      "비술사",        // Arcanist
      "쌍검사",        // Rogue
      "목수",          // Carpenter
      "대장장이",      // Blacksmith
      "갑주제작사",    // Armorer
      "보석공",        // Goldsmith
      "가죽공예가",    // Leatherworker
      "재봉사",        // Weaver
      "연금술사",      // Alchemist
      "요리사",        // Culinarian
      "광부",          // Miner
      "원예가",        // Botanist
      "어부",          // Fisher
      "나이트",        // Paladin
      "몽크",          // Monk
      "전사",          // Warrior
      "용기사",        // Dragoon
      "음유시인",      // Bard
      "백마도사",      // White Mage
      "흑마도사",      // Black Mage
      "소환사",        // Summoner
      "학자",          // Scholar
      "닌자",          // Ninja
      "기공사",        // Machinist
      "암흑기사",      // Dark Knight
      "점성술사",      // Astrologian
      "사무라이",      // Samurai
      "적마도사",      // Red Mage
      "청마도사",      // Blue Mage
      "건브레이커",    // Gunbreaker
      "무도가",        // Dancer
      "리퍼",          // Reaper
      "현자"           // Sage
  ];


  List<String> baseStats = [
    "방어",
    "방어 확률",
    "물리 피해",
    "마법 피해",
    "물리 방어력",
    "마법 방어력",
    "초당 피해",
    "쿨다운",
  ];

  List<String> stats = [
    "힘",
    "민첩",
    "활력",
    "지능",
    "정신",
    "극대",
    "결의",
    "직격",
    "기술 속도",
    "마법 속도",
    "불굴",
    "신앙",
    "극대 확률",
    "무기 막기",
    "명중률",
    "공격력",
    "방어력",
    "마법 방어력",
    "체력",
    "마나"
  ];





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