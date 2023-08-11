/// response_code : "1"
/// msg : "My Bookings"
/// data : [{"booking_id":"12","schedule_date":"2023-07-29","slot":"17:40","subtotal":"7610.00","date":"2023-07-25","vendor_payemnt_amount":"7610.00","gst_charge":"","vendor_Gst":"","platform_charge":"30","delivery_charge":"","payment_mode":"COD","address":"Indore, Madhya Pradesh, India","txn_id":null,"otp":"4203","status":"0","username":"dev","mobile":"7999705780","roll_id":"7","no_of_chef":"0","no_of_helper":"0","hours":"","plan_id":"133","plans":[{"id":"133","title":"Grah Pravesh","description":"More number of Vadhyars, more number of mantra japas and homas, Very Grand alankaram will be done with more kalashas and Alankaram with Flowers for the pooja will be done in a Very Grand way.  Duration: 3.5 - 4 Hours  Procedure involved: • Gho Pooja • Ganapathi pooja • Punyaha Vachanam, Maha Sankalpam • Kalasha Pooja, aavahanam • Vastu Pooja (Vastu Shanthi includes homam to remove the negative vibrations in the home) • Homams – Ganapathi Homam, Navagraha homam and Lakshmi Kubera Homam, Sudarshana homam. • Boiling Milk with new vessel • Poornahuthi & Prasad Distribution  Note: Pooja Samagries like Manjal, Kumkum, Santhanam, Coconuts, Maavilai, Darbai, Kalasam, Vastram, Dhanyam, Jacket Bits, Vetrilai, Paaku, Homam Sticks, Samith, Dravyas, Ghee, etc. will be brought by us.  Yajaman has to keep house items like Photos, Vessels, Vilaku, Oil, Mats, Bowls, Prasadam, Plates, etc you will be receiving a detailed to-do list after booking.","price":"3000.00","no_of_person":"15","type":"0","image":"64b7e3566bf5e.jpg","created_at":"2023-07-19 13:21:26","updated_at":"2023-07-19 13:21:26","c_id":"49","plan_type":"premium","main_plan_type":"residence","pooja_samagri":"1","fruit_flower":"1"}],"add_on_item":{"status":"1","name":"Medium Homakund","price":"600","img":"https://developmentalphawizz.com/ramnaam/uploads/1684931459homakund1.png"},"total":"8210","products":[{"id":"49","artist_name":"Griha Pravesham ","category_id":"37","sub_id":"86","services_image":"1689773431image-58.png","profile_image":"64b7e53d4b3f9.png","mrp_price":"500","special_price":"400","v_id":"28","roll":"7","ser_desc":"Grah Pravesh Home pooja for every one on this planet","service_status":"1","helper_price":"400","chefs_price":null,"per_d_charge":"0","tax_status":"0","gst_amount":"12","charge_type":"","service_type":"residence","transport":null,"request_status":"0"}]}]

