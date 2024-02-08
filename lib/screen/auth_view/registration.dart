import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/new%20model/registration_model.dart';
import 'package:fixerking/screen/auth_view/login.dart';
import 'package:fixerking/utility_widget/customLoader.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/entities/location_result.dart';

import '../../modal/StateModel.dart';
import '../../new model/cities_model.dart';
import '../../new model/event_category_model.dart';
import '../../validation/form_validation.dart';
import '../location_details.dart';

class VendorRegisteration extends StatefulWidget {
  final String role;
  final double? lat, long;
  const VendorRegisteration({Key? key, required this.role, this.lat, this.long}) : super(key: key);

  @override
  State<VendorRegisteration> createState() => _VendorRegisterationState();
}

class _VendorRegisterationState extends State<VendorRegisteration> {

  String? bankValue;
  CityData? cityValue;
  StataData? stateValue;
  String? catValue;
  var accTypeValue;
  File? rcImage;
  String? stateName;
  String? cityName;
  File? aadharImage;
  File? aadharBack;
  File? profileImage;
  File? catalogImage;
  File? panImage;
  File? drivingImage;

  String? type;
  String? appBarTitle;
  String? restroType;

  int _value = 1;
  int? _value1 = 1;
  int? _value2 = 1;
  int? _value3 = 1;

  String? gender;
  bool isUpi = false;
  bool roleUser = true;
  List _selectedItems = [];
  List selectedCategoryItems = [];
  String? selectCatItems;
  bool isLoading = false;
  bool pass = true;
  bool cPass = true;

  getLocation() {
    GetLocation location = new GetLocation((result) {
      if (mounted) {
        setState(() {
         String address = result.first.addressLine;
          pickLat = result.first.coordinates.latitude;
          pickLong = result.first.coordinates.longitude;
          addressController.text = address;
        });
      }
    });
    location.getLoc();
  }


  // Future<ServiceCategoryModel?> getServiceCategory() async {
  //   // var userId = await MyToken.getUserID();
  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //         '${Apipath.BASH_URL}get_categories_list',
  //       ));
  //   print(request);
  //
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     final str = await response.stream.bytesToString();
  //     return ServiceCategoryModel.fromJson(json.decode(str));
  //   } else {
  //     return null;
  //   }
  // }

