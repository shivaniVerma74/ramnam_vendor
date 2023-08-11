/// response_code : "1"
/// msg : "Membership plans"
/// data : [{"id":"34","title":"dummy","description":"dummy","price":1000,"no_of_person":"40","type":"0","image":"https://developmentalphawizz.com/ramnaam/uploads/641d3a7c70cbe.jpg","created_at":"2023-03-24 05:51:56","updated_at":"2023-03-24 05:51:56","v_id":"28,27,17,18,34","plan_type":"standard","main_plan_type":"commercial","pooja_samagri":"1","fruit_flower":"1","time_text":" "},{"id":"37","title":"Test plan","description":"test description ","price":5000,"no_of_person":"18","type":"0","image":"https://developmentalphawizz.com/ramnaam/uploads/64216470e964a.jpg","created_at":"2023-03-27 09:40:00","updated_at":"2023-03-27 09:40:00","v_id":"34","plan_type":"Economy","main_plan_type":"Residence","pooja_samagri":"1","fruit_flower":"1","time_text":" "}]

class MyPlanModel {
  MyPlanModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  MyPlanModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Data>? _data;
MyPlanModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => MyPlanModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "34"
/// title : "dummy"
/// description : "dummy"
/// price : 1000
/// no_of_person : "40"
/// type : "0"
/// image : "https://developmentalphawizz.com/ramnaam/uploads/641d3a7c70cbe.jpg"
/// created_at : "2023-03-24 05:51:56"
/// updated_at : "2023-03-24 05:51:56"
/// v_id : "28,27,17,18,34"
/// plan_type : "standard"
/// main_plan_type : "commercial"
/// pooja_samagri : "1"
/// fruit_flower : "1"
/// time_text : " "

class Data {
  Data({
      String? id, 
      String? title, 
      String? description, 
      num? price, 
      String? noOfPerson, 
      String? type, 
      String? image, 
      String? createdAt, 
      String? updatedAt, 
      String? vId, 
      String? planType, 
      String? mainPlanType, 
      String? poojaSamagri, 
      String? fruitFlower, 
      String? timeText,}){
    _id = id;
    _title = title;
    _description = description;
    _price = price;
    _noOfPerson = noOfPerson;
    _type = type;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _vId = vId;
    _planType = planType;
    _mainPlanType = mainPlanType;
    _poojaSamagri = poojaSamagri;
    _fruitFlower = fruitFlower;
    _timeText = timeText;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _price = json['price'];
    _noOfPerson = json['no_of_person'];
    _type = json['type'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _vId = json['v_id'];
    _planType = json['plan_type'];
    _mainPlanType = json['main_plan_type'];
    _poojaSamagri = json['pooja_samagri'];
    _fruitFlower = json['fruit_flower'];
    _timeText = json['time_text'];
  }
  String? _id;
  String? _title;
  String? _description;
  num? _price;
  String? _noOfPerson;
  String? _type;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  String? _vId;
  String? _planType;
  String? _mainPlanType;
  String? _poojaSamagri;
  String? _fruitFlower;
  String? _timeText;
Data copyWith({  String? id,
  String? title,
  String? description,
  num? price,
  String? noOfPerson,
  String? type,
  String? image,
  String? createdAt,
  String? updatedAt,
  String? vId,
  String? planType,
  String? mainPlanType,
  String? poojaSamagri,
  String? fruitFlower,
  String? timeText,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  price: price ?? _price,
  noOfPerson: noOfPerson ?? _noOfPerson,
  type: type ?? _type,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  vId: vId ?? _vId,
  planType: planType ?? _planType,
  mainPlanType: mainPlanType ?? _mainPlanType,
  poojaSamagri: poojaSamagri ?? _poojaSamagri,
  fruitFlower: fruitFlower ?? _fruitFlower,
  timeText: timeText ?? _timeText,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  num? get price => _price;
  String? get noOfPerson => _noOfPerson;
  String? get type => _type;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get vId => _vId;
  String? get planType => _planType;
  String? get mainPlanType => _mainPlanType;
  String? get poojaSamagri => _poojaSamagri;
  String? get fruitFlower => _fruitFlower;
  String? get timeText => _timeText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['price'] = _price;
    map['no_of_person'] = _noOfPerson;
    map['type'] = _type;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['v_id'] = _vId;
    map['plan_type'] = _planType;
    map['main_plan_type'] = _mainPlanType;
    map['pooja_samagri'] = _poojaSamagri;
    map['fruit_flower'] = _fruitFlower;
    map['time_text'] = _timeText;
    return map;
  }

}