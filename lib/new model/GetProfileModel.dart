/// response_code : "1"
/// message : "Get Successfully"
/// status : "success"
/// data : [{"id":"3","email":"shivanialphawizz@gmail.com","mobile":"7484848754","uname":"shiavni","address":"Indore, Madhya Pradesh, India","description":"","category_id":null,"per_d_charge":null,"per_h_charge":null,"experience":null,"vehicle_number":null,"vehicle_type":null,"rc_book":null,"per_km_charge":null,"password":"25d55ad283aa400af464c76d713c07ad","profile_image":"https://developmentalphawizz.com/ramnaam/uploads/profile_pics/64be24aa46178.jpg","device_token":"cr4JQYOVTI6IM-03S0oUhs:APA91bFxmxH-ze-b6Q6qQoTcnkhy2rpHkCGAZ9MR2kHTFiv1rbiA1SFefiVzVuxIHFhx24UjHBECWuNrPUwOC4dSriYcPwg_blxUjUV_zIm86TAUw9dqDYnjMj8ryAXlpF70G4_GGLGF","otp":"4601","status":"1","wallet":"0.00","balance":"0.00","last_login":null,"created_at":"2023-07-24 07:13:46","updated_at":"2023-08-11 08:18:49","roll":"7","adhar_card":"https://developmentalphawizz.com/ramnaam/uploads/profile_pics/64be24aa458ff.jpg","pancard":"https://developmentalphawizz.com/ramnaam/uploads/profile_pics/64be24aa462b9.jpg","gst_no":"","fssai":"","store_name":"","band_details":{"bank_name":"","account_number":"","account_holder_name":"","ifsc_code":"","account_type":""},"vehicle_no":"","registarion_card":"","driving_license":"","categories_id":"37,38,40","company_name":"","role_user":"","event":"","latitude":"22.7195687","longitude":"75.8577258","delivery_type":"","refferal_code":"","friend_code":"","online_status":"1","store_description":"","commision":"","resto_type":"","gender":null,"cash_collection":"0","commision_amount_type":"","transport":"","pincode":"452010","area":"medanta","city":"Indore","state":"Madhya Pardesh","reffral_code":"","educational_qualification":"dfs","professional_qualification":"JNKJNH","sanskrit_qualification":"KJH","languages":"KJH","caste":"Brahmin","veda_studies":"JKH","pdf_upload":"64be24aa463d7.jpg","type":"1","adhar_card_back":"https://developmentalphawizz.com/ramnaam/uploads/profile_pics/64be24aa462b9.jpg","vendor_plan":""}]
/// image_path : "https://developmentalphawizz.com/ramnaam/uploads/profile_pics/"

class GetProfileModel {
  GetProfileModel({
      String? responseCode, 
      String? message, 
      String? status, 
      List<Data>? data, 
      String? imagePath,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _data = data;
    _imagePath = imagePath;
}

  GetProfileModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _imagePath = json['image_path'];
  }
  String? _responseCode;
  String? _message;
  String? _status;
  List<Data>? _data;
  String? _imagePath;
GetProfileModel copyWith({  String? responseCode,
  String? message,
  String? status,
  List<Data>? data,
  String? imagePath,
}) => GetProfileModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  data: data ?? _data,
  imagePath: imagePath ?? _imagePath,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  List<Data>? get data => _data;
  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['image_path'] = _imagePath;
    return map;
  }

}