  void _showMultiSelect() async {

    final List? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState)
        {
          return
            MultiSelect(type: type.toString(),);
        }
        );
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
      selectedCategoryItems = results.map((item) => item.id).toList();
      selectCatItems = selectedCategoryItems.join(',');
      print("this is result == ${_selectedItems.toString()} aaaaand ${selectedCategoryItems.toString()} &&&&&& ${selectCatItems.toString()}");
    }
  }


  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fssaiController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  TextEditingController accountHolderController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController confmAccountNumController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController referallController = TextEditingController();
  TextEditingController storeDescriptionController = TextEditingController();
  TextEditingController educationCtr = TextEditingController();
  TextEditingController professionalCtr = TextEditingController();
  TextEditingController sanskritCtr = TextEditingController();
  TextEditingController languageCtr = TextEditingController();
  TextEditingController vedaCtr = TextEditingController();
  TextEditingController yearBusinessCtr = TextEditingController();
  TextEditingController locationCoveredCtr = TextEditingController();
  TextEditingController casteCtr = TextEditingController();
  TextEditingController testimonialsCtr = TextEditingController();
  TextEditingController pincodeCtr = TextEditingController();
  TextEditingController areaCtr = TextEditingController();

  void containerForSheet<T>({BuildContext? context, Widget? child}) {
    showCupertinoModalPopup<T>(
      context: context!,
      builder: (BuildContext context) => child!,
    ).then<void>((T? value) {});
  }


  Future<void> getAadharBackFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        aadharBack = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
      print("this is image path from camera ${aadharBack.toString()}");
    }
  }

  Future<void> getAadharBackFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        aadharBack = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  Future<void> getProfileFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
      print("this is image path from camera ${profileImage.toString()}");

    }

  }

  Future<void> getProfileFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  uploadPanFromCamOrGallary(BuildContext context) {
    containerForSheet<String>(
      context: context,
      child: CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              "Camera",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getPanFromCamera();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "Photo & Video Library",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getPanFromGallery();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          isDefaultAction: true,
          onPressed: () {
            // Navigator.pop(context, 'Cancel');
            Navigator.of(context, rootNavigator: true).pop("Discard");
          },
        ),
      ),
    );
  }

  Future<void> getPanFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        panImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  Future<void> getPanFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        panImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  Future<void> getdrivingFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        drivingImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  Future<void> getdrivingFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        drivingImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  Widget imageRC() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          requestPermission(context, 3);
          // uploadRCFromCamOrGallary(context);
        },
        child: Center(
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: rcImage != null
                  ? Image.file(rcImage!, fit: BoxFit.cover)
                  : Column(
                children: [
                  Center(
                      child: Icon(Icons.upload_file_outlined, size: 60)),
                  Text("Registration Card")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageAadhar() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          showAlertDialog(context, "aadharImage");
          // getImage(ImgSource.Both, context,1);
          // requestPermission(context, 1);
          //uploadAadharFromCamOrGallary(context);
        },
        child: Center(
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: aadharImage != null
                  ? Image.file(aadharImage!, fit: BoxFit.cover)
                  : Column(
                children: [
                  Center(
                      child: Icon(Icons.upload_file_outlined, size: 60)),
                  Text("Aadhaar Card")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget imageProfile() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          showAlertDialog(context, "profileImage");
          // requestPermission(context, 1);
          //uploadAadharFromCamOrGallary(context);
        },
        child: Center(
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: profileImage != null
                  ? Image.file(profileImage!, fit: BoxFit.cover)
                  : Column(
                children: [
                  Center(
                      child: Icon(Icons.upload_file_outlined, size: 60)),
                  Text("Profile Imaage")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String type) {
    AlertDialog alert = AlertDialog(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Container(
            height: 250,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 5,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Select Any One Option',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        print(type);
                        Navigator.of(context).pop();
                        // pickImage(ImageSource.gallery, type);
                        pickImage(ImageSource.gallery, type);
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: const Center(child: Text('Select From Gallery')),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        print(type);
                        Navigator.of(context).pop();
                        pickImage(ImageSource.camera, type);
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(child: Text('Select From Camera')),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Widget imageCatalog() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          showAlertDialog(context, "catalogImage");
          // getImage(ImgSource.Both, context, 7);
          // pickImage(ImageSource.gallery, type!);
        },
        child: Center(
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
             child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: catalogImage != null
                  ? Image.file(catalogImage!, fit: BoxFit.cover)
                  : Column(
                children: [
                  Center(
                      child: Icon(Icons.upload_file_outlined, size: 60)
                  ),
                  Text("Image Catalog")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageAadharBack() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          showAlertDialog(context, "aadharBackImage");
          // getImage(ImgSource.Both, context, 5);
        },
        child: Center(
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: aadharBack != null
                  ? Image.file(aadharBack!, fit: BoxFit.cover)
                  : Column(
                  children: [
                  Center(
                      child: Icon(Icons.upload_file_outlined, size: 60)),
                  Text("Aadhaar Card Back")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePan() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          showAlertDialog(context, "pancard");
          // requestPermission(context, 2);
          // uploadPanFromCamOrGallary(context);
        },
        child: Center(
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: panImage != null
                  ? Image.file(panImage!, fit: BoxFit.cover)
                  : Column(
                children: [
                  Center(
                      child: Icon(Icons.upload_file_outlined, size: 60)),
                  Text("Pan Card")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagedriving() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          requestPermission(context, 4);
          // uploaddrivingFromCamOrGallary(context);
        },
        child: Center(
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: drivingImage != null
                  ? Image.file(drivingImage!, fit: BoxFit.cover)
                  : Column(
                children: const [
                  Center(
                      child: Icon(Icons.upload_file_outlined, size: 60)),
                  Text("Driving License"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  submitRequest() async {
    // showDialog(context: context, builder: (context){
    //   return CustomLoader(text: "Verifying user, please wait...",);
    // });
    print("checking date submit request");
    var headers = {'Cookie': 'ci_session=cf2fmpq7vue0kthvj5s046uv4m2j5r11'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.vendorRegistrationUrl}'));
    request.fields.addAll({
      'type': "$type",
      'name': '${nameController.text.toString()}',
      'mobile': '${mobileController.text.toString()}',
      'email': '${emailController.text}',
      'lat': '22.7533',
      'lang': '${pickLong.toString()}',
      'address': '${addressController.text.toString()}',
      'password': "${passwordCtr.text}",
      // "educational_qualification": educationCtr.text,
      // "pincode": pincodeCtr.text,
      // "area" : areaCtr.text,
      // "state" : stateName.toString(),
      // "city" : cityName.toString(),
      // "year_in_business" : yearBusinessCtr.text,
      // "locations_covered": locationCoveredCtr.text,
      // "testimonials": testimonialsCtr.text,
      // "professional_qualification" : professionalCtr.text,
      // "sanskrit_qualification": sanskritCtr.text,
      // "caste" : casteCtr.text,
      // "languages" : languageCtr.text,
      // "veda_studies" : vedaCtr.text,
      //  "service_category": selectCatItems.toString()
      // 'bank_upi': isUpi
      //     ? '{"account_holder_name" : "${accountHolderController.text.toString()}","account_number" : "${accountNoController.text.toString()}","bank_name" : "${bankNameController.text.toString()}","account_type": "${accTypeValue.toString()}","ifsc_code" : "${ifscController.text.toString()}"}'
      //     : '{"UPI" : "${upiController.text.toString()}"}'
    });

    print("api url here and parameter here ${Apipath.vendorRegistrationUrl} ${request.fields}");

    ///orderfood
    // if (type == "1") {
    //   request.fields.addAll({
    //     'store_name': '${storeNameController.text.toString()}',
    //     'fssai': '${fssaiController.text.toString()}',
    //     'categories_id': '${selectCatItems.toString()}',
    //     'gst_no': '${gstController.text.toString()}',
    //     'store_description': '${storeDescriptionController.text.toString()}',
    //     'restro_type': '${restroType.toString()}'
    //   });
    // }

    // if (aadharImage != null) {
    //   request.files.add(
    //       await http.MultipartFile.fromPath('adhar_card', aadharImage!.path));
    // }
    // if (aadharBack != null) {
    //   request.files.add(
    //       await http.MultipartFile.fromPath('adhar_back', aadharBack!.path));
    // }
    // if (profileImage != null) {
    //   request.files.add(
    //       await http.MultipartFile.fromPath('profile_image', profileImage!.path));
    // }
    // if (panImage != null) {
    //   request.files.add(await http.MultipartFile.fromPath('pancard', panImage!.path));
    // }
    // if (catalogImage != null) {
    //   request.files.add(
    //       await http.MultipartFile.fromPath('pdf_upload', catalogImage!.path));
    // }

    // String delType = '';
    // if(deliveryTypeValue == "Delivery Only") {
    //   setState(() {
    //     delType = 'delivery_only';
    //   });
    // } else if(deliveryTypeValue == "Ride Only") {
    //   setState(() {
    //     delType = 'ride_only';
    //   });
    // } else {
    //   setState(() {
    //     delType = 'both';
    //   });
    // }

    // ///2wheeler
    // if (type == "2" || type == "3" || type == "4") {
    //   request.fields.addAll({
    //     'vehicle_no': '${vehicleController.text.toString()}',
    //     'city_id': '${categoryValue.toString()}',
    //     'delivery_type' : '${delType.toString()}'
    //   });
    //   if (rcImage != null) {
    //     request.files.add(await http.MultipartFile.fromPath(
    //         'registarion_card', rcImage!.path));
    //   }
    //   if (drivingImage != null) {
    //     request.files.add(await http.MultipartFile.fromPath(
    //         'driving_license', drivingImage!.path));
    //   }
    // }
    //
    // ///Event
    // if (type == "5") {
    //   request.fields.addAll({
    //     'city_id': '${categoryValue.toString()}',
    //     'categories_id': '${selectCatItems.toString()}',
    //     //'gst_no' :  '${gstController.text.toString()}',
    //     //'role_user': roleUser ? 'company' : 'freelancer' ,
    //     'gender': '$gender'
    //   });
    // }
    //
    // if (type == "6") {
    //   request.fields.addAll({
    //     'city_id': '${categoryValue.toString()}',
    //     'categories_id': '${selectCatItems.toString()}',
    //     //'gst_no' :  '${gstController.text.toString()}',
    //     'role_user': roleUser ? 'company' : 'freelancer' ,
    //   });
    // }
    //
    // ///pandit ji
    // if (type == "7") {
    //   request.fields.addAll({
    //     'city_id': '${categoryValue.toString()}',
    //     'categories_id': '${selectCatItems.toString()}',
    //    // 'gst_no' : '${gstController.text.toString()}',
    //    // 'role_user': roleUser ? 'company' : 'freelancer' ,
    //   });
    // }
    //
    // /// tent house
    // if(type == "8"){
    //   request.fields.addAll({
    //     'store_name': '${storeNameController.text.toString()}',
    //     'fssai': '${fssaiController.text.toString()}',
    //     'gst_no': '${gstController.text.toString()}',
    //     'categories_id': '${selectCatItems.toString()}',
    //     'store_description': '${storeDescriptionController.text.toString()}',
    //   });
    // }

    print("ok++++++++======>>>> ${request.fields} ${request.files}");
    request.headers.addAll(headers);
    var response = await request.send();
    String str = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print("this is respoinse @@ ${response.statusCode}");
      var result = json.decode(str);
      final jsonResponse = RegistrationModel.fromJson(result);
      if(jsonResponse.status == true) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()
              //BottomBar()
            ));
      } else {
        setState((){
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
      }
    } else {
      Fluttertoast.showToast(msg: "Error during communication : server error");
      print(response.reasonPhrase);
    }
  }

  void requestPermission(BuildContext context,int i) async {
    var status = await Permission.storage.request();
    if(status.isGranted) {
      // pickImage(ImageSource.Both, context, i);
    } else if(status.isPermanentlyDenied){
      openAppSettings();
    }

//     if (await Permission.camera.isRestricted || await Permission.storage.isRestricted) {
//       openAppSettings();
//     }
//     else{
//       Map<Permission, PermissionStatus> statuses = await [
//         Permission.camera,
//         Permission.storage,
//       ].request();
// // You can request multiple permissions at once.
//
//       if(statuses[Permission.camera]==PermissionStatus.granted&&statuses[Permission.storage]==PermissionStatus.granted){
//         getImage(ImgSource.Both, context,i);
//
//       }else{
//         if (await Permission.camera.isDenied||await Permission.storage.isDenied) {
//           openAppSettings();
//         }else{
//           setSnackbar("Oops you just denied the permission", context);
//         }
//       }
//     }
  }
  // File? _image,_finalImage,panImage,vehicleImage,adharImage,insuranceImage,bankImage;

  // Future getImage(ImgSource source, BuildContext context,int i) async {
  //   var image = await ImagePickerGC.pickImage(
  //     context: context,
  //     source: source,
  //     cameraIcon: Icon(
  //       Icons.add,
  //       color: Colors.red,
  //     ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
  //   );
  //   getCropImage(context, i, image);
  // }
  // void getCropImage(BuildContext context,int i,var image) async {
  //   CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
  //       sourcePath: image.path,
  //       aspectRatioPresets: [
  //         CropAspectRatioPreset.square,
  //         CropAspectRatioPreset.ratio3x2,
  //         CropAspectRatioPreset.original,
  //         CropAspectRatioPreset.ratio4x3,
  //         CropAspectRatioPreset.ratio16x9
  //       ],
  //       // androidUiSettings: AndroidUiSettings(
  //       //     toolbarTitle: 'Cropper',
  //       //     toolbarColor: Colors.lightBlueAccent,
  //       //     toolbarWidgetColor: Colors.white,
  //       //     initAspectRatio: CropAspectRatioPreset.original,
  //       //     lockAspectRatio: false),
  //       // iosUiSettings: IOSUiSettings(
  //       //   minimumAspectRatio: 1.0,
  //       // )
  //   );
  //   setState(() {
  //     if(i==1){
  //       aadharImage = File(croppedFile!.path);
  //     }else  if(i==2) {
  //       panImage = File(croppedFile!.path);
  //     }else  if(i==4) {
  //       drivingImage = File(croppedFile!.path);
  //     }else if(i==3) {
  //       rcImage = File(croppedFile!.path);
  //     }
  //     else if(i==5) {
  //       aadharBack = File(croppedFile!.path);
  //     }
  //     else if(i==6) {
  //       profileImage = File(croppedFile!.path);
  //     }
  //     else if(i==7) {
  //       catalogImage = File(croppedFile!.path);
  //     }
  //     // else if(i==6){
  //     //   insuranceImage = File(croppedFile!.path);
  //     // }
  //     // else if(i==7){
  //     //   bankImage = File(croppedFile!.path);
  //     // }
  //     // else{
  //     //   _finalImage = File(croppedFile!.path);
  //     // }
  //   });
  // }

  Future<void> pickImage(ImageSource source, String type) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxHeight: 100,
      maxWidth: 100,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      setState(() {
        if (type == 'catalogImage') {
          catalogImage = File(pickedFile.path);
        }
        else if (type == 'profileImage') {
          profileImage = File(pickedFile.path);
        }
        else if (type == 'aadharImage') {
          aadharImage = File(pickedFile.path);
        }
        else if (type == 'aadharBackImage') {
          aadharBack = File(pickedFile.path);
        }
        else if (type == 'pancard') {
           panImage = File(pickedFile.path);
        }
      });
    }
  }

  manageRole() {
    if (widget.role == "Grocery") {
      setState(() {
        type = "1";
        appBarTitle = "Grocery";
      });
    } else if (widget.role == "Caters") {
      setState(() {
        type = "5";
        appBarTitle = "Caters";
      });
    } else if (widget.role == "Photographer") {
      setState(() {
        type = "6";
        appBarTitle = "Photographer";
      });
    } else if (widget.role == "Purohit") {
      setState(() {
        type = "7";
        appBarTitle = "Purohit";
      });
    } else if (widget.role == "Tent House") {
      setState(() {
        type = "8";
        appBarTitle = "Tent House";
      });
    }
    // } else if (widget.role == "Event Planner") {
    //   setState(() {
    //     type = "6";
    //     appBarTitle = "Event";
    //   });
    // } else if (widget.role == "Handy Man Services") {
    //   setState(() {
    //     type = "7";
    //     appBarTitle = "Handy Man";
    //   });
    // }
  }

  List<CityData> cityList = [];
  List<StataData> stateList = [];
  List<Categories> eventCat = [];

  List accountType = [
    'Savings',
    'Current'
  ];
  double? pickLat;
  double? pickLong;

  // _getPickLocation() async {
  //   LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => PlacePicker(
  //         "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
  //       )));
  //   print(
  //       "checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
  //   setState(() {
  //     addressController.text = result.formattedAddress.toString();
  //     pickLat = result.latLng!.latitude.toString();
  //     pickLong = result.latLng!.longitude.toString();
  //     // cityC.text = result.locality.toString();
  //     // stateC.text = result.administrativeAreaLevel1!.name.toString();
  //     // countryC.text = result.country!.name.toString();
  //     // lat = result.latLng!.latitude;
  //     // long = result.latLng!.longitude;
  //     // pincodeC.text = result.postalCode.toString();
  //   });
  //   print("this is picked LAT LONG $pickLat @@ $pickLong");
  // }


  _getState() async {
    var uri = Uri.parse('${Apipath.getStateUrl}');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
   print("nwewhewjhjwhjj");
    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        stateList = StateModel.fromJson(userData).data!;
      });
    }
    print(responseData);
  }

  _getCities(String? sId,) async {
    var uri = Uri.parse('${Apipath.getCitiesUrl}');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    // print(baseUrl.toString());

    request.headers.addAll(headers);
    request.fields['state_id'] = sId.toString();
    print("ppppppppppppppppppppp ${request.fields}");
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        cityList = CityModel.fromJson(userData).data!;
      });
    }
    print(responseData);
  }

  _getEventCategory() async {
    var uri = Uri.parse('${Apipath.getEventCatUrl}');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields['type_id'] = "${type.toString()}";
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        // collectionModal = AllCateModel.fromJson(userData);
        eventCat = EventCategoryModel.fromJson(userData).data!;
        // print(
        //     "ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
      });
    }
    print(responseData);
  }
  String? token;

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
  }
  LocationPermission? permission;
  Position? currentLocation;

  Future getUserCurrentLocation() async {
    permission = await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition()
        .then((position) {
      if (mounted)
        setState(() {
          currentLocation = position;
          pickLat = currentLocation!.latitude;
          pickLong = currentLocation!.longitude;
        });
    });
    print("LOCATION===" + currentLocation.toString());
  }

  @override
  void initState() {
    super.initState();
    getToken();
    manageRole();
    _getState();
    _getEventCategory();
    getLocation();
     // getLocation();
    // getUserCurrentLocation();
  }


  final _formKey = GlobalKey<FormState>();

  String dropdownvalue = 'Haldi Event';
  String selectedLocation = 'Jaipur';
  String deliveryTypeValue = 'Delivery Only';

  var items = [
    'Birthday Party',
    'Photography',
    'Anniversary',
    'Kitty Party',
    'Haldi Event',
    'Mahila Sangeet',
    'Meeting',
    'Events',
    'Parties'
  ];

  var deliveryType = [
    'Ride Only',
    'Delivery Only',
    'Both'
  ];

  commonFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        // type == "5" || type == "6" || type == "7"
        //     ? Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Radio(
        //             value: 1,
        //             fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
        //             groupValue: _value1,
        //             onChanged: (int? value) {
        //               setState(() {
        //                 _value1 = value!;
        //                 roleUser = true;
        //                 // isUpi = false;
        //               });
        //             }),
        //         Text(
        //           "Company",
        //           style: TextStyle(color: AppColor().colorBg1()),
        //         ),
        //       ],
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Radio(
        //             fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
        //             value: 2,
        //             groupValue: _value1,
        //             onChanged: (int? value) {
        //               setState(() {
        //                 _value1 = value!;
        //                 roleUser = false;
        //                 // isUpi = true;
        //               });
        //             }),
        //
        //         Text(
        //           "Freelancer",
        //           style: TextStyle(color: AppColor().colorBg1()),
        //         ),
        //       ],
        //     ),
        //   ],
        // )
        //     : SizedBox.shrink(),
        // type == "2" ?
        // Padding(
        //   padding: const EdgeInsets.only(left: 15.0, right: 15),
        //   child: Container(
        //       padding: EdgeInsets.only(right: 12,left: 12,),
        //       // height: 50,
        //       width: MediaQuery.of(context).size.width,
        //       decoration:
        //       BoxDecoration(
        //         color: AppColor().colorBg1(),
        //         borderRadius: BorderRadius.circular(10),
        //         border: Border.all( color: AppColor().colorSecondary(),),
        //       ),
        //       child: DropdownButtonHideUnderline(
        //         child: DropdownButton<String>(
        //           dropdownColor:   AppColor().colorBg1(),
        //           value: deliveryTypeValue,
        //           icon:  Icon(Icons.keyboard_arrow_down_rounded,  color: AppColor().colorPrimary(),),
        //           elevation: 16,
        //           style:  TextStyle(color: AppColor().colorPrimary(),fontWeight: FontWeight.bold),
        //           underline: Container(
        //             // height: 2,
        //             color:  AppColor().colorBg1(),
        //           ),
        //           onChanged: (String? value) {
        //             // This is called when the user selects an item.
        //             setState(() {
        //               deliveryTypeValue = value!;
        //             });
        //           },
        //           items: deliveryType
        //               .map<DropdownMenuItem<String>>((String value) {
        //             return DropdownMenuItem<String>(
        //               value: value,
        //               child: Text(value),
        //             );
        //           }).toList(),
        //         ),
        //       ),
        //     // DropdownButtonHideUnderline(
        //     //   child: DropdownButton(
        //     //     // isExpanded: true,
        //     //     value: dropdownvalue,
        //     //     icon: const Icon(Icons.keyboard_arrow_down,size: 35,),
        //     //     elevation: 10,
        //     //     onChanged: (String? value) {
        //     //       setState(() {
        //     //         dropdownvalue = value!;
        //     //       });
        //     //       print("this is dropdown value ==========>$value");
        //     //     },
        //     //     items: items.map<DropdownMenuItem<String>>((String value) {
        //     //       return DropdownMenuItem<String>(
        //     //         value: value,
        //     //         child: Text(value),
        //     //       );
        //     //     }).toList(),
        //     //   ),
        //     // ),
        //   ),
        // )
        // : SizedBox.shrink(),
        // //  type == "6" || type == "7" ?
        // Padding(
        //   padding: const EdgeInsets.only(left: 10, bottom: 10),
        //   child: Text("I Wan't to provide services",
        //     style: TextStyle(
        //         color: AppColor().colorBg1()
        //     ),
        //   ),
        // ),    // : SizedBox.shrink(),
        // //   type == "6" || type == "7"
        // //?
        // InkWell(
        //   onTap: () {
        //     _showMultiSelect();
        //   },
        //   child: Container(
        //       width: MediaQuery.of(context).size.width,
        //       padding: EdgeInsets.only(left: 10),
        //       decoration: BoxDecoration(
        //           color: AppColor().colorBg1(),
        //           borderRadius: BorderRadius.circular(15),
        //           border: Border.all(color: Colors.black.withOpacity(0.7))),
        //       child: _selectedItems.isEmpty ?
        //       Padding(
        //         padding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
        //         child: Text(
        //           'Services',
        //           style: TextStyle(
        //             fontSize: 16,
        //             color: colors.primary,
        //             fontWeight: FontWeight.normal,
        //           ),
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ) :
        //       Wrap(
        //         children: _selectedItems
        //             .map((item){
        //           return Padding(
        //             padding: const EdgeInsets.only(left: 8.0, right: 8),
        //             child: Chip(
        //               backgroundColor: AppColor().colorPrimary(),
        //               label:
        //               Text(
        //                 "${item.cName}",
        //                 style: TextStyle(
        //                     color: AppColor().colorBg1()
        //                 ),
        //                 //item.name
        //               ),
        //             ),
        //           );
        //         }).toList(),
        //       )
        //     // FutureBuilder(
        //     //     future: getCities(),
        //     //     builder: (BuildContext context,
        //     //         AsyncSnapshot snapshot) {
        //     //       if (snapshot.hasData) {
        //     //         return DropdownButtonHideUnderline(
        //     //           child: DropdownButton2(
        //     //             isExpanded: true,
        //     //             hint: Row(
        //     //               children: [
        //     //                 Image.asset(
        //     //                   city,
        //     //                   width: 6.04.w,
        //     //                   height: 5.04.w,
        //     //                   fit: BoxFit.fill,
        //     //                   color: AppColor.PrimaryDark,
        //     //                 ),
        //     //                 SizedBox(
        //     //                   width: 4,
        //     //                 ),
        //     //                 Expanded(
        //     //                   child: Text(
        //     //                     'Select Multiple Cities',
        //     //                     style: TextStyle(
        //     //                       fontSize: 14,
        //     //                       fontWeight: FontWeight.normal,
        //     //                     ),
        //     //                     overflow: TextOverflow.ellipsis,
        //     //                   ),
        //     //                 ),
        //     //               ],
        //     //             ),
        //     //             items: cityList.map((item) {
        //     //               return DropdownMenuItem<String>(
        //     //                 value: item.id,
        //     //                 enabled: false,
        //     //                 child: StatefulBuilder(
        //     //                   builder: (context, menuSetState) {
        //     //                     final _isSelected =
        //     //                         selectedCities
        //     //                             .contains(item);
        //     //                     print("SLECTED CITY");
        //     //                     return InkWell(
        //     //                       onTap: () {
        //     //                         _isSelected
        //     //                             ? selectedCities
        //     //                                 .remove(item.id)
        //     //                             : selectedCities
        //     //                                 .add(item.id!);
        //     //                         setState(() {});
        //     //                         menuSetState(() {});
        //     //                       },
        //     //                       child: Container(
        //     //                         height: double.infinity,
        //     //                         padding: const EdgeInsets
        //     //                                 .symmetric(
        //     //                             horizontal: 16.0),
        //     //                         child: Row(
        //     //                           children: [
        //     //                             _isSelected
        //     //                                 ? const Icon(Icons
        //     //                                     .check_box_outlined)
        //     //                                 : const Icon(Icons
        //     //                                     .check_box_outline_blank),
        //     //                             const SizedBox(
        //     //                                 width: 16),
        //     //                             Text(
        //     //                               item.name!,
        //     //                               style:
        //     //                                   const TextStyle(
        //     //                                 fontSize: 14,
        //     //                               ),
        //     //                             ),
        //     //                           ],
        //     //                         ),
        //     //                       ),
        //     //                     );
        //     //                   },
        //     //                 ),
        //     //               );
        //     //             }).toList(),
        //     //             //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
        //     //             value: selectedCities.isEmpty
        //     //                 ? null
        //     //                 : selectedCities.last,
        //     //             onChanged: (value) {},
        //     //             buttonHeight: 50,
        //     //             buttonWidth: 160,
        //     //             buttonPadding: const EdgeInsets.only(
        //     //                 left: 14, right: 14),
        //     //             buttonDecoration: BoxDecoration(
        //     //               borderRadius:
        //     //                   BorderRadius.circular(14),
        //     //               color: Color(0xffF9F9F9),
        //     //             ),
        //     //             buttonElevation: 0,
        //     //             itemHeight: 40,
        //     //             itemPadding: const EdgeInsets.only(
        //     //                 left: 14, right: 14),
        //     //             dropdownMaxHeight: 300,
        //     //             dropdownPadding: null,
        //     //             dropdownDecoration: BoxDecoration(
        //     //               borderRadius:
        //     //                   BorderRadius.circular(14),
        //     //             ),
        //     //             dropdownElevation: 8,
        //     //             scrollbarRadius:
        //     //                 const Radius.circular(40),
        //     //             scrollbarThickness: 6,
        //     //             scrollbarAlwaysShow: true,
        //     //             selectedItemBuilder: (context) {
        //     //               return cityList.map(
        //     //                 (item) {
        //     //                   return Container(
        //     //                     // alignment: AlignmentDirectional.center,
        //     //                     padding:
        //     //                         const EdgeInsets.symmetric(
        //     //                             horizontal: 16.0),
        //     //                     child: Text(
        //     //                       selectedCities.join(','),
        //     //                       style: const TextStyle(
        //     //                         fontSize: 14,
        //     //                         overflow:
        //     //                             TextOverflow.ellipsis,
        //     //                       ),
        //     //                       maxLines: 1,
        //     //                     ),
        //     //                   );
        //     //                 },
        //     //               ).toList();
        //     //             },
        //     //           ),
        //     //         );
        //     //       } else if (snapshot.hasError) {
        //     //         return Icon(Icons.error_outline);
        //     //       } else {
        //     //         return Center(
        //     //             child: CircularProgressIndicator());
        //     //       }
        //     //     })
        //   ),
        // ),
        // SizedBox(height: 5),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.only(
        //           left: 5.0, top: 5, bottom: 10),
        //       child: Text(
        //         "Key Catalog Services",
        //         style: TextStyle(
        //             fontSize: 15,
        //             color: AppColor().colorBg1()
        //         ),
        //       ),
        //     ),
        //    // pickImage(ImageSource.gallery, type);
        //     imageCatalog(),
        //   ],
        // ),
        Padding(
          padding: EdgeInsets.only(left: 10,top: 20, bottom: 0),
          child: Text('Name', style: TextStyle(
            color: Colors.black
          ),
        ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xffE3E3E3),
          ),
          ),
          // height: 50,
          child: TextFormField(
              controller: nameController,
              validator: (msg) {
                if (msg!.isEmpty) {
                  return "Please Enter name";
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                  border: InputBorder.none
                  // OutlineInputBorder(
                  //   borderSide: BorderSide(
                  //     color: Colors.white
                  //   ),
                  //     borderRadius: BorderRadius.circular(15))
          ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Text('Mobile No.',
          style: TextStyle(
            color: Colors.black
          ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color(0xffE3E3E3),)
          ),
          child: TextFormField(
              controller: mobileController,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              validator: (msg) {
                if (msg!.isEmpty && msg.length != 10) {
                  return "Please Enter Valid Mobile number";
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                  counterText: "",
                  border: InputBorder.none
              ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Email Id', style: TextStyle(
            color: Colors.black
          ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color(0xffE3E3E3),)
          ),
          // height: 50,
          child: TextFormField(
              controller: emailController,
              // validator: (msg) {
              //   if (msg!.isEmpty) {
              //     return "Please Enter Email Id";
              //   }
              // },
             validator: FormValidation.emailVeledetion,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                  border: InputBorder.none,
              ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Password', style: TextStyle(
              color: Colors.black
          ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color(0xffE3E3E3),)
          ),
          // height: 50,
          child: TextFormField(
            controller: passwordCtr,
            // validator: (msg) {
            //   if (msg!.isEmpty) {
            //     return "Please Enter Email Id";
            //   }
            // },
            // validator: FormValidation.emailVeledetion,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorPrimary(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.PrimaryDark,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("$appBarTitle"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width,
            decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                )),
            child: Container(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonFields(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Address',
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            // _getPickLocation();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Color(0xffE3E3E3))
                            ),
                            // height: 60,
                            child: TextFormField(
                                maxLines: 1,
                                controller: addressController,
                                validator: (msg) {
                                  if (msg!.isEmpty) {
                                    return "Please Enter Address ";
                                  }
                                },
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlacePicker(
                                        apiKey: Platform.isAndroid
                                            ? "AIzaSyBmUCtQ_DlYKSU_BV7JdiyoOu1i4ybe-z0"
                                            : "AIzaSyBmUCtQ_DlYKSU_BV7JdiyoOu1i4ybe-z0",
                                        onPlacePicked: (result) {
                                          print(result.formattedAddress);
                                          setState(() {
                                            addressController.text = result.formattedAddress.toString();
                                            pickLat = result.geometry!.location.lat;
                                            pickLong = result.geometry!.location.lng;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        initialPosition: LatLng(22.719568,75.857727
                                          // double.parse(widget.lat.toString()), double.parse(widget.long.toString())
                                        ),
                                        useCurrentLocation: true,
                                      ),
                                    ),
                                  );
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    border: InputBorder.none
                                )
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(),
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    // type == "6" || type == "5" || type == "7"
                    //     ? SizedBox.shrink()
                    //     : Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 10),
                    //       child: Text('GST No.',
                    //       style: TextStyle(
                    //         color: AppColor().colorBg1()
                    //       ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     Container(
                    //       decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(15),
                    //           border: Border.all(color: AppColor().colorSecondary())
                    //       ),
                    //       // height: 50,
                    //       child: TextFormField(
                    //           controller: gstController,
                    //           // validator: (msg) {
                    //           //   if (msg!.isEmpty) {
                    //           //     return "Please Enter GST";
                    //           //   }
                    //           // },
                    //           decoration: InputDecoration(
                    //             contentPadding: EdgeInsets.only(left: 10),
                    //               border: InputBorder.none)
                    //         // decoration: InputDecoration(
                    //         //   border: OutlineInputBorder(),
                    //         // ),
                    //       ),
                    //     ),
                    //     SizedBox(height: 10),
                    //   ],
                    // ),
                    // // type == '1'?
                    // // Padding(
                    // //   padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                    // //   child: Row(
                    // //     crossAxisAlignment: CrossAxisAlignment.center,
                    // //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // //     children: [
                    // //       Row(
                    // //         mainAxisAlignment: MainAxisAlignment.center,
                    // //         children: [
                    // //           Radio(
                    // //               fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
                    // //               value: 1,
                    // //               groupValue: _value2,
                    // //               onChanged: (int? value) {
                    // //                 setState(() {
                    // //                   _value2 = value!;
                    // //                   restroType = "Veg";
                    // //                   // roleUser = true;
                    // //                   // isUpi = false;
                    // //                 });
                    // //               }),
                    // //           Text("Veg", style: TextStyle(
                    // //             color: AppColor().colorBg1()
                    // //           ),),
                    // //           // Container(
                    // //           //   padding: EdgeInsets.all(10),
                    // //           //   // height: 40,
                    // //           //   decoration: BoxDecoration(
                    // //           //       color: AppColor().colorBg1(),
                    // //           //       borderRadius: BorderRadius.circular(10),
                    // //           //       border: Border.all(
                    // //           //           color: AppColor().colorPrimary())),
                    // //           //   child: Row(
                    // //           //     children: [
                    // //           //       Image.asset(
                    // //           //         'images/veg.png',
                    // //           //         height: 20,
                    // //           //         width: 20,
                    // //           //       ),
                    // //           //       SizedBox(
                    // //           //         width: 5,
                    // //           //       ),
                    // //           //       Text("Veg")
                    // //           //     ],
                    // //           //   ),
                    // //           // )
                    // //         ],
                    // //       ),
                    // //       Row(
                    // //         mainAxisAlignment: MainAxisAlignment.center,
                    // //         children: [
                    // //           Radio(
                    // //               value: 2,
                    // //               fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
                    // //               groupValue: _value2,
                    // //               onChanged: (int? value) {
                    // //                 setState(() {
                    // //                   _value2 = value!;
                    // //                   restroType = "Non-Veg";
                    // //                   // roleUser = false;
                    // //                   // isUpi = true;
                    // //                 });
                    // //               }),
                    // //           Text("Non-Veg",
                    // //                style: TextStyle(
                    // //               color: AppColor().colorBg1()
                    // // ),)
                    // //           // Container(
                    // //           //   padding: EdgeInsets.all(10),
                    // //           //   // height: 40,
                    // //           //   decoration: BoxDecoration(
                    // //           //       color: AppColor().colorBg1(),
                    // //           //       borderRadius: BorderRadius.circular(10),
                    // //           //       border: Border.all(
                    // //           //           color: AppColor().colorPrimary())),
                    // //           //   child: Row(
                    // //           //     children: [
                    // //           //       Image.asset(
                    // //           //         'images/nonveg.png',
                    // //           //         height: 20,
                    // //           //         width: 20,
                    // //           //       ),
                    // //           //       SizedBox(
                    // //           //         width: 5,
                    // //           //       ),
                    // //           //       Text("Non-Veg")
                    // //           //     ],
                    // //           //   ),
                    // //           // )
                    // //         ],
                    // //       ),
                    // //       Row(
                    // //         mainAxisAlignment: MainAxisAlignment.center,
                    // //         children: [
                    // //           Radio(
                    // //               fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
                    // //               value: 3,
                    // //               groupValue: _value2,
                    // //               onChanged: (int? value) {
                    // //                 setState(() {
                    // //                   _value2 = value!;
                    // //                   restroType = "both";
                    // //                   // roleUser = true;
                    // //                   // isUpi = false;
                    // //                 });
                    // //               }),
                    // //           Text("Both",style: TextStyle(
                    // //               color: AppColor().colorBg1() ),)
                    // //
                    // //           // Container(
                    // //           //   padding: EdgeInsets.all(10),
                    // //           //   // height: 40,
                    // //           //   decoration: BoxDecoration(
                    // //           //       color: AppColor().colorBg1(),
                    // //           //       borderRadius: BorderRadius.circular(10),
                    // //           //       border: Border.all(
                    // //           //           color: AppColor().colorPrimary())),
                    // //           //   child: Row(
                    // //           //     children: [
                    // //           //       // Image.asset(
                    // //           //       //   'images/veg.png',
                    // //           //       //   height: 20,
                    // //           //       //   width: 20,
                    // //           //       // ),
                    // //           //       SizedBox(
                    // //           //         width: 5,
                    // //           //       ),
                    // //           //       Text("Both")
                    // //           //     ],
                    // //           //   ),
                    // //           // )
                    // //         ],
                    // //       ),
                    // //     ],
                    // //   ),
                    // // )
                    // // : SizedBox.shrink(),
                    // roleUser ?
                    // type == "6" || type == "5" || type == "8" || type == "7" || type == "1"
                    //     ? SizedBox.shrink()
                    //     : Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 10.0),
                    //       child: Text('Company Name',
                    //       style: TextStyle(
                    //         color: AppColor().colorBg1()
                    //       ),),
                    //     ),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     Container(
                    //       decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(15),
                    //           border: Border.all(color: AppColor().colorSecondary())
                    //       ),
                    //       // height: 50,
                    //       child: TextFormField(
                    //           controller: companyController,
                    //           validator: (msg) {
                    //             if (msg!.isEmpty) {
                    //               return "Please Enter Company Name ";
                    //             }
                    //           },
                    //           decoration: InputDecoration(
                    //               border: InputBorder.none)
                    //         // decoration: InputDecoration(
                    //         //   border: OutlineInputBorder(),
                    //         // ),
                    //       ),
                    //     ),
                    //   ],
                    // )
                    // :SizedBox.shrink(),
                    // SizedBox(height: 10),
                    // type == "2" || type == "3" || type == "4"
                    //     ? Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 10),
                    //       child: Text('Vehicle No.',
                    //       style: TextStyle(
                    //         color: AppColor().colorBg1()
                    //       ),),
                    //     ),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     Container(
                    //       decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(15),
                    //           border: Border.all(color: AppColor().colorSecondary())
                    //       ),
                    //       height: 50,
                    //       child: TextFormField(
                    //           controller: vehicleController,
                    //           validator: (msg) {
                    //             if (msg!.isEmpty) {
                    //               return "Please Enter Vehicle No.";
                    //             }
                    //           },
                    //           decoration: InputDecoration(
                    //               border: InputBorder.none
                    //               // OutlineInputBorder(
                    //               //     borderRadius:
                    //               //     BorderRadius.circular(15))
                    //           )
                    //         // decoration: InputDecoration(
                    //         //   border: OutlineInputBorder(),
                    //         // ),
                    //       ),
                    //     ),
                    //     const SizedBox(height: 10),
                    //   ],
                    // ): SizedBox.shrink(),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 0.0, bottom: 20),
                    //   child: Column(
                    //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Padding(
                    //             padding: EdgeInsets.only(
                    //                 left: 5.0, top: 5, bottom: 10),
                    //             child: Text(
                    //               "Profile Image",
                    //               style: TextStyle(
                    //                   fontSize: 15,
                    //                   color: AppColor().colorBg1()
                    //               ),
                    //             ),
                    //           ),
                    //           imageProfile(),
                    //         ],
                    //       ),
                    //       // const SizedBox(height: 10),
                    //       // Column(
                    //       //   crossAxisAlignment: CrossAxisAlignment.start,
                    //       //   children: [
                    //       //      Padding(
                    //       //       padding: EdgeInsets.only(
                    //       //           left: 5.0, top: 5, bottom: 10),
                    //       //       child: Text(
                    //       //         "Aadhaar Card",
                    //       //         style: TextStyle(
                    //       //           fontSize: 15,
                    //       //           color: AppColor().colorBg1()
                    //       //         ),
                    //       //       ),
                    //       //     ),
                    //       //     imageAadhar(),
                    //       //   ],
                    //       // ),
                    //       // const SizedBox(height: 10),
                    //       // Column(
                    //       //   crossAxisAlignment: CrossAxisAlignment.start,
                    //       //   children: [
                    //       //     Padding(
                    //       //       padding: EdgeInsets.only(
                    //       //           left: 5.0, top: 5, bottom: 10),
                    //       //       child: Text(
                    //       //         "Aadhaar Card Back",
                    //       //         style: TextStyle(
                    //       //             fontSize: 15,
                    //       //             color: AppColor().colorBg1()
                    //       //         ),
                    //       //       ),
                    //       //     ),
                    //       //     imageAadharBack(),
                    //       //   ],
                    //       // ),
                    //       // Column(
                    //       //   crossAxisAlignment: CrossAxisAlignment.start,
                    //       //   children: [
                    //       //      Padding(
                    //       //       padding:
                    //       //       EdgeInsets.only(left: 5, top: 10, bottom: 10),
                    //       //       child: Text(
                    //       //         "Pan Card",
                    //       //         style: TextStyle(
                    //       //           fontSize: 15,
                    //       //           color: AppColor().colorBg1()
                    //       //         ),
                    //       //       ),
                    //       //     ),
                    //       //     imagePan(),
                    //       //   ],
                    //       // ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.only(left: 10),
                    //             child: Text('Address',
                    //               style: TextStyle(
                    //                   color: AppColor().colorBg1()
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 10,
                    //           ),
                    //           InkWell(
                    //             onTap: () {
                    //               // _getPickLocation();
                    //             },
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                   color: Colors.white,
                    //                   borderRadius: BorderRadius.circular(15),
                    //                   border: Border.all(color: AppColor().colorSecondary())
                    //               ),
                    //               // height: 60,
                    //               child: TextFormField(
                    //                   maxLines: 1,
                    //                   controller: addressController,
                    //                   validator: (msg) {
                    //                     if (msg!.isEmpty) {
                    //                       return "Please Enter Address ";
                    //                     }
                    //                   },
                    //                   onTap: () {
                    //                     Navigator.push(
                    //                       context,
                    //                       MaterialPageRoute(
                    //                         builder: (context) => PlacePicker(
                    //                           apiKey: Platform.isAndroid
                    //                               ? "AIzaSyBmUCtQ_DlYKSU_BV7JdiyoOu1i4ybe-z0"
                    //                               : "AIzaSyBmUCtQ_DlYKSU_BV7JdiyoOu1i4ybe-z0",
                    //                           onPlacePicked: (result) {
                    //                             print(result.formattedAddress);
                    //                             setState(() {
                    //                               addressController.text = result.formattedAddress.toString();
                    //                               pickLat = result.geometry!.location.lat;
                    //                               pickLong = result.geometry!.location.lng;
                    //                             });
                    //                             Navigator.of(context).pop();
                    //                           },
                    //                           initialPosition: LatLng(22.719568,75.857727
                    //                             // double.parse(widget.lat.toString()), double.parse(widget.long.toString())
                    //                           ),
                    //                           useCurrentLocation: true,
                    //                         ),
                    //                       ),
                    //                     );
                    //                   },
                    //                   decoration: InputDecoration(
                    //                       contentPadding: EdgeInsets.only(left: 10),
                    //                       border: InputBorder.none
                    //                   )
                    //                 // decoration: InputDecoration(
                    //                 //   border: OutlineInputBorder(),
                    //                 // ),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    //  Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 10),
                    //       child: Text("State",
                    //         style: TextStyle(
                    //             color: AppColor().colorBg1()
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       height: 8,
                    //     ),
                    //     Padding(
                    //       padding:
                    //       const EdgeInsets.only(top: 5.0, bottom: 10),
                    //       child:
                    //       Container(
                    //         height: 55,
                    //         width: MediaQuery.of(context).size.width/1.1,
                    //         padding: EdgeInsets.only(left: 10),
                    //         decoration: BoxDecoration(
                    //             color: AppColor().colorBg1(),
                    //             borderRadius: BorderRadius.circular(15),
                    //             border: Border.all(
                    //                 color: AppColor().colorSecondary(),
                    //             ),
                    //         ),
                    //         child:  Padding(
                    //           padding: const EdgeInsets.all(2.0),
                    //           child: DropdownButtonHideUnderline(
                    //             child: DropdownButton2<StataData?>(
                    //               hint: const Text('Select State',
                    //                 style: TextStyle(
                    //                     color: colors.black54,fontWeight: FontWeight.w500,fontSize:15
                    //                 ),
                    //               ),
                    //               value: stateValue,
                    //               icon: const Padding(
                    //                 padding: EdgeInsets.only(left:0.0),
                    //                 child: Icon(Icons.keyboard_arrow_down_rounded,  color:colors.secondary,size: 30,),
                    //               ),
                    //               style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                    //               underline: Padding(
                    //                 padding: const EdgeInsets.only(left: 0,right: 0),
                    //                 child: Container(
                    //                   // height: 2,
                    //                   color:  colors.whiteTemp,
                    //                 ),
                    //               ),
                    //               onChanged: (StataData? value) {
                    //                 setState(() {
                    //                   stateValue = value!;
                    //                   _getCities("${stateValue!.id}");
                    //                  stateName = stateValue!.name;
                    //                  print("name herererb $stateName");
                    //                 });
                    //               },
                    //               items: stateList.map((items) {
                    //                 return DropdownMenuItem(
                    //                   value: items,
                    //                   child: Container(
                    //                       child: Text(items.name.toString())),
                    //                 );
                    //               }).toList(),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //   ],
                    // ),
                    //  Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 10),
                    //       child: Text("City",
                    //       style: TextStyle(
                    //         color: AppColor().colorBg1()
                    //       ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       height: 8,
                    //     ),
                    //     Padding(
                    //       padding:
                    //       const EdgeInsets.only(top: 5.0, bottom: 10),
                    //       child: Container(
                    //         height: 55,
                    //         width: MediaQuery.of(context).size.width/1.1,
                    //         padding: EdgeInsets.only(left: 10),
                    //         decoration: BoxDecoration(
                    //           color: AppColor().colorBg1(),
                    //           borderRadius: BorderRadius.circular(15),
                    //           border: Border.all(
                    //             color: AppColor().colorSecondary(),
                    //           ),
                    //         ),
                    //         child:  Padding(
                    //           padding: const EdgeInsets.all(2.0),
                    //           child: DropdownButtonHideUnderline(
                    //             child: DropdownButton2<CityData?>(
                    //               hint: const Text('Select City',
                    //                 style: TextStyle(
                    //                     color: colors.black54,fontWeight: FontWeight.w500,fontSize:15
                    //                 ),
                    //               ),
                    //               value: cityValue,
                    //               icon:  const Padding(
                    //                 padding: EdgeInsets.only(left:0.0),
                    //                 child: Icon(Icons.keyboard_arrow_down_rounded,  color:colors.secondary,size: 30,),
                    //               ),
                    //               style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                    //               underline: Padding(
                    //                 padding: const EdgeInsets.only(left: 0,right: 0),
                    //                 child: Container(
                    //                   // height: 2,
                    //                   color:  colors.whiteTemp,
                    //                 ),
                    //               ),
                    //               onChanged: (CityData? value) {
                    //                 setState(() {
                    //                   cityValue = value!;
                    //                   cityName = cityValue!.name;
                    //                   print("name herererb cityytyty $cityName");
                    //                 });
                    //               },
                    //               items: cityList.map((items) {
                    //                 return DropdownMenuItem(
                    //                   value: items,
                    //                   child: Container(
                    //                       child: Text(items.name.toString())),
                    //                 );
                    //               }).toList(),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     // Padding(
                    //     //   padding: EdgeInsets.only(left: 10,top: 10, bottom: 0),
                    //     //   child: Text('Pincode', style: TextStyle(
                    //     //       color: Colors.white
                    //     //   ),
                    //     //   ),
                    //     // ),
                    //     // SizedBox(
                    //     //   height: 10,
                    //     // ),
                    //     // Container(
                    //     //   decoration: BoxDecoration(
                    //     //       color: Colors.white,
                    //     //       borderRadius: BorderRadius.circular(15),
                    //     //       border: Border.all(
                    //     //           color: AppColor().colorSecondary()
                    //     //       ),
                    //     //   ),
                    //     //   // height: 50,
                    //     //   child: TextFormField(
                    //     //     keyboardType: TextInputType.number,
                    //     //     maxLength: 6,
                    //     //     controller: pincodeCtr,
                    //     //     validator: (msg) {
                    //     //       if (msg!.isEmpty) {
                    //     //         return "Please Enter pincode";
                    //     //       }
                    //     //     },
                    //     //     decoration: InputDecoration(
                    //     //         contentPadding: EdgeInsets.only(left: 10),
                    //     //         border: InputBorder.none,
                    //     //         counterText: "",
                    //     //     ),
                    //     //   ),
                    //     // ),
                    //     // const SizedBox(
                    //     //   height: 10,
                    //     // ),
                    //     // Padding(
                    //     //   padding: EdgeInsets.only(left: 10,top: 10, bottom: 0),
                    //     //   child: Text('Area', style: TextStyle(
                    //     //       color: Colors.white
                    //     //   ),
                    //     //   ),
                    //     // ),
                    //     // SizedBox(
                    //     //   height: 10,
                    //     // ),
                    //     // Container(
                    //     //   decoration: BoxDecoration(
                    //     //       color: Colors.white,
                    //     //       borderRadius: BorderRadius.circular(15),
                    //     //       border: Border.all(color: AppColor().colorSecondary())
                    //     //   ),
                    //     //   // height: 50,
                    //     //   child: TextFormField(
                    //     //     controller: areaCtr,
                    //     //     validator: (msg) {
                    //     //       if (msg!.isEmpty) {
                    //     //         return "Please Enter area";
                    //     //       }
                    //     //     },
                    //     //     decoration: InputDecoration(
                    //     //         contentPadding: EdgeInsets.only(left: 10),
                    //     //         border: InputBorder.none
                    //     //     ),
                    //     //   ),
                    //     // ),
                    //     const SizedBox(
                    //       height: 10,
                    //     ),
                    //    // type == "7" ?
                    //    // Column(
                    //    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //    //   children: [
                    //    //     Padding(
                    //    //       padding: EdgeInsets.only(left: 10,top: 10, bottom: 0),
                    //    //       child: Text('Educational Qualification', style: TextStyle(
                    //    //           color: Colors.white
                    //    //       ),
                    //    //       ),
                    //    //     ),
                    //    //     SizedBox(
                    //    //       height: 10,
                    //    //     ),
                    //    //     Container(
                    //    //       decoration: BoxDecoration(
                    //    //           color: Colors.white,
                    //    //           borderRadius: BorderRadius.circular(15),
                    //    //           border: Border.all(color: AppColor().colorSecondary())
                    //    //       ),
                    //    //       // height: 50,
                    //    //       child: TextFormField(
                    //    //         controller: educationCtr,
                    //    //         // validator: (msg) {
                    //    //         //   if (msg!.isEmpty) {
                    //    //         //     return "Please Enter education";
                    //    //         //   }
                    //    //         // },
                    //    //         decoration: InputDecoration(
                    //    //             contentPadding: EdgeInsets.only(left: 10),
                    //    //             border: InputBorder.none
                    //    //         ),
                    //    //       ),
                    //    //     ),
                    //    //   ],
                    //    // ): SizedBox(
                    //    //   height: 10,
                    //    // ),
                    //    //  type == "7" ?
                    //    // Column(
                    //    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //    //   children: [
                    //    //   Padding(
                    //    //     padding: EdgeInsets.only(left: 10,top: 10, bottom: 0),
                    //    //     child: Text('Professional Qualification', style: TextStyle(
                    //    //         color: Colors.white
                    //    //     ),
                    //    //     ),
                    //    //   ),
                    //    //   SizedBox(
                    //    //     height: 10,
                    //    //   ),
                    //    //   Container(
                    //    //     decoration: BoxDecoration(
                    //    //         color: Colors.white,
                    //    //         borderRadius: BorderRadius.circular(15),
                    //    //         border: Border.all(color: AppColor().colorSecondary())
                    //    //     ),
                    //    //     // height: 50,
                    //    //     child: TextFormField(
                    //    //       controller: professionalCtr,
                    //    //       // validator: (msg) {
                    //    //       //   if (msg!.isEmpty) {
                    //    //       //     return "Please Enter professional";
                    //    //       //   }
                    //    //       // },
                    //    //       decoration: InputDecoration(
                    //    //           contentPadding: EdgeInsets.only(left: 10),
                    //    //           border: InputBorder.none
                    //    //       ),
                    //    //     ),
                    //    //   ),
                    //    // ],): SizedBox() ,
                    //    //  const SizedBox(
                    //    //    height: 10,
                    //    //  ),
                    //    //  type == "7" ?
                    //    //  Column(
                    //    //    crossAxisAlignment: CrossAxisAlignment.start,
                    //    //    children: [
                    //    //      Padding(
                    //    //        padding: EdgeInsets.only(left: 10,top: 10, bottom: 0),
                    //    //        child: Text('Sanskrit Qualification', style: TextStyle(
                    //    //            color: Colors.white
                    //    //        ),
                    //    //        ),
                    //    //      ),
                    //    //      SizedBox(
                    //    //        height: 10,
                    //    //      ),
                    //    //      Container(
                    //    //        decoration: BoxDecoration(
                    //    //            color: Colors.white,
                    //    //            borderRadius: BorderRadius.circular(15),
                    //    //            border: Border.all(color: AppColor().colorSecondary())
                    //    //        ),
                    //    //        // height: 50,
                    //    //        child: TextFormField(
                    //    //          controller: sanskritCtr,
                    //    //          // validator: (msg) {
                    //    //          //   if (msg!.isEmpty) {
                    //    //          //     return "Please Enter sanskrit";
                    //    //          //   }
                    //    //          // },
                    //    //          decoration: InputDecoration(
                    //    //              contentPadding: EdgeInsets.only(left: 10),
                    //    //              border: InputBorder.none
                    //    //          ),
                    //    //        ),
                    //    //      ),
                    //    //    ],
                    //    //  ): SizedBox(),
                    //    //  const SizedBox(
                    //    //    height: 10,
                    //    //  ),
                    //    //  type == "7" ?
                    //    //  Column(
                    //    //    crossAxisAlignment: CrossAxisAlignment.start,
                    //    //    children: [
                    //    //      Padding(
                    //    //        padding: EdgeInsets.only(left: 10,top: 10, bottom: 0),
                    //    //        child: Text('Languages known', style: TextStyle(
                    //    //            color: Colors.white
                    //    //        ),),
                    //    //      ),
                    //    //      SizedBox(
                    //    //        height: 10,
                    //    //      ),
                    //    //      Container(
                    //    //        decoration: BoxDecoration(
                    //    //            color: Colors.white,
                    //    //            borderRadius: BorderRadius.circular(15),
                    //    //            border: Border.all(color: AppColor().colorSecondary())
                    //    //        ),
                    //    //        // height: 50,
                    //    //        child: TextFormField(
                    //    //          controller: languageCtr,
                    //    //          // validator: (msg) {
                    //    //          //   if (msg!.isEmpty) {
                    //    //          //     return "Please Enter language";
                    //    //          //   }
                    //    //          // },
                    //    //          decoration: InputDecoration(
                    //    //              contentPadding: EdgeInsets.only(left: 10),
                    //    //              border: InputBorder.none
                    //    //          ),
                    //    //        ),
                    //    //      ),
                    //    //    ],
                    //    //  ): SizedBox(),
                    //    //  const SizedBox(
                    //    //    height: 10,
                    //    //  ),
                    //    // type == "7" ?
                    //    // Column(
                    //    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //    //   children: [
                    //    //     Padding(
                    //    //       padding: EdgeInsets.only(left: 10,top: 10, bottom: 0),
                    //    //       child: Text('Veda studies', style: TextStyle(
                    //    //           color: Colors.white
                    //    //       ),
                    //    //       ),
                    //    //     ),
                    //    //     SizedBox(
                    //    //       height: 10,
                    //    //     ),
                    //    //     Container(
                    //    //       decoration: BoxDecoration(
                    //    //           color: Colors.white,
                    //    //           borderRadius: BorderRadius.circular(15),
                    //    //           border: Border.all(color: AppColor().colorSecondary())
                    //    //       ),
                    //    //       // height: 50,
                    //    //       child: TextFormField(
                    //    //         controller: vedaCtr,
                    //    //         // validator: (msg) {
                    //    //         //   if (msg!.isEmpty) {
                    //    //         //     return "Please Enter veda";
                    //    //         //   }
                    //    //         // },
                    //    //         decoration: InputDecoration(
                    //    //             contentPadding: EdgeInsets.only(left: 10),
                    //    //             border: InputBorder.none
                    //    //         ),
                    //    //       ),
                    //    //     ),
                    //    //   ],
                    //    // ): SizedBox(),
                    //    //  Padding(
                    //    //    padding: EdgeInsets.only(left: 10,top: 10, bottom: 0),
                    //    //    child: Text('Years In Business', style: TextStyle(
                    //    //        color: Colors.white
                    //    //    ),
                    //    //    ),
                    //    //  ),
                    //    //  SizedBox(
                    //    //    height: 10,
                    //    //  ),
                    //    //  Container(
                    //    //    decoration: BoxDecoration(
                    //    //        color: Colors.white,
                    //    //        borderRadius: BorderRadius.circular(15),
                    //    //        border: Border.all(color: AppColor().colorSecondary())
                    //    //    ),
                    //    //    // height: 50,
                    //    //    child: TextFormField(
                    //    //      controller: yearBusinessCtr,
                    //    //      // validator: (msg) {
                    //    //      //   if (msg!.isEmpty) {
                    //    //      //     return "Please Enter year in business";
                    //    //      //   }
                    //    //      // },
                    //    //      decoration: InputDecoration(
                    //    //          contentPadding: EdgeInsets.only(left: 10),
                    //    //          border: InputBorder.none
                    //    //      ),
                    //    //    ),
                    //    //  ),
                    //    //  const SizedBox(
                    //    //    height: 10,
                    //    //  ),
                    //    //  Padding(
                    //    //    padding: EdgeInsets.only(left: 10,top: 10, bottom: 0),
                    //    //    child: Text('Locations Covered', style: TextStyle(
                    //    //        color: Colors.white
                    //    //    ),),
                    //    //  ),
                    //    //  SizedBox(
                    //    //    height: 10,
                    //    //  ),
                    //    //  Container(
                    //    //    decoration: BoxDecoration(
                    //    //        color: Colors.white,
                    //    //        borderRadius: BorderRadius.circular(15),
                    //    //        border: Border.all(color: AppColor().colorSecondary())
                    //    //    ),
                    //    //    // height: 50,
                    //    //    child: TextFormField(
                    //    //      controller: locationCoveredCtr,
                    //    //      // validator: (msg) {
                    //    //      //   if (msg!.isEmpty) {
                    //    //      //     return "Please Enter location";
                    //    //      //   }
                    //    //      // },
                    //    //      decoration: InputDecoration(
                    //    //          contentPadding: EdgeInsets.only(left: 10),
                    //    //          border: InputBorder.none
                    //    //        // OutlineInputBorder(
                    //    //        //   borderSide: BorderSide(
                    //    //        //     color: Colors.white
                    //    //        //   ),
                    //    //        //     borderRadius: BorderRadius.circular(15))
                    //    //      ),
                    //    //    ),
                    //    //  ),
                    //    //  const SizedBox(
                    //    //    height: 10,
                    //    //  ),
                    //     // type == "7" ?
                    //     // Column(
                    //     //   crossAxisAlignment: CrossAxisAlignment.start,
                    //     //   children: [
                    //     //     Padding(
                    //     //       padding: EdgeInsets.only(left: 10,top: 10, bottom: 0),
                    //     //       child: Text('Caste', style: TextStyle(
                    //     //           color: Colors.white
                    //     //       ),
                    //     //       ),
                    //     //     ),
                    //     //     SizedBox(
                    //     //       height: 10,
                    //     //     ),
                    //     //     Container(
                    //     //       decoration: BoxDecoration(
                    //     //           color: Colors.white,
                    //     //           borderRadius: BorderRadius.circular(15),
                    //     //           border: Border.all(color: AppColor().colorSecondary())
                    //     //       ),
                    //     //       // height: 50,
                    //     //       child: TextFormField(
                    //     //         controller: casteCtr,
                    //     //         // validator: (msg) {
                    //     //         //   if (msg!.isEmpty) {
                    //     //         //     return "Please Enter caste";
                    //     //         //   }
                    //     //         // },
                    //     //         decoration: InputDecoration(
                    //     //             contentPadding: EdgeInsets.only(left: 10),
                    //     //             border: InputBorder.none,
                    //     //           // OutlineInputBorder(
                    //     //           //   borderSide: BorderSide(
                    //     //           //     color: Colors.white
                    //     //           //   ),
                    //     //           //     borderRadius: BorderRadius.circular(15))
                    //     //         ),
                    //     //       ),
                    //     //     ),
                    //     //   ],
                    //     // ):
                    //     // const SizedBox(
                    //     //   height: 10,
                    //     // ),
                    //     // type == "7" ? SizedBox() : Column(
                    //     //   crossAxisAlignment: CrossAxisAlignment.start,
                    //     //   children: [
                    //     //     Padding(
                    //     //       padding: EdgeInsets.only(left: 10,top: 10, bottom: 0),
                    //     //       child: Text('Testimonials', style: TextStyle(
                    //     //           color: Colors.white
                    //     //       ),
                    //     //       ),
                    //     //     ),
                    //     //     SizedBox(
                    //     //       height: 10,
                    //     //     ),
                    //     //     Container(
                    //     //       decoration: BoxDecoration(
                    //     //           color: Colors.white,
                    //     //           borderRadius: BorderRadius.circular(15),
                    //     //           border: Border.all(color: AppColor().colorSecondary())
                    //     //       ),
                    //     //       // height: 50,
                    //     //       child: TextFormField(
                    //     //         controller: testimonialsCtr,
                    //     //         // validator: (msg) {
                    //     //         //   if (msg!.isEmpty) {
                    //     //         //     return "Please Enter Testimonials";
                    //     //         //   }
                    //     //         // },
                    //     //         decoration: InputDecoration(
                    //     //             contentPadding: EdgeInsets.only(left: 10),
                    //     //             border: InputBorder.none
                    //     //         ),
                    //     //       ),
                    //     //     ),
                    //     //   ],
                    //     // ),
                    //     const SizedBox(
                    //       height: 10,
                    //     ),
                    //   ],
                    // ),
                  //  type == "6" || type == "7" ?
                  //   Padding(
                  //     padding: const EdgeInsets.only(left: 10, bottom: 10),
                  //     child: Text("Category",
                  //     style: TextStyle(
                  //       color: AppColor().colorBg1()
                  //     ),
                  //     ),
                  //   ),
                   // : SizedBox.shrink(),
                //   type == "6" || type == "7"
                    //?
                    // InkWell(
                    //   onTap: (){
                    //     _showMultiSelect();
                    //   },
                    //   child: Container(
                    //       width: MediaQuery.of(context).size.width,
                    //       padding: EdgeInsets.only(left: 10),
                    //       decoration: BoxDecoration(
                    //         color: AppColor().colorBg1(),
                    //           borderRadius: BorderRadius.circular(15),
                    //           border: Border.all(
                    //               color: Colors.black.withOpacity(0.7))),
                    //       child: _selectedItems.isEmpty ?
                    //       Padding(
                    //         padding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
                    //         child: Text(
                    //           'Select Categories',
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             color: colors.primary,
                    //             fontWeight: FontWeight.normal,
                    //           ),
                    //           overflow: TextOverflow.ellipsis,
                    //         ),
                    //       )
                    //           :
                    //       Wrap(
                    //         children: _selectedItems
                    //             .map((item){
                    //           return Padding(
                    //             padding: const EdgeInsets.only(left: 8.0, right: 8),
                    //             child: Chip(
                    //               backgroundColor: AppColor().colorPrimary(),
                    //               label:
                    //               Text(
                    //                   "${item.cName}",
                    //                 style: TextStyle(
                    //                   color: AppColor().colorBg1()
                    //                 ),
                    //                 //item.name
                    //               ),
                    //             ),
                    //           );
                    //         })
                    //             .toList(),
                    //       )
                    //     // FutureBuilder(
                    //     //     future: getCities(),
                    //     //     builder: (BuildContext context,
                    //     //         AsyncSnapshot snapshot) {
                    //     //       if (snapshot.hasData) {
                    //     //         return DropdownButtonHideUnderline(
                    //     //           child: DropdownButton2(
                    //     //             isExpanded: true,
                    //     //             hint: Row(
                    //     //               children: [
                    //     //                 Image.asset(
                    //     //                   city,
                    //     //                   width: 6.04.w,
                    //     //                   height: 5.04.w,
                    //     //                   fit: BoxFit.fill,
                    //     //                   color: AppColor.PrimaryDark,
                    //     //                 ),
                    //     //                 SizedBox(
                    //     //                   width: 4,
                    //     //                 ),
                    //     //                 Expanded(
                    //     //                   child: Text(
                    //     //                     'Select Multiple Cities',
                    //     //                     style: TextStyle(
                    //     //                       fontSize: 14,
                    //     //                       fontWeight: FontWeight.normal,
                    //     //                     ),
                    //     //                     overflow: TextOverflow.ellipsis,
                    //     //                   ),
                    //     //                 ),
                    //     //               ],
                    //     //             ),
                    //     //             items: cityList.map((item) {
                    //     //               return DropdownMenuItem<String>(
                    //     //                 value: item.id,
                    //     //                 enabled: false,
                    //     //                 child: StatefulBuilder(
                    //     //                   builder: (context, menuSetState) {
                    //     //                     final _isSelected =
                    //     //                         selectedCities
                    //     //                             .contains(item);
                    //     //                     print("SLECTED CITY");
                    //     //                     return InkWell(
                    //     //                       onTap: () {
                    //     //                         _isSelected
                    //     //                             ? selectedCities
                    //     //                                 .remove(item.id)
                    //     //                             : selectedCities
                    //     //                                 .add(item.id!);
                    //     //                         setState(() {});
                    //     //                         menuSetState(() {});
                    //     //                       },
                    //     //                       child: Container(
                    //     //                         height: double.infinity,
                    //     //                         padding: const EdgeInsets
                    //     //                                 .symmetric(
                    //     //                             horizontal: 16.0),
                    //     //                         child: Row(
                    //     //                           children: [
                    //     //                             _isSelected
                    //     //                                 ? const Icon(Icons
                    //     //                                     .check_box_outlined)
                    //     //                                 : const Icon(Icons
                    //     //                                     .check_box_outline_blank),
                    //     //                             const SizedBox(
                    //     //                                 width: 16),
                    //     //                             Text(
                    //     //                               item.name!,
                    //     //                               style:
                    //     //                                   const TextStyle(
                    //     //                                 fontSize: 14,
                    //     //                               ),
                    //     //                             ),
                    //     //                           ],
                    //     //                         ),
                    //     //                       ),
                    //     //                     );
                    //     //                   },
                    //     //                 ),
                    //     //               );
                    //     //             }).toList(),
                    //     //             //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                    //     //             value: selectedCities.isEmpty
                    //     //                 ? null
                    //     //                 : selectedCities.last,
                    //     //             onChanged: (value) {},
                    //     //             buttonHeight: 50,
                    //     //             buttonWidth: 160,
                    //     //             buttonPadding: const EdgeInsets.only(
                    //     //                 left: 14, right: 14),
                    //     //             buttonDecoration: BoxDecoration(
                    //     //               borderRadius:
                    //     //                   BorderRadius.circular(14),
                    //     //               color: Color(0xffF9F9F9),
                    //     //             ),
                    //     //             buttonElevation: 0,
                    //     //             itemHeight: 40,
                    //     //             itemPadding: const EdgeInsets.only(
                    //     //                 left: 14, right: 14),
                    //     //             dropdownMaxHeight: 300,
                    //     //             dropdownPadding: null,
                    //     //             dropdownDecoration: BoxDecoration(
                    //     //               borderRadius:
                    //     //                   BorderRadius.circular(14),
                    //     //             ),
                    //     //             dropdownElevation: 8,
                    //     //             scrollbarRadius:
                    //     //                 const Radius.circular(40),
                    //     //             scrollbarThickness: 6,
                    //     //             scrollbarAlwaysShow: true,
                    //     //             selectedItemBuilder: (context) {
                    //     //               return cityList.map(
                    //     //                 (item) {
                    //     //                   return Container(
                    //     //                     // alignment: AlignmentDirectional.center,
                    //     //                     padding:
                    //     //                         const EdgeInsets.symmetric(
                    //     //                             horizontal: 16.0),
                    //     //                     child: Text(
                    //     //                       selectedCities.join(','),
                    //     //                       style: const TextStyle(
                    //     //                         fontSize: 14,
                    //     //                         overflow:
                    //     //                             TextOverflow.ellipsis,
                    //     //                       ),
                    //     //                       maxLines: 1,
                    //     //                     ),
                    //     //                   );
                    //     //                 },
                    //     //               ).toList();
                    //     //             },
                    //     //           ),
                    //     //         );
                    //     //       } else if (snapshot.hasError) {
                    //     //         return Icon(Icons.error_outline);
                    //     //       } else {
                    //     //         return Center(
                    //     //             child: CircularProgressIndicator());
                    //     //       }
                    //     //     })
                    //   ),
                    // ),
                  SizedBox(height: 30),
                  //  : SizedBox.shrink(),
                  //   type == "1" || type == "8"
                  //       ? Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 10),
                  //         child: Text(
                  //           "Store Details",
                  //           style: TextStyle(
                  //             color: AppColor().colorBg1(),
                  //               fontWeight: FontWeight.w600, fontSize: 18),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 10),
                  //         child: Text("Store Name",
                  //         style: TextStyle(
                  //           color: AppColor().colorBg1()
                  //         ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(15),
                  //             border: Border.all(color: AppColor().colorSecondary())
                  //         ),
                  //         // height: 50,
                  //         child: TextFormField(
                  //             controller: storeNameController,
                  //             validator: (msg) {
                  //               if (msg!.isEmpty) {
                  //                 return "Please Enter Store Name";
                  //               }
                  //             },
                  //             decoration: InputDecoration(
                  //               contentPadding: EdgeInsets.only(left: 10),
                  //                 border: InputBorder.none)
                  //           // decoration: InputDecoration(
                  //           //   border: OutlineInputBorder(),
                  //           // ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 10),
                  //         child: Text("Store Description", style: TextStyle(
                  //           color: AppColor().colorBg1()
                  //         ),),
                  //       ),
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(15),
                  //             border: Border.all(color: AppColor().colorSecondary())
                  //         ),
                  //         // height: 50,
                  //         child: TextFormField(
                  //             controller: storeDescriptionController,
                  //             validator: (msg) {
                  //               if (msg!.isEmpty) {
                  //                 return "Please Enter Store Description";
                  //               }
                  //             },
                  //             decoration: InputDecoration(
                  //                 border: InputBorder.none
                  //             )
                  //           // decoration: InputDecoration(
                  //           //   border: OutlineInputBorder(),
                  //           // ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 10),
                  //         child: Text("FSSAI",
                  //         style: TextStyle(
                  //           color: AppColor().colorBg1()
                  //         ),),
                  //       ),
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(15),
                  //             border: Border.all(color: AppColor().colorSecondary())
                  //         ),
                  //         // height: 50,
                  //         child: TextFormField(
                  //             controller: fssaiController,
                  //             validator: (msg) {
                  //               if (msg!.isEmpty) {
                  //                 return "Please Enter FSSAI No. ";
                  //               }
                  //             },
                  //             decoration: InputDecoration(
                  //               contentPadding: EdgeInsets.only(left: 10),
                  //                 border: InputBorder.none)
                  //           // decoration: InputDecoration(
                  //           //   border: OutlineInputBorder(),
                  //           // ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //     ],
                  //   )
                  //       : SizedBox.shrink(),
                    /// referral section
                    // Padding(
                    //   padding: const EdgeInsets.only(top:10,left: 10),
                    //   child: Text("Referral Code (Optional)",style: TextStyle(
                    //     color: AppColor().colorBg1()
                    //   ),),
                    // ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    // Container(
                    //   height: 50,
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(15),
                    //       border: Border.all(color: AppColor().colorSecondary())
                    //   ),
                    //   child: TextFormField(
                    //       controller: referallController,
                    //       // validator: (msg) {
                    //       //   if (msg!.isEmpty) {
                    //       //     return "Please Enter FSSAI No. ";
                    //       //   }
                    //       // },
                    //       decoration: InputDecoration(
                    //         contentPadding: EdgeInsets.only(left: 10),
                    //           border: InputBorder.none)
                    //     // decoration: InputDecoration(
                    //     //   border: OutlineInputBorder(),
                    //     // ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       width: 50,
                    //       child: RadioListTile(
                    //         title: Text("Bank UPI"),
                    //         value: "bank upi",
                    //         groupValue: bankValue,
                    //         onChanged: (value){
                    //           setState(() {
                    //             bankValue = value.toString();
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //     Container(
                    //       width: 50,
                    //       child: RadioListTile(
                    //         title: Text("Bank Account"),
                    //         value: "bank account",
                    //         groupValue: bankValue,
                    //         onChanged: (value){
                    //           setState(() {
                    //             bankValue = value.toString();
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          submitRequest();
                        } else {
                          setState((){
                            isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg: "All fields are required!!");
                        }
                        // if(passwordController.text == confirmPassController.text){
                        // // if(type =="1"){
                        //   // if (gstController.text.isNotEmpty &&
                        //   //     fssaiController.text.isNotEmpty &&
                        //   //     storeDescriptionController.text.isNotEmpty
                        //   //  && storeNameController.text.isNotEmpty) {
                        //   if (isUpi == false) {
                        //       if (_formKey.currentState!.validate()) {
                        //         submitRequest();
                        //       } else {
                        //         setState((){
                        //           isLoading = false;
                        //         });
                        //         Fluttertoast.showToast(
                        //             msg: "All fields are required!!");
                        //       }
                        //     }
                        //     else {
                        //       if (accountNoController.text.isNotEmpty &&
                        //           accountHolderController.text.isNotEmpty &&
                        //           bankNameController.text.isNotEmpty &&
                        //           ifscController.text.isNotEmpty) {
                        //         if(accountNoController.text == confmAccountNumController.text){
                        //           submitRequest();
                        //         }else{
                        //           setState((){
                        //             isLoading = false;
                        //           });
                        //           Fluttertoast.showToast(msg: "Account number and Confirm Account Number must be same!");
                        //         }
                        //       }
                        //       else {
                        //         setState((){
                        //           isLoading = false;
                        //         });
                        //         Fluttertoast.showToast(
                        //             msg: "All fields are required!!");
                        //       }
                        //     }
                        //     }else{
                        //   Fluttertoast.showToast(msg: "Password and confirm password fields must be same!");
                        // }
                          // } else {
                          //   setState((){
                          //     isLoading = false;
                          //   });
                          //   Fluttertoast.showToast(
                          //       msg: "Store Details, GST No. & FSSAI No. required!");
                          // }
                        // }
                        //   else{
                        //     if (isUpi == false) {
                        //       if (_formKey.currentState!.validate()) {
                        //         submitRequest();
                        //       } else {
                        //         setState((){
                        //           isLoading = false;
                        //         });
                        //         Fluttertoast.showToast(
                        //             msg: "All fields are required!!");
                        //       }
                        //     }
                        //     else {
                        //       if (accountNoController.text.isNotEmpty &&
                        //           accountHolderController.text.isNotEmpty &&
                        //           bankNameController.text.isNotEmpty &&
                        //           ifscController.text.isNotEmpty) {
                        //         submitRequest();
                        //       }
                        //       else {
                        //         setState((){
                        //           isLoading = false;
                        //         });
                        //         Fluttertoast.showToast(
                        //             msg: "All fields are required!!");
                        //       }
                        //     }
                        //   }
                      },
                      child: Container(
                          height: 43,
                          width:  MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor().colorSecondary()),
                          child: isLoading ?
                              loadingWidget() :
                          Center(child: Text("Submit", style: TextStyle(fontSize: 18, color: AppColor.PrimaryDark)))
                      ),
                    ),
                    // AppBtn(
                    //   onPress: (){
                    //     if(isUpi == false) {
                    //       if (_formKey.currentState!.validate()) {
                    //         submitRequest();
                    //       } else {
                    //         Fluttertoast.showToast(
                    //             msg: "All fields are required!!");
                    //       }
                    //     }else{
                    //       if(accountNoController.text.isNotEmpty && accountHolderController.text.isNotEmpty &&
                    //           bankNameController.text.isNotEmpty && ifscController.text.isNotEmpty){
                    //         submitRequest();
                    //       }
                    //       else {
                    //         Fluttertoast.showToast(
                    //             msg: "All fields are required!!");
                    //       }
                    //     }
                    //   },
                    //   label: "Submit",
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     if(isUpi == false) {
                    //       if (_formKey.currentState!.validate()) {
                    //         submitRequest();
                    //       } else {
                    //         Fluttertoast.showToast(
                    //             msg: "All fields are required!!");
                    //       }
                    //     }else{
                    //       if(accountNoController.text.isNotEmpty && accountHolderController.text.isNotEmpty &&
                    //           bankNameController.text.isNotEmpty && ifscController.text.isNotEmpty){
                    //         submitRequest();
                    //       }
                    //       else {
                    //         Fluttertoast.showToast(
                    //             msg: "All fields are required!!");
                    //       }
                    //     }
                    //
                    //     // Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomBar(
                    //     //   type: type,
                    //     // )));
                    //   },
                    //   child: Align(
                    //     alignment: Alignment.center,
                    //     child: Container(
                    //       height: 44,
                    //       width: 300,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(30.0),
                    //         color: AppColor().colorPrimary(),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           "Submit",
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 18),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class MultiSelect extends StatefulWidget {
  String type;
  MultiSelect({Key? key, required this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();

}


class _MultiSelectState extends State<MultiSelect> {
  List _selectedItems = [];
  // this variable holds the selected items

  // List<CityData> cityList = [];
  List<Categories> eventCat = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(Categories itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
    print("this is selected values ${_selectedItems.toString()}");
  }
  // void _itemChange(itemValue, bool isSelected) {
  //   setState(() {
  //     if (isSelected) {
  //       _selectedItems.add(itemValue);
  //     }
  //     else {
  //       _selectedItems.remove(itemValue);
  //     }
  //   });
  // }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    List selectedItem = _selectedItems.map((item) => item.id).toList();
    // var map = {
    //   "itemIds" : selectedItem,
    //   "selectedItems" : _selectedItems
    // };
    // print("checking selected value ${_selectedItems} && ${selectedItem} && ${map}");
    Navigator.pop(context);
  }
  _getEventCategory() async {
    var uri = Uri.parse('${Apipath.getEventCatUrl}');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    // print(baseUrl.toString());

    request.headers.addAll(headers);
    request.fields['type_id'] = "${widget.type.toString()}";
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        // collectionModal = AllCateModel.fromJson(userData);
        eventCat = EventCategoryModel.fromJson(userData).data!;
        // print(
        //     "ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
      });
    }
    print(responseData);
  }
  bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getEventCategory();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState)
    {
      return
        AlertDialog(
          title: const Text('Select Multiple Categories'),
          content: SingleChildScrollView(
            child: ListBody(
              children: eventCat
                  .map((item) =>
              // InkWell(
              //   onTap: (){
              //     setState(() {
              //       if (isChecked) {
              //         setState(() {
              //           _selectedItems.add(item);
              //         });
              //         print("length of item list ${_selectedItems.length}");
              //         for (var i = 0; i < _selectedItems.length; i++) {
              //           print("ok now final  ${_selectedItems[i]
              //               .id} and  ${_selectedItems[i].cName}");
              //         }
              //       }
              //       else {
              //         setState(() {
              //           _selectedItems.remove(item);
              //         });
              //         print("ok now data ${_selectedItems}");
              //       }
              //     });
              //
              //   },
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 40,
              //         width: 40,
              //         decoration: BoxDecoration(
              //           color: AppColor().colorBg1(),
              //           border: Border.all(
              //             color: isChecked ? AppColor().colorPrimary() : AppColor().colorTextSecondary()
              //           ),
              //           borderRadius: BorderRadius.circular(5)
              //         ),
              //         child: Icon(
              //           Icons.check,
              //         ),
              //       ),
              //       Text(item.cName!)
              //     ],
              //   ),
              // )
                  CheckboxListTile(
                    activeColor: AppColor().colorPrimary(),
                    value: _selectedItems.contains(item),
                    title: Text(item.cName!),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                    // onChanged: (isChecked) {
                    //   setState(() {
                    //     if (!isChecked! && _selectedItems.contains(item.id)) {
                    //       setState(() {
                    //         _selectedItems.remove(item);
                    //       });
                    //       print("ok now data ${_selectedItems}");
                    //     }
                    //     else {
                    //       setState(() {
                    //         _selectedItems.add(item);
                    //       });
                    //       print("length of item list ${_selectedItems.length}");
                    //       for (var i = 0; i < _selectedItems.length; i++) {
                    //         print("ok now final  ${_selectedItems[i]
                    //             .id} and  ${_selectedItems[i].cName}");
                    //       }
                    //     }
                    //   });
                    // },
                  )
              ).toList(),
            ),
          ),
          // FutureBuilder(
          //   future: getCities(),
          //   builder: (context, snapshot){
          //     if(snapshot.hasData) {
          //      return SingleChildScrollView(
          //         child: ListBody(
          //           children: cityList
          //               .map((item) =>
          //               CheckboxListTile(
          //                 value: _selectedItems.contains(item),
          //                 title: Text(item.name!),
          //                 controlAffinity: ListTileControlAffinity.leading,
          //                 onChanged: (isChecked) => _itemChange(item, isChecked!),
          //               ))
          //               .toList(),
          //         ),
          //       );
          //     }
          //     return Container(
          //       height: 30,
          //         width: 30,
          //         child: CircularProgressIndicator(
          //           color: AppColor().colorPrimary(),
          //         ));
          //   }
          // ),
          actions: [
            TextButton(
              child: Text('Cancel',
                style: TextStyle(color: AppColor().colorPrimary()),),
              onPressed: _cancel,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: AppColor().colorPrimary()
              ),
              child: Text('Submit'),
              onPressed: () {
                // _submit();
                Navigator.pop(context, _selectedItems);
              }
              //     (){
              //   for(var i = 0 ; i< _selectedItems.length; i++){
              //     print(_selectedItems[i].id);
              //   }
              // }
              ,
            ),
          ],
        );
    }
    );
  }
}

