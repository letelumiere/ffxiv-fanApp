
class Normalize{
  
  /*
    Item의 JSON 반정규화 구조 계획 (실제 필드 명칭에서 틀릴 수 있음)

    ItemThumnail =
    {
      documentId,
      title{
        Id
        Icon,
        canBeHq,
        Name(plural인지 뭔지)?,
      }
      sort{
        CategoryClass? 
        ItemLevel,
        reqLevel?    
      }
    } 
  */

  /*
  ItemDetail = 
  {
    documentId,
    itemCateogry,
    descripton,
    title{
      Id,
      Icon,
      canBeHq,
      Name, 
      isProjectile,
      isAmoire,
      isCrest
    }
    stats{
      itemLevel,
      BaseParam[]
      baseParamModifer?
      MeterialCount
    },
    crafting{
      isRepaire
      ClasssRepair,
      MaterialGrade
      isMaterializeMelding
      isProjectile
      isDyeable
      Desynth
    }

    prices:{
      priceHigh
      priceLow
    }
  }

  비고 - item의 category가 다를 시(armor, arms, ochestrion, Housing 등) 출력하는 Dynamic이 달라야 한다. 
  특히 descripton

  
  체크해야 할 것 
  - baseParam, ItemSortCategory, ItemSearchCategory... 등, 배열 필드의 각 숫자들이 어떤 것을 뜻하는지 체크 해야 함. 
  - 능력치 버프 일 수도, 클래스 명칭의 번호일 수도 있음
  - itemCategory에 따라 view에서 뜨는 모습에 차이가 있어야 함.
  - description의 괄호는 태그가 아니므로 안심할 것.


  lodestone 기준으로 
  Arms  
  Tools
  Armor
  Accessories
  Medicine & Meals
  Materials
  Other
  그리고 각각의 소분류가 있음
  다행히 소분류에서 뭔가 바뀔 것은 없을 듯
  */

}