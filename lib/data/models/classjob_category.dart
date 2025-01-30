class ClassJobCategory {
  String one;
  String two;
  String three;
  String four;
  String five;
  String six;
  String seven;
  String eight;
  String nine;
  String ten;
  String eleven;
  String twelve;
  String thirteen;
  String fourteen;
  String fifteen;
  String sixteen;
  String seventeen;
  String eighteen;
  String nineteen;
  String twenty;
  String twentyOne;
  String twentyTwo;
  String twentyThree;
  String twentyFour;
  String twentyFive;
  String twentySix;
  String twentySeven;
  String twentyEight;
  String twentyNine;
  String thirty;
  String thirtyOne;
  String thirtyTwo;
  String thirtyThree;
  String thirtyFour;
  String thirtyFive;
  String thirtySix;
  String thirtySeven;
  String thirtyEight;
  String thirtyNine;
  String forty;
  String fortyOne;
  String fortyTwo;
  String fortyThree;

  int key;
  String xivString;

  ClassJobCategory({
    required this.one,
    required this.two,
    required this.three,
    required this.four,
    required this.five,
    required this.six,
    required this.seven,
    required this.eight,
    required this.nine,
    required this.ten,
    required this.eleven,
    required this.twelve,
    required this.thirteen,
    required this.fourteen,
    required this.fifteen,
    required this.sixteen,
    required this.seventeen,
    required this.eighteen,
    required this.nineteen,
    required this.twenty,
    required this.twentyOne,
    required this.twentyTwo,
    required this.twentyThree,
    required this.twentyFour,
    required this.twentyFive,
    required this.twentySix,
    required this.twentySeven,
    required this.twentyEight,
    required this.twentyNine,
    required this.thirty,
    required this.thirtyOne,
    required this.thirtyTwo,
    required this.thirtyThree,
    required this.thirtyFour,
    required this.thirtyFive,
    required this.thirtySix,
    required this.thirtySeven,
    required this.thirtyEight,
    required this.thirtyNine,
    required this.forty,
    required this.fortyOne,
    required this.fortyTwo,
    required this.fortyThree,
    required this.key,
    required this.xivString,
  });

  // String 값을 bool로 변환하는 메서드
  bool convertToBool(String value) {
    return value.toLowerCase() == 'true';
  }

  // JSON 데이터를 Dart 객체로 변환하는 메서드 (fromJson)
  factory ClassJobCategory.fromJson(Map<String, dynamic> json, String id) {
    return ClassJobCategory(
      one: json['1'] as String,
      two: json['2'] as String,
      three: json['3'] as String,
      four: json['4'] as String,
      five: json['5'] as String,
      six: json['6'] as String,
      seven: json['7'] as String,
      eight: json['8'] as String,
      nine: json['9'] as String,
      ten: json['10'] as String,
      eleven: json['11'] as String,
      twelve: json['12'] as String,
      thirteen: json['13'] as String,
      fourteen: json['14'] as String,
      fifteen: json['15'] as String,
      sixteen: json['16'] as String,
      seventeen: json['17'] as String,
      eighteen: json['18'] as String,
      nineteen: json['19'] as String,
      twenty: json['20'] as String,
      twentyOne: json['21'] as String,
      twentyTwo: json['22'] as String,
      twentyThree: json['23'] as String,
      twentyFour: json['24'] as String,
      twentyFive: json['25'] as String,
      twentySix: json['26'] as String,
      twentySeven: json['27'] as String,
      twentyEight: json['28'] as String,
      twentyNine: json['29'] as String,
      thirty: json['30'] as String,
      thirtyOne: json['31'] as String,
      thirtyTwo: json['32'] as String,
      thirtyThree: json['33'] as String,
      thirtyFour: json['34'] as String,
      thirtyFive: json['35'] as String,
      thirtySix: json['36'] as String,
      thirtySeven: json['37'] as String,
      thirtyEight: json['38'] as String,
      thirtyNine: json['39'] as String,
      forty: json['40'] as String,
      fortyOne: json['41'] as String,
      fortyTwo: json['42'] as String,
      fortyThree: json['43'] as String,
      key: json['key'] as int,
      xivString: json['xivString'] as String,
    );
  }

  // Dart 객체를 JSON 데이터로 변환하는 메서드 (toJson)
  Map<String, dynamic> toJson() {
    return {
      '1': one,
      '2': two,
      '3': three,
      '4': four,
      '5': five,
      '6': six,
      '7': seven,
      '8': eight,
      '9': nine,
      '10': ten,
      '11': eleven,
      '12': twelve,
      '13': thirteen,
      '14': fourteen,
      '15': fifteen,
      '16': sixteen,
      '17': seventeen,
      '18': eighteen,
      '19': nineteen,
      '20': twenty,
      '21': twentyOne,
      '22': twentyTwo,
      '23': twentyThree,
      '24': twentyFour,
      '25': twentyFive,
      '26': twentySix,
      '27': twentySeven,
      '28': twentyEight,
      '29': twentyNine,
      '30': thirty,
      '31': thirtyOne,
      '32': thirtyTwo,
      '33': thirtyThree,
      '34': thirtyFour,
      '35': thirtyFive,
      '36': thirtySix,
      '37': thirtySeven,
      '38': thirtyEight,
      '39': thirtyNine,
      '40': forty,
      '41': fortyOne,
      '42': fortyTwo,
      '43': fortyThree,
      'key': key,
      'xivString': xivString,
    };
  }
}
