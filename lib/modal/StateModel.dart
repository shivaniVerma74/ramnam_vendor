class StateModel {
  String? responseCode;
  String? msg;
  List<StataData>? data;

  StateModel({this.responseCode, this.msg, this.data});

  StateModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <StataData>[];
      json['data'].forEach((v) {
        data!.add(new StataData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StataData {
  String? id;
  String? name;
  String? countryId;
  String? createdAt;
  String? updatedAt;

  StataData({this.id, this.name, this.countryId, this.createdAt, this.updatedAt});

  StataData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
