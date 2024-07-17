
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


  */

}