class VendorBookingModel {
  VendorBookingModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  VendorBookingModel.fromJson(dynamic json) {
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
VendorBookingModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => VendorBookingModel(  responseCode: responseCode ?? _responseCode,
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

/// booking_id : "12"
/// schedule_date : "2023-07-29"
/// slot : "17:40"
/// subtotal : "7610.00"
/// date : "2023-07-25"
/// vendor_payemnt_amount : "7610.00"
/// gst_charge : ""
/// vendor_Gst : ""
/// platform_charge : "30"
/// delivery_charge : ""
/// payment_mode : "COD"
/// address : "Indore, Madhya Pradesh, India"
/// txn_id : null
/// otp : "4203"
/// status : "0"
/// username : "dev"
/// mobile : "7999705780"
/// roll_id : "7"
/// no_of_chef : "0"
/// no_of_helper : "0"
/// hours : ""
/// plan_id : "133"
/// plans : [{"id":"133","title":"Grah Pravesh","description":"More number of Vadhyars, more number of mantra japas and homas, Very Grand alankaram will be done with more kalashas and Alankaram with Flowers for the pooja will be done in a Very Grand way.  Duration: 3.5 - 4 Hours  Procedure involved: • Gho Pooja • Ganapathi pooja • Punyaha Vachanam, Maha Sankalpam • Kalasha Pooja, aavahanam • Vastu Pooja (Vastu Shanthi includes homam to remove the negative vibrations in the home) • Homams – Ganapathi Homam, Navagraha homam and Lakshmi Kubera Homam, Sudarshana homam. • Boiling Milk with new vessel • Poornahuthi & Prasad Distribution  Note: Pooja Samagries like Manjal, Kumkum, Santhanam, Coconuts, Maavilai, Darbai, Kalasam, Vastram, Dhanyam, Jacket Bits, Vetrilai, Paaku, Homam Sticks, Samith, Dravyas, Ghee, etc. will be brought by us.  Yajaman has to keep house items like Photos, Vessels, Vilaku, Oil, Mats, Bowls, Prasadam, Plates, etc you will be receiving a detailed to-do list after booking.","price":"3000.00","no_of_person":"15","type":"0","image":"64b7e3566bf5e.jpg","created_at":"2023-07-19 13:21:26","updated_at":"2023-07-19 13:21:26","c_id":"49","plan_type":"premium","main_plan_type":"residence","pooja_samagri":"1","fruit_flower":"1"}]
/// add_on_item : {"status":"1","name":"Medium Homakund","price":"600","img":"https://developmentalphawizz.com/ramnaam/uploads/1684931459homakund1.png"}
/// total : "8210"
/// products : [{"id":"49","artist_name":"Griha Pravesham ","category_id":"37","sub_id":"86","services_image":"1689773431image-58.png","profile_image":"64b7e53d4b3f9.png","mrp_price":"500","special_price":"400","v_id":"28","roll":"7","ser_desc":"Grah Pravesh Home pooja for every one on this planet","service_status":"1","helper_price":"400","chefs_price":null,"per_d_charge":"0","tax_status":"0","gst_amount":"12","charge_type":"","service_type":"residence","transport":null,"request_status":"0"}]

class Data {
  Data({
      String? bookingId, 
      String? scheduleDate, 
      String? slot, 
      String? subtotal, 
      String? date, 
      String? vendorPayemntAmount, 
      String? gstCharge, 
      String? vendorGst, 
      String? platformCharge, 
      String? deliveryCharge, 
      String? paymentMode, 
      String? address, 
      dynamic txnId, 
      String? otp, 
      String? status, 
      String? username, 
      String? mobile, 
      String? rollId, 
      String? noOfChef, 
      String? noOfHelper, 
      String? hours, 
      String? planId, 
      List<Plans>? plans, 
      AddOnItem? addOnItem, 
      String? total, 
      List<Products>? products,}){
    _bookingId = bookingId;
    _scheduleDate = scheduleDate;
    _slot = slot;
    _subtotal = subtotal;
    _date = date;
    _vendorPayemntAmount = vendorPayemntAmount;
    _gstCharge = gstCharge;
    _vendorGst = vendorGst;
    _platformCharge = platformCharge;
    _deliveryCharge = deliveryCharge;
    _paymentMode = paymentMode;
    _address = address;
    _txnId = txnId;
    _otp = otp;
    _status = status;
    _username = username;
    _mobile = mobile;
    _rollId = rollId;
    _noOfChef = noOfChef;
    _noOfHelper = noOfHelper;
    _hours = hours;
    _planId = planId;
    _plans = plans;
    _addOnItem = addOnItem;
    _total = total;
    _products = products;
}

  Data.fromJson(dynamic json) {
    _bookingId = json['booking_id'];
    _scheduleDate = json['schedule_date'];
    _slot = json['slot'];
    _subtotal = json['subtotal'];
    _date = json['date'];
    _vendorPayemntAmount = json['vendor_payemnt_amount'];
    _gstCharge = json['gst_charge'];
    _vendorGst = json['vendor_Gst'];
    _platformCharge = json['platform_charge'];
    _deliveryCharge = json['delivery_charge'];
    _paymentMode = json['payment_mode'];
    _address = json['address'];
    _txnId = json['txn_id'];
    _otp = json['otp'];
    _status = json['status'];
    _username = json['username'];
    _mobile = json['mobile'];
    _rollId = json['roll_id'];
    _noOfChef = json['no_of_chef'];
    _noOfHelper = json['no_of_helper'];
    _hours = json['hours'];
    _planId = json['plan_id'];
    if (json['plans'] != null) {
      _plans = [];
      json['plans'].forEach((v) {
        _plans?.add(Plans.fromJson(v));
      });
    }
    _addOnItem = json['add_on_item'] != null ? AddOnItem.fromJson(json['add_on_item']) : AddOnItem();
    _total = json['total'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }
  String? _bookingId;
  String? _scheduleDate;
  String? _slot;
  String? _subtotal;
  String? _date;
  String? _vendorPayemntAmount;
  String? _gstCharge;
  String? _vendorGst;
  String? _platformCharge;
  String? _deliveryCharge;
  String? _paymentMode;
  String? _address;
  dynamic _txnId;
  String? _otp;
  String? _status;
  String? _username;
  String? _mobile;
  String? _rollId;
  String? _noOfChef;
  String? _noOfHelper;
  String? _hours;
  String? _planId;
  List<Plans>? _plans;
  AddOnItem? _addOnItem;
  String? _total;
  List<Products>? _products;
Data copyWith({  String? bookingId,
  String? scheduleDate,
  String? slot,
  String? subtotal,
  String? date,
  String? vendorPayemntAmount,
  String? gstCharge,
  String? vendorGst,
  String? platformCharge,
  String? deliveryCharge,
  String? paymentMode,
  String? address,
  dynamic txnId,
  String? otp,
  String? status,
  String? username,
  String? mobile,
  String? rollId,
  String? noOfChef,
  String? noOfHelper,
  String? hours,
  String? planId,
  List<Plans>? plans,
  AddOnItem? addOnItem,
  String? total,
  List<Products>? products,
}) => Data(  bookingId: bookingId ?? _bookingId,
  scheduleDate: scheduleDate ?? _scheduleDate,
  slot: slot ?? _slot,
  subtotal: subtotal ?? _subtotal,
  date: date ?? _date,
  vendorPayemntAmount: vendorPayemntAmount ?? _vendorPayemntAmount,
  gstCharge: gstCharge ?? _gstCharge,
  vendorGst: vendorGst ?? _vendorGst,
  platformCharge: platformCharge ?? _platformCharge,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  paymentMode: paymentMode ?? _paymentMode,
  address: address ?? _address,
  txnId: txnId ?? _txnId,
  otp: otp ?? _otp,
  status: status ?? _status,
  username: username ?? _username,
  mobile: mobile ?? _mobile,
  rollId: rollId ?? _rollId,
  noOfChef: noOfChef ?? _noOfChef,
  noOfHelper: noOfHelper ?? _noOfHelper,
  hours: hours ?? _hours,
  planId: planId ?? _planId,
  plans: plans ?? _plans,
  addOnItem: addOnItem ?? _addOnItem,
  total: total ?? _total,
  products: products ?? _products,
);
  String? get bookingId => _bookingId;
  String? get scheduleDate => _scheduleDate;
  String? get slot => _slot;
  String? get subtotal => _subtotal;
  String? get date => _date;
  String? get vendorPayemntAmount => _vendorPayemntAmount;
  String? get gstCharge => _gstCharge;
  String? get vendorGst => _vendorGst;
  String? get platformCharge => _platformCharge;
  String? get deliveryCharge => _deliveryCharge;
  String? get paymentMode => _paymentMode;
  String? get address => _address;
  dynamic get txnId => _txnId;
  String? get otp => _otp;
  String? get status => _status;
  String? get username => _username;
  String? get mobile => _mobile;
  String? get rollId => _rollId;
  String? get noOfChef => _noOfChef;
  String? get noOfHelper => _noOfHelper;
  String? get hours => _hours;
  String? get planId => _planId;
  List<Plans>? get plans => _plans;
  AddOnItem? get addOnItem => _addOnItem;
  String? get total => _total;
  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['booking_id'] = _bookingId;
    map['schedule_date'] = _scheduleDate;
    map['slot'] = _slot;
    map['subtotal'] = _subtotal;
    map['date'] = _date;
    map['vendor_payemnt_amount'] = _vendorPayemntAmount;
    map['gst_charge'] = _gstCharge;
    map['vendor_Gst'] = _vendorGst;
    map['platform_charge'] = _platformCharge;
    map['delivery_charge'] = _deliveryCharge;
    map['payment_mode'] = _paymentMode;
    map['address'] = _address;
    map['txn_id'] = _txnId;
    map['otp'] = _otp;
    map['status'] = _status;
    map['username'] = _username;
    map['mobile'] = _mobile;
    map['roll_id'] = _rollId;
    map['no_of_chef'] = _noOfChef;
    map['no_of_helper'] = _noOfHelper;
    map['hours'] = _hours;
    map['plan_id'] = _planId;
    if (_plans != null) {
      map['plans'] = _plans?.map((v) => v.toJson()).toList();
    }
    if (_addOnItem != null) {
      map['add_on_item'] = _addOnItem?.toJson();
    }else{
    }
    map['total'] = _total;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "49"
/// artist_name : "Griha Pravesham "
/// category_id : "37"
/// sub_id : "86"
/// services_image : "1689773431image-58.png"
/// profile_image : "64b7e53d4b3f9.png"
/// mrp_price : "500"
/// special_price : "400"
/// v_id : "28"
/// roll : "7"
/// ser_desc : "Grah Pravesh Home pooja for every one on this planet"
/// service_status : "1"
/// helper_price : "400"
/// chefs_price : null
/// per_d_charge : "0"
/// tax_status : "0"
/// gst_amount : "12"
/// charge_type : ""
/// service_type : "residence"
/// transport : null
/// request_status : "0"

class Products {
  Products({
      String? id, 
      String? artistName, 
      String? categoryId, 
      String? subId, 
      String? servicesImage, 
      String? profileImage, 
      String? mrpPrice, 
      String? specialPrice, 
      String? vId, 
      String? roll, 
      String? serDesc, 
      String? serviceStatus, 
      String? helperPrice, 
      dynamic chefsPrice, 
      String? perDCharge, 
      String? taxStatus, 
      String? gstAmount, 
      String? chargeType, 
      String? serviceType, 
      dynamic transport, 
      String? requestStatus,}){
    _id = id;
    _artistName = artistName;
    _categoryId = categoryId;
    _subId = subId;
    _servicesImage = servicesImage;
    _profileImage = profileImage;
    _mrpPrice = mrpPrice;
    _specialPrice = specialPrice;
    _vId = vId;
    _roll = roll;
    _serDesc = serDesc;
    _serviceStatus = serviceStatus;
    _helperPrice = helperPrice;
    _chefsPrice = chefsPrice;
    _perDCharge = perDCharge;
    _taxStatus = taxStatus;
    _gstAmount = gstAmount;
    _chargeType = chargeType;
    _serviceType = serviceType;
    _transport = transport;
    _requestStatus = requestStatus;
}

  Products.fromJson(dynamic json) {
    _id = json['id'];
    _artistName = json['artist_name'];
    _categoryId = json['category_id'];
    _subId = json['sub_id'];
    _servicesImage = json['services_image'];
    _profileImage = json['profile_image'];
    _mrpPrice = json['mrp_price'];
    _specialPrice = json['special_price'];
    _vId = json['v_id'];
    _roll = json['roll'];
    _serDesc = json['ser_desc'];
    _serviceStatus = json['service_status'];
    _helperPrice = json['helper_price'];
    _chefsPrice = json['chefs_price'];
    _perDCharge = json['per_d_charge'];
    _taxStatus = json['tax_status'];
    _gstAmount = json['gst_amount'];
    _chargeType = json['charge_type'];
    _serviceType = json['service_type'];
    _transport = json['transport'];
    _requestStatus = json['request_status'];
  }
  String? _id;
  String? _artistName;
  String? _categoryId;
  String? _subId;
  String? _servicesImage;
  String? _profileImage;
  String? _mrpPrice;
  String? _specialPrice;
  String? _vId;
  String? _roll;
  String? _serDesc;
  String? _serviceStatus;
  String? _helperPrice;
  dynamic _chefsPrice;
  String? _perDCharge;
  String? _taxStatus;
  String? _gstAmount;
  String? _chargeType;
  String? _serviceType;
  dynamic _transport;
  String? _requestStatus;
Products copyWith({  String? id,
  String? artistName,
  String? categoryId,
  String? subId,
  String? servicesImage,
  String? profileImage,
  String? mrpPrice,
  String? specialPrice,
  String? vId,
  String? roll,
  String? serDesc,
  String? serviceStatus,
  String? helperPrice,
  dynamic chefsPrice,
  String? perDCharge,
  String? taxStatus,
  String? gstAmount,
  String? chargeType,
  String? serviceType,
  dynamic transport,
  String? requestStatus,
}) => Products(  id: id ?? _id,
  artistName: artistName ?? _artistName,
  categoryId: categoryId ?? _categoryId,
  subId: subId ?? _subId,
  servicesImage: servicesImage ?? _servicesImage,
  profileImage: profileImage ?? _profileImage,
  mrpPrice: mrpPrice ?? _mrpPrice,
  specialPrice: specialPrice ?? _specialPrice,
  vId: vId ?? _vId,
  roll: roll ?? _roll,
  serDesc: serDesc ?? _serDesc,
  serviceStatus: serviceStatus ?? _serviceStatus,
  helperPrice: helperPrice ?? _helperPrice,
  chefsPrice: chefsPrice ?? _chefsPrice,
  perDCharge: perDCharge ?? _perDCharge,
  taxStatus: taxStatus ?? _taxStatus,
  gstAmount: gstAmount ?? _gstAmount,
  chargeType: chargeType ?? _chargeType,
  serviceType: serviceType ?? _serviceType,
  transport: transport ?? _transport,
  requestStatus: requestStatus ?? _requestStatus,
);
  String? get id => _id;
  String? get artistName => _artistName;
  String? get categoryId => _categoryId;
  String? get subId => _subId;
  String? get servicesImage => _servicesImage;
  String? get profileImage => _profileImage;
  String? get mrpPrice => _mrpPrice;
  String? get specialPrice => _specialPrice;
  String? get vId => _vId;
  String? get roll => _roll;
  String? get serDesc => _serDesc;
  String? get serviceStatus => _serviceStatus;
  String? get helperPrice => _helperPrice;
  dynamic get chefsPrice => _chefsPrice;
  String? get perDCharge => _perDCharge;
  String? get taxStatus => _taxStatus;
  String? get gstAmount => _gstAmount;
  String? get chargeType => _chargeType;
  String? get serviceType => _serviceType;
  dynamic get transport => _transport;
  String? get requestStatus => _requestStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['artist_name'] = _artistName;
    map['category_id'] = _categoryId;
    map['sub_id'] = _subId;
    map['services_image'] = _servicesImage;
    map['profile_image'] = _profileImage;
    map['mrp_price'] = _mrpPrice;
    map['special_price'] = _specialPrice;
    map['v_id'] = _vId;
    map['roll'] = _roll;
    map['ser_desc'] = _serDesc;
    map['service_status'] = _serviceStatus;
    map['helper_price'] = _helperPrice;
    map['chefs_price'] = _chefsPrice;
    map['per_d_charge'] = _perDCharge;
    map['tax_status'] = _taxStatus;
    map['gst_amount'] = _gstAmount;
    map['charge_type'] = _chargeType;
    map['service_type'] = _serviceType;
    map['transport'] = _transport;
    map['request_status'] = _requestStatus;
    return map;
  }

}

/// status : "1"
/// name : "Medium Homakund"
/// price : "600"
/// img : "https://developmentalphawizz.com/ramnaam/uploads/1684931459homakund1.png"

class AddOnItem {
  AddOnItem({
      String? status, 
      String? name, 
      String? price, 
      String? img,}){
    _status = status;
    _name = name;
    _price = price;
    _img = img;
}

  AddOnItem.fromJson(dynamic json) {
    _status = json['status'];
    _name = json['name'];
    _price = json['price'];
    _img = json['img'];
  }
  String? _status;
  String? _name;
  String? _price;
  String? _img;
AddOnItem copyWith({  String? status,
  String? name,
  String? price,
  String? img,
}) => AddOnItem(  status: status ?? _status,
  name: name ?? _name,
  price: price ?? _price,
  img: img ?? _img,
);
  String? get status => _status;
  String? get name => _name;
  String? get price => _price;
  String? get img => _img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['name'] = _name;
    map['price'] = _price;
    map['img'] = _img;
    return map;
  }

}

/// id : "133"
/// title : "Grah Pravesh"
/// description : "More number of Vadhyars, more number of mantra japas and homas, Very Grand alankaram will be done with more kalashas and Alankaram with Flowers for the pooja will be done in a Very Grand way.  Duration: 3.5 - 4 Hours  Procedure involved: • Gho Pooja • Ganapathi pooja • Punyaha Vachanam, Maha Sankalpam • Kalasha Pooja, aavahanam • Vastu Pooja (Vastu Shanthi includes homam to remove the negative vibrations in the home) • Homams – Ganapathi Homam, Navagraha homam and Lakshmi Kubera Homam, Sudarshana homam. • Boiling Milk with new vessel • Poornahuthi & Prasad Distribution  Note: Pooja Samagries like Manjal, Kumkum, Santhanam, Coconuts, Maavilai, Darbai, Kalasam, Vastram, Dhanyam, Jacket Bits, Vetrilai, Paaku, Homam Sticks, Samith, Dravyas, Ghee, etc. will be brought by us.  Yajaman has to keep house items like Photos, Vessels, Vilaku, Oil, Mats, Bowls, Prasadam, Plates, etc you will be receiving a detailed to-do list after booking."
/// price : "3000.00"
/// no_of_person : "15"
/// type : "0"
/// image : "64b7e3566bf5e.jpg"
/// created_at : "2023-07-19 13:21:26"
/// updated_at : "2023-07-19 13:21:26"
/// c_id : "49"
/// plan_type : "premium"
/// main_plan_type : "residence"
/// pooja_samagri : "1"
/// fruit_flower : "1"

class Plans {
  Plans({
      String? id, 
      String? title, 
      String? description, 
      String? price, 
      String? noOfPerson, 
      String? type, 
      String? image, 
      String? createdAt, 
      String? updatedAt, 
      String? cId, 
      String? planType, 
      String? mainPlanType, 
      String? poojaSamagri, 
      String? fruitFlower,}){
    _id = id;
    _title = title;
    _description = description;
    _price = price;
    _noOfPerson = noOfPerson;
    _type = type;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _cId = cId;
    _planType = planType;
    _mainPlanType = mainPlanType;
    _poojaSamagri = poojaSamagri;
    _fruitFlower = fruitFlower;
}

  Plans.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _price = json['price'];
    _noOfPerson = json['no_of_person'];
    _type = json['type'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _cId = json['c_id'];
    _planType = json['plan_type'];
    _mainPlanType = json['main_plan_type'];
    _poojaSamagri = json['pooja_samagri'];
    _fruitFlower = json['fruit_flower'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _price;
  String? _noOfPerson;
  String? _type;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  String? _cId;
  String? _planType;
  String? _mainPlanType;
  String? _poojaSamagri;
  String? _fruitFlower;
Plans copyWith({  String? id,
  String? title,
  String? description,
  String? price,
  String? noOfPerson,
  String? type,
  String? image,
  String? createdAt,
  String? updatedAt,
  String? cId,
  String? planType,
  String? mainPlanType,
  String? poojaSamagri,
  String? fruitFlower,
}) => Plans(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  price: price ?? _price,
  noOfPerson: noOfPerson ?? _noOfPerson,
  type: type ?? _type,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  cId: cId ?? _cId,
  planType: planType ?? _planType,
  mainPlanType: mainPlanType ?? _mainPlanType,
  poojaSamagri: poojaSamagri ?? _poojaSamagri,
  fruitFlower: fruitFlower ?? _fruitFlower,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get price => _price;
  String? get noOfPerson => _noOfPerson;
  String? get type => _type;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get cId => _cId;
  String? get planType => _planType;
  String? get mainPlanType => _mainPlanType;
  String? get poojaSamagri => _poojaSamagri;
  String? get fruitFlower => _fruitFlower;

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
    map['c_id'] = _cId;
    map['plan_type'] = _planType;
    map['main_plan_type'] = _mainPlanType;
    map['pooja_samagri'] = _poojaSamagri;
    map['fruit_flower'] = _fruitFlower;
    return map;
  }

}