/// id : "3"
/// email : "shivanialphawizz@gmail.com"
/// mobile : "7484848754"
/// uname : "shiavni"
/// address : "Indore, Madhya Pradesh, India"
/// description : ""
/// category_id : null
/// per_d_charge : null
/// per_h_charge : null
/// experience : null
/// vehicle_number : null
/// vehicle_type : null
/// rc_book : null
/// per_km_charge : null
/// password : "25d55ad283aa400af464c76d713c07ad"
/// profile_image : "https://developmentalphawizz.com/ramnaam/uploads/profile_pics/64be24aa46178.jpg"
/// device_token : "cr4JQYOVTI6IM-03S0oUhs:APA91bFxmxH-ze-b6Q6qQoTcnkhy2rpHkCGAZ9MR2kHTFiv1rbiA1SFefiVzVuxIHFhx24UjHBECWuNrPUwOC4dSriYcPwg_blxUjUV_zIm86TAUw9dqDYnjMj8ryAXlpF70G4_GGLGF"
/// otp : "4601"
/// status : "1"
/// wallet : "0.00"
/// balance : "0.00"
/// last_login : null
/// created_at : "2023-07-24 07:13:46"
/// updated_at : "2023-08-11 08:18:49"
/// roll : "7"
/// adhar_card : "https://developmentalphawizz.com/ramnaam/uploads/profile_pics/64be24aa458ff.jpg"
/// pancard : "https://developmentalphawizz.com/ramnaam/uploads/profile_pics/64be24aa462b9.jpg"
/// gst_no : ""
/// fssai : ""
/// store_name : ""
/// band_details : {"bank_name":"","account_number":"","account_holder_name":"","ifsc_code":"","account_type":""}
/// vehicle_no : ""
/// registarion_card : ""
/// driving_license : ""
/// categories_id : "37,38,40"
/// company_name : ""
/// role_user : ""
/// event : ""
/// latitude : "22.7195687"
/// longitude : "75.8577258"
/// delivery_type : ""
/// refferal_code : ""
/// friend_code : ""
/// online_status : "1"
/// store_description : ""
/// commision : ""
/// resto_type : ""
/// gender : null
/// cash_collection : "0"
/// commision_amount_type : ""
/// transport : ""
/// pincode : "452010"
/// area : "medanta"
/// city : "Indore"
/// state : "Madhya Pardesh"
/// reffral_code : ""
/// educational_qualification : "dfs"
/// professional_qualification : "JNKJNH"
/// sanskrit_qualification : "KJH"
/// languages : "KJH"
/// caste : "Brahmin"
/// veda_studies : "JKH"
/// pdf_upload : "64be24aa463d7.jpg"
/// type : "1"
/// adhar_card_back : "https://developmentalphawizz.com/ramnaam/uploads/profile_pics/64be24aa462b9.jpg"
/// vendor_plan : ""

class Data {
  Data({
      String? id, 
      String? email, 
      String? mobile, 
      String? uname, 
      String? address, 
      String? description, 
      dynamic categoryId, 
      dynamic perDCharge, 
      dynamic perHCharge, 
      dynamic experience, 
      dynamic vehicleNumber, 
      dynamic vehicleType, 
      dynamic rcBook, 
      dynamic perKmCharge, 
      String? password, 
      String? profileImage, 
      String? deviceToken, 
      String? otp, 
      String? status, 
      String? wallet, 
      String? balance, 
      dynamic lastLogin, 
      String? createdAt, 
      String? updatedAt, 
      String? roll, 
      String? adharCard, 
      String? pancard, 
      String? gstNo, 
      String? fssai, 
      String? storeName, 
      BandDetails? bandDetails, 
      String? vehicleNo, 
      String? registarionCard, 
      String? drivingLicense, 
      String? categoriesId, 
      String? companyName, 
      String? roleUser, 
      String? event, 
      String? latitude, 
      String? longitude, 
      String? deliveryType, 
      String? refferalCode, 
      String? friendCode, 
      String? onlineStatus, 
      String? storeDescription, 
      String? commision, 
      String? restoType, 
      dynamic gender, 
      String? cashCollection, 
      String? commisionAmountType, 
      String? transport, 
      String? pincode, 
      String? area, 
      String? city, 
      String? state, 
      String? reffralCode, 
      String? educationalQualification, 
      String? professionalQualification, 
      String? sanskritQualification, 
      String? languages, 
      String? caste, 
      String? vedaStudies, 
      String? pdfUpload, 
      String? type, 
      String? adharCardBack, 
      String? vendorPlan,}){
    _id = id;
    _email = email;
    _mobile = mobile;
    _uname = uname;
    _address = address;
    _description = description;
    _categoryId = categoryId;
    _perDCharge = perDCharge;
    _perHCharge = perHCharge;
    _experience = experience;
    _vehicleNumber = vehicleNumber;
    _vehicleType = vehicleType;
    _rcBook = rcBook;
    _perKmCharge = perKmCharge;
    _password = password;
    _profileImage = profileImage;
    _deviceToken = deviceToken;
    _otp = otp;
    _status = status;
    _wallet = wallet;
    _balance = balance;
    _lastLogin = lastLogin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _roll = roll;
    _adharCard = adharCard;
    _pancard = pancard;
    _gstNo = gstNo;
    _fssai = fssai;
    _storeName = storeName;
    _bandDetails = bandDetails;
    _vehicleNo = vehicleNo;
    _registarionCard = registarionCard;
    _drivingLicense = drivingLicense;
    _categoriesId = categoriesId;
    _companyName = companyName;
    _roleUser = roleUser;
    _event = event;
    _latitude = latitude;
    _longitude = longitude;
    _deliveryType = deliveryType;
    _refferalCode = refferalCode;
    _friendCode = friendCode;
    _onlineStatus = onlineStatus;
    _storeDescription = storeDescription;
    _commision = commision;
    _restoType = restoType;
    _gender = gender;
    _cashCollection = cashCollection;
    _commisionAmountType = commisionAmountType;
    _transport = transport;
    _pincode = pincode;
    _area = area;
    _city = city;
    _state = state;
    _reffralCode = reffralCode;
    _educationalQualification = educationalQualification;
    _professionalQualification = professionalQualification;
    _sanskritQualification = sanskritQualification;
    _languages = languages;
    _caste = caste;
    _vedaStudies = vedaStudies;
    _pdfUpload = pdfUpload;
    _type = type;
    _adharCardBack = adharCardBack;
    _vendorPlan = vendorPlan;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _mobile = json['mobile'];
    _uname = json['uname'];
    _address = json['address'];
    _description = json['description'];
    _categoryId = json['category_id'];
    _perDCharge = json['per_d_charge'];
    _perHCharge = json['per_h_charge'];
    _experience = json['experience'];
    _vehicleNumber = json['vehicle_number'];
    _vehicleType = json['vehicle_type'];
    _rcBook = json['rc_book'];
    _perKmCharge = json['per_km_charge'];
    _password = json['password'];
    _profileImage = json['profile_image'];
    _deviceToken = json['device_token'];
    _otp = json['otp'];
    _status = json['status'];
    _wallet = json['wallet'];
    _balance = json['balance'];
    _lastLogin = json['last_login'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _roll = json['roll'];
    _adharCard = json['adhar_card'];
    _pancard = json['pancard'];
    _gstNo = json['gst_no'];
    _fssai = json['fssai'];
    _storeName = json['store_name'];
    _bandDetails = json['band_details'] != null ? BandDetails.fromJson(json['band_details']) : null;
    _vehicleNo = json['vehicle_no'];
    _registarionCard = json['registarion_card'];
    _drivingLicense = json['driving_license'];
    _categoriesId = json['categories_id'];
    _companyName = json['company_name'];
    _roleUser = json['role_user'];
    _event = json['event'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _deliveryType = json['delivery_type'];
    _refferalCode = json['refferal_code'];
    _friendCode = json['friend_code'];
    _onlineStatus = json['online_status'];
    _storeDescription = json['store_description'];
    _commision = json['commision'];
    _restoType = json['resto_type'];
    _gender = json['gender'];
    _cashCollection = json['cash_collection'];
    _commisionAmountType = json['commision_amount_type'];
    _transport = json['transport'];
    _pincode = json['pincode'];
    _area = json['area'];
    _city = json['city'];
    _state = json['state'];
    _reffralCode = json['reffral_code'];
    _educationalQualification = json['educational_qualification'];
    _professionalQualification = json['professional_qualification'];
    _sanskritQualification = json['sanskrit_qualification'];
    _languages = json['languages'];
    _caste = json['caste'];
    _vedaStudies = json['veda_studies'];
    _pdfUpload = json['pdf_upload'];
    _type = json['type'];
    _adharCardBack = json['adhar_card_back'];
    _vendorPlan = json['vendor_plan'];
  }
  String? _id;
  String? _email;
  String? _mobile;
  String? _uname;
  String? _address;
  String? _description;
  dynamic _categoryId;
  dynamic _perDCharge;
  dynamic _perHCharge;
  dynamic _experience;
  dynamic _vehicleNumber;
  dynamic _vehicleType;
  dynamic _rcBook;
  dynamic _perKmCharge;
  String? _password;
  String? _profileImage;
  String? _deviceToken;
  String? _otp;
  String? _status;
  String? _wallet;
  String? _balance;
  dynamic _lastLogin;
  String? _createdAt;
  String? _updatedAt;
  String? _roll;
  String? _adharCard;
  String? _pancard;
  String? _gstNo;
  String? _fssai;
  String? _storeName;
  BandDetails? _bandDetails;
  String? _vehicleNo;
  String? _registarionCard;
  String? _drivingLicense;
  String? _categoriesId;
  String? _companyName;
  String? _roleUser;
  String? _event;
  String? _latitude;
  String? _longitude;
  String? _deliveryType;
  String? _refferalCode;
  String? _friendCode;
  String? _onlineStatus;
  String? _storeDescription;
  String? _commision;
  String? _restoType;
  dynamic _gender;
  String? _cashCollection;
  String? _commisionAmountType;
  String? _transport;
  String? _pincode;
  String? _area;
  String? _city;
  String? _state;
  String? _reffralCode;
  String? _educationalQualification;
  String? _professionalQualification;
  String? _sanskritQualification;
  String? _languages;
  String? _caste;
  String? _vedaStudies;
  String? _pdfUpload;
  String? _type;
  String? _adharCardBack;
  String? _vendorPlan;
Data copyWith({  String? id,
  String? email,
  String? mobile,
  String? uname,
  String? address,
  String? description,
  dynamic categoryId,
  dynamic perDCharge,
  dynamic perHCharge,
  dynamic experience,
  dynamic vehicleNumber,
  dynamic vehicleType,
  dynamic rcBook,
  dynamic perKmCharge,
  String? password,
  String? profileImage,
  String? deviceToken,
  String? otp,
  String? status,
  String? wallet,
  String? balance,
  dynamic lastLogin,
  String? createdAt,
  String? updatedAt,
  String? roll,
  String? adharCard,
  String? pancard,
  String? gstNo,
  String? fssai,
  String? storeName,
  BandDetails? bandDetails,
  String? vehicleNo,
  String? registarionCard,
  String? drivingLicense,
  String? categoriesId,
  String? companyName,
  String? roleUser,
  String? event,
  String? latitude,
  String? longitude,
  String? deliveryType,
  String? refferalCode,
  String? friendCode,
  String? onlineStatus,
  String? storeDescription,
  String? commision,
  String? restoType,
  dynamic gender,
  String? cashCollection,
  String? commisionAmountType,
  String? transport,
  String? pincode,
  String? area,
  String? city,
  String? state,
  String? reffralCode,
  String? educationalQualification,
  String? professionalQualification,
  String? sanskritQualification,
  String? languages,
  String? caste,
  String? vedaStudies,
  String? pdfUpload,
  String? type,
  String? adharCardBack,
  String? vendorPlan,
}) => Data(  id: id ?? _id,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  uname: uname ?? _uname,
  address: address ?? _address,
  description: description ?? _description,
  categoryId: categoryId ?? _categoryId,
  perDCharge: perDCharge ?? _perDCharge,
  perHCharge: perHCharge ?? _perHCharge,
  experience: experience ?? _experience,
  vehicleNumber: vehicleNumber ?? _vehicleNumber,
  vehicleType: vehicleType ?? _vehicleType,
  rcBook: rcBook ?? _rcBook,
  perKmCharge: perKmCharge ?? _perKmCharge,
  password: password ?? _password,
  profileImage: profileImage ?? _profileImage,
  deviceToken: deviceToken ?? _deviceToken,
  otp: otp ?? _otp,
  status: status ?? _status,
  wallet: wallet ?? _wallet,
  balance: balance ?? _balance,
  lastLogin: lastLogin ?? _lastLogin,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  roll: roll ?? _roll,
  adharCard: adharCard ?? _adharCard,
  pancard: pancard ?? _pancard,
  gstNo: gstNo ?? _gstNo,
  fssai: fssai ?? _fssai,
  storeName: storeName ?? _storeName,
  bandDetails: bandDetails ?? _bandDetails,
  vehicleNo: vehicleNo ?? _vehicleNo,
  registarionCard: registarionCard ?? _registarionCard,
  drivingLicense: drivingLicense ?? _drivingLicense,
  categoriesId: categoriesId ?? _categoriesId,
  companyName: companyName ?? _companyName,
  roleUser: roleUser ?? _roleUser,
  event: event ?? _event,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  deliveryType: deliveryType ?? _deliveryType,
  refferalCode: refferalCode ?? _refferalCode,
  friendCode: friendCode ?? _friendCode,
  onlineStatus: onlineStatus ?? _onlineStatus,
  storeDescription: storeDescription ?? _storeDescription,
  commision: commision ?? _commision,
  restoType: restoType ?? _restoType,
  gender: gender ?? _gender,
  cashCollection: cashCollection ?? _cashCollection,
  commisionAmountType: commisionAmountType ?? _commisionAmountType,
  transport: transport ?? _transport,
  pincode: pincode ?? _pincode,
  area: area ?? _area,
  city: city ?? _city,
  state: state ?? _state,
  reffralCode: reffralCode ?? _reffralCode,
  educationalQualification: educationalQualification ?? _educationalQualification,
  professionalQualification: professionalQualification ?? _professionalQualification,
  sanskritQualification: sanskritQualification ?? _sanskritQualification,
  languages: languages ?? _languages,
  caste: caste ?? _caste,
  vedaStudies: vedaStudies ?? _vedaStudies,
  pdfUpload: pdfUpload ?? _pdfUpload,
  type: type ?? _type,
  adharCardBack: adharCardBack ?? _adharCardBack,
  vendorPlan: vendorPlan ?? _vendorPlan,
);
  String? get id => _id;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get uname => _uname;
  String? get address => _address;
  String? get description => _description;
  dynamic get categoryId => _categoryId;
  dynamic get perDCharge => _perDCharge;
  dynamic get perHCharge => _perHCharge;
  dynamic get experience => _experience;
  dynamic get vehicleNumber => _vehicleNumber;
  dynamic get vehicleType => _vehicleType;
  dynamic get rcBook => _rcBook;
  dynamic get perKmCharge => _perKmCharge;
  String? get password => _password;
  String? get profileImage => _profileImage;
  String? get deviceToken => _deviceToken;
  String? get otp => _otp;
  String? get status => _status;
  String? get wallet => _wallet;
  String? get balance => _balance;
  dynamic get lastLogin => _lastLogin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get roll => _roll;
  String? get adharCard => _adharCard;
  String? get pancard => _pancard;
  String? get gstNo => _gstNo;
  String? get fssai => _fssai;
  String? get storeName => _storeName;
  BandDetails? get bandDetails => _bandDetails;
  String? get vehicleNo => _vehicleNo;
  String? get registarionCard => _registarionCard;
  String? get drivingLicense => _drivingLicense;
  String? get categoriesId => _categoriesId;
  String? get companyName => _companyName;
  String? get roleUser => _roleUser;
  String? get event => _event;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get deliveryType => _deliveryType;
  String? get refferalCode => _refferalCode;
  String? get friendCode => _friendCode;
  String? get onlineStatus => _onlineStatus;
  String? get storeDescription => _storeDescription;
  String? get commision => _commision;
  String? get restoType => _restoType;
  dynamic get gender => _gender;
  String? get cashCollection => _cashCollection;
  String? get commisionAmountType => _commisionAmountType;
  String? get transport => _transport;
  String? get pincode => _pincode;
  String? get area => _area;
  String? get city => _city;
  String? get state => _state;
  String? get reffralCode => _reffralCode;
  String? get educationalQualification => _educationalQualification;
  String? get professionalQualification => _professionalQualification;
  String? get sanskritQualification => _sanskritQualification;
  String? get languages => _languages;
  String? get caste => _caste;
  String? get vedaStudies => _vedaStudies;
  String? get pdfUpload => _pdfUpload;
  String? get type => _type;
  String? get adharCardBack => _adharCardBack;
  String? get vendorPlan => _vendorPlan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['uname'] = _uname;
    map['address'] = _address;
    map['description'] = _description;
    map['category_id'] = _categoryId;
    map['per_d_charge'] = _perDCharge;
    map['per_h_charge'] = _perHCharge;
    map['experience'] = _experience;
    map['vehicle_number'] = _vehicleNumber;
    map['vehicle_type'] = _vehicleType;
    map['rc_book'] = _rcBook;
    map['per_km_charge'] = _perKmCharge;
    map['password'] = _password;
    map['profile_image'] = _profileImage;
    map['device_token'] = _deviceToken;
    map['otp'] = _otp;
    map['status'] = _status;
    map['wallet'] = _wallet;
    map['balance'] = _balance;
    map['last_login'] = _lastLogin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['roll'] = _roll;
    map['adhar_card'] = _adharCard;
    map['pancard'] = _pancard;
    map['gst_no'] = _gstNo;
    map['fssai'] = _fssai;
    map['store_name'] = _storeName;
    if (_bandDetails != null) {
      map['band_details'] = _bandDetails?.toJson();
    }
    map['vehicle_no'] = _vehicleNo;
    map['registarion_card'] = _registarionCard;
    map['driving_license'] = _drivingLicense;
    map['categories_id'] = _categoriesId;
    map['company_name'] = _companyName;
    map['role_user'] = _roleUser;
    map['event'] = _event;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['delivery_type'] = _deliveryType;
    map['refferal_code'] = _refferalCode;
    map['friend_code'] = _friendCode;
    map['online_status'] = _onlineStatus;
    map['store_description'] = _storeDescription;
    map['commision'] = _commision;
    map['resto_type'] = _restoType;
    map['gender'] = _gender;
    map['cash_collection'] = _cashCollection;
    map['commision_amount_type'] = _commisionAmountType;
    map['transport'] = _transport;
    map['pincode'] = _pincode;
    map['area'] = _area;
    map['city'] = _city;
    map['state'] = _state;
    map['reffral_code'] = _reffralCode;
    map['educational_qualification'] = _educationalQualification;
    map['professional_qualification'] = _professionalQualification;
    map['sanskrit_qualification'] = _sanskritQualification;
    map['languages'] = _languages;
    map['caste'] = _caste;
    map['veda_studies'] = _vedaStudies;
    map['pdf_upload'] = _pdfUpload;
    map['type'] = _type;
    map['adhar_card_back'] = _adharCardBack;
    map['vendor_plan'] = _vendorPlan;
    return map;
  }

}

/// bank_name : ""
/// account_number : ""
/// account_holder_name : ""
/// ifsc_code : ""
/// account_type : ""

class BandDetails {
  BandDetails({
      String? bankName, 
      String? accountNumber, 
      String? accountHolderName, 
      String? ifscCode, 
      String? accountType,}){
    _bankName = bankName;
    _accountNumber = accountNumber;
    _accountHolderName = accountHolderName;
    _ifscCode = ifscCode;
    _accountType = accountType;
}

  BandDetails.fromJson(dynamic json) {
    _bankName = json['bank_name'];
    _accountNumber = json['account_number'];
    _accountHolderName = json['account_holder_name'];
    _ifscCode = json['ifsc_code'];
    _accountType = json['account_type'];
  }
  String? _bankName;
  String? _accountNumber;
  String? _accountHolderName;
  String? _ifscCode;
  String? _accountType;
BandDetails copyWith({  String? bankName,
  String? accountNumber,
  String? accountHolderName,
  String? ifscCode,
  String? accountType,
}) => BandDetails(  bankName: bankName ?? _bankName,
  accountNumber: accountNumber ?? _accountNumber,
  accountHolderName: accountHolderName ?? _accountHolderName,
  ifscCode: ifscCode ?? _ifscCode,
  accountType: accountType ?? _accountType,
);
  String? get bankName => _bankName;
  String? get accountNumber => _accountNumber;
  String? get accountHolderName => _accountHolderName;
  String? get ifscCode => _ifscCode;
  String? get accountType => _accountType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank_name'] = _bankName;
    map['account_number'] = _accountNumber;
    map['account_holder_name'] = _accountHolderName;
    map['ifsc_code'] = _ifscCode;
    map['account_type'] = _accountType;
    return map;
  }

}