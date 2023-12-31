import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/new%20model/SubCategoryModel.dart';
import 'package:fixerking/new%20model/categories_model.dart';
import 'package:fixerking/screen/BottomBars/bottom_bar.dart';
import 'package:fixerking/utility_widget/customLoader.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/colors.dart';
import '../../../utils/widget.dart';

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../new model/myPlanModel.dart';
import '../../token/token_string.dart';

class EditPlans extends StatefulWidget {
  var myPlanModel;
  EditPlans({this.myPlanModel});

  @override
  State<EditPlans> createState() => _EditPlansState();
}

class _EditPlansState extends State<EditPlans> {
  var categoryValue;
  var subCategoryValue;
  var mainPlanValue;

  TextEditingController plannameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController personController = TextEditingController();

  String? planType;
  String? pujaSamagri;
  String? fruitAndFlower;

  PickedFile? image1;
  PickedFile? image2;
  PickedFile? image3;
  int? _value1 = 1;

  List? subCategoryModel;
  bool isLoading = false;
  bool isSuccess = false;
  String productType = "Veg";

  List<Category> catlist = [];

  _getCollection() async {
    var uri = Uri.parse('${Apipath.getCategoriesUrl}');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields['type_id'] = '${type.toString()}';
    print("${request.fields.toString()}");
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        // collectionModal = AllCateModel.fromJson(userData);
        catlist = CategoriesModel.fromJson(userData).data!;
        // print(
        //     "ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
      });
    }
    print(responseData);
  }

  List<Varients> productsVariants = [];
  var varTypeValue;
  _getFoodVarients() async {
    var uri = Uri.parse('${Apipath.getFoodVariantsUrl}');
    var request = new http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        productsVariants = ProductVarientModel.fromJson(userData).data!;
      });
    }
    print(responseData);
  }

  getSubCategory(String? id) async {
    var headers = {
      'Cookie': 'ci_session=5b275056e99daf066cd95d54b384b2ccd46f50b1'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${Apipath.getCategoriesUrl}'));
    request.fields.addAll({'p_id': '$id'});
    print("res ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("json response here  ${jsonResponse} and ${jsonResponse}");
      setState(() {
        subCategoryModel = jsonResponse['data'];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  // Future getImage(ImageSource media) async {
  //   var img = await picker.getImage(source: media);
  //
  //   setState(() {
  //     image1 = img;
  //
  //   });
  // }
  // Future getImageFromCamera(ImageSource media)async{
  //   var img = await picker.getImage(source: media);
  //   setState(() {
  //     image1 = img;
  //   });
  // }

  String? uid;
  String? type;
  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString(TokenString.userid);
      type = prefs.getString(TokenString.type);
    });
    _getCollection();
  }

  void requestPermission(BuildContext context, int i) async {
    if (await Permission.camera.isPermanentlyDenied ||
        await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.storage,
      ].request();
// You can request multiple permissions at once.

      if (statuses[Permission.camera] == PermissionStatus.granted &&
          statuses[Permission.storage] == PermissionStatus.granted) {
        // getImage(ImgSource.Both, context,i);

      } else {
        if (await Permission.camera.isDenied ||
            await Permission.storage.isDenied) {
          // The user opted to never again see the permission request dialog for this
          // app. The only way to change the permission's status now is to let the
          // user manually enable it in the system settings.
          openAppSettings();
        } else {
          setSnackBar("Oops you just denied the permission");
        }
      }
    }
  }

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
  void getCropImage(BuildContext context, int i, var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    setState(() {
      if (i == 1) {
        productImage = File(croppedFile!.path);
      }
    });
  }

  ///MULTI IMAGE PICKER
  ///
  ///
  var imagePathList;
  bool isImages = false;
  Future<void> getFromGallery() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result != null) {
      setState(() {
        isImages = true;
        // servicePic = File(result.files.single.path.toString());
      });
      imagePathList = result.paths.toList();
      // imagePathList.add(result.paths.toString()).toList();
      print("SERVICE PIC === ${imagePathList.length}");
    } else {
      // User canceled the picker
    }
  }

  Widget uploadMultiImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () async {
              getFromGallery();
              // await pickImages();
            },
            child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor().colorPrimary()),
                child: Center(
                    child: Text(
                      "Upload Pictures",
                      style: TextStyle(color: AppColor().colorBg1()),
                    )))),
        const SizedBox(
          height: 10,
        ),
        Visibility(
            visible: isImages,
            child: imagePathList != null ? buildGridView() : SizedBox.shrink())
      ],
    );
  }

  Widget buildGridView() {
    return Container(
      height: 165,
      child: GridView.builder(
        itemCount: imagePathList.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Image.file(File(imagePathList[index]),
                          fit: BoxFit.cover),
                    ),
                  )),
              Positioned(
                top: 5,
                right: 10,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      imagePathList.remove(imagePathList[index]);
                    });
                  },
                  child: Icon(
                    Icons.remove_circle,
                    size: 30,
                    color: Colors.red.withOpacity(0.7),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  ///MULTI IMAGE PICKER
  ///
  ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     plannameController.text = widget.myPlanModel.title;
     descriptionController.text = widget.myPlanModel.description;
     personController.text = widget.myPlanModel.noOfPerson;
     planType = widget.myPlanModel.planType;
     mainPlanValue = widget.myPlanModel.mainPlanType == "residence" ?  "Residence" : "Commercial";
     pujaSamagri =  widget.myPlanModel.poojaSamagri == "1" ? 'Yes' :"No";
      fruitAndFlower = widget.myPlanModel.fruitFlower == "1" ? "Yes" : "No";
      priceController.text = widget.myPlanModel.price.toString();
      ///

    // Future.delayed(Duration(milliseconds: 500),(){
    checkingLogin();
    _getFoodVarients();
    // });
  }

  // Widget imageRC() {
  //   return Material(
  //     elevation: 0,
  //     borderRadius: BorderRadius.circular(15),
  //     child: InkWell(
  //       onTap: () {
  //         pickImages();
  //         // openImages();
  //         // requestPermission(context, 1);
  //         // uploadRCFromCamOrGallary(context);
  //       },
  //       child: Center(
  //         child: Container(
  //           width: 120,
  //           color: AppColor().colorBg2(),
  //           child: Stack(children: [
  //             DottedBorder(
  //               borderType: BorderType.RRect,
  //               radius: Radius.circular(15),
  //               child: Container(
  //                 height: 100,
  //                 width: 100,
  //                 decoration: BoxDecoration(
  //                     // border: Border.all(color: Colors.grey),
  //                     borderRadius: BorderRadius.circular(15)),
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(15),
  //                   child: picturesList[0].path != null
  //                       ? Image.file(File(picturesList[0].path),
  //                           fit: BoxFit.cover)
  //                       : Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Center(child: Icon(Icons.image, size: 40)),
  //                             Text("Upload Pictures")
  //                           ],
  //                         ),
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               right: 1,
  //               bottom: 2,
  //               child: Container(
  //                 padding: EdgeInsets.all(5),
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(100),
  //                   color: AppColor.PrimaryDark,
  //                 ),
  //                 child: Icon(
  //                   Icons.photo_camera_outlined,
  //                   color: Colors.white,
  //                   size: 15,
  //                 ),
  //               ),
  //             ),
  //           ]),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void containerForSheet<T>({BuildContext? context, Widget? child}) {
    showCupertinoModalPopup<T>(
      context: context!,
      builder: (BuildContext context) => child!,
    ).then<void>((T? value) {});
  }

  uploadRCFromCamOrGallary(BuildContext context) {
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
              getImageFromCamera();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "Photo & Video Library",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getImageFromGallery();
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

  File? productImage;
  Future<void> getImageFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        productImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  final ImagePicker imgpicker = ImagePicker();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFiles;

  Future<void> getImageFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        productImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }


  /// add plan function

  EditPlansfunction()async{
    var headers = {
      'Cookie': 'ci_session=1732e842d584ee5aa85d8d64af10f533690dfd25'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.BASH_URL}update_plan'));
    request.fields.addAll({
      'id':"${widget.myPlanModel.id}",
      'vendor': '${uid}',
      'title': plannameController.text,
      'description': descriptionController.text,
      'price': priceController.text,
      'plan_type': planType.toString(),
      'no_of_person': personController.text,
      'pooja_samagri': pujaSamagri == "Yes" ? '1' : '0',
      'fruit_flower':  fruitAndFlower == "Yes" ? "1" : "0",
      'main_plan_type': mainPlanValue == "Residence" ? "residence": "commercial",
    });
    imagePathList == null ? null : request.files.add(await http.MultipartFile.fromPath(
        'image', '${imagePathList[0].toString()}'));
    // request.files.add(await http.MultipartFile.fromPath('image', '/C:/Users/Indian/Downloads/Group 51056.png'));
    print("request fields here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResuylt = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResuylt);
      if(jsonResponse['response_code'] == "0"){
        Fluttertoast.showToast(msg: "${jsonResponse['msg']}");
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ))
        Navigator.pop(context,true);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
   // print("sfsf ${widget.myPlanModel.mainPlanType}");
    changeStatusBarColor(AppColor().colorBg2());
    return Scaffold(
      backgroundColor: AppColor().colorPrimary(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context, true);
              imagePathList.clear();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: AppColor().colorPrimary(),
        title: Text(
          "Edit Plans",
          style: TextStyle(color: AppColor().colorBg1()),
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColor().colorSecondary(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              )),
          child: Container(
              padding: EdgeInsets.only(top: 30),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColor().colorBg2(),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45)),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 10,),
                    // Container(
                    //   height: 90,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       // imageRC(),
                    //
                    //
                    //       // InkWell(
                    //       //   onTap: (){
                    //       //     myAlert1();
                    //       //   },
                    //       //   child: Container(
                    //       //     width: 120,
                    //       //     height: 90,
                    //       //     child: Stack(
                    //       //       children: [
                    //       //         DottedBorder(
                    //       //             color: Colors.black,
                    //       //             strokeWidth: 1,
                    //       //             child: Container(
                    //       //               alignment: Alignment.center,
                    //       //               height: 80,
                    //       //               width: 100,
                    //       //               child:image2 != null ? Image.file(File(image2!.path),fit: BoxFit.fill,width: 100,) : Column(
                    //       //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //       //                 mainAxisAlignment: MainAxisAlignment.center,
                    //       //                 children: [
                    //       //                   Icon(Icons.image),
                    //       //                   Text("Add Picture"),
                    //       //                 ],
                    //       //               ),
                    //       //             )
                    //       //         ),
                    //       //         Positioned(
                    //       //           right: 1,
                    //       //           bottom: 1,
                    //       //           child: Container(
                    //       //             padding: EdgeInsets.all(5),
                    //       //             decoration: BoxDecoration(
                    //       //               borderRadius: BorderRadius.circular(100),
                    //       //               color: AppColor.PrimaryDark,
                    //       //             ),
                    //       //             child: Icon(Icons.photo_camera_outlined,color: Colors.white,size: 15,),
                    //       //           ),
                    //       //         ),
                    //       //       ],
                    //       //     ),
                    //       //   ),
                    //       // ),
                    //
                    //     ],
                    //   ),
                    // ),
                    // buildGridView(),
                    SizedBox(
                      height: 25,
                    ),

                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Main Plan",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.7))),
                        child: DropdownButton(
                          // Initial Value
                          value: mainPlanValue,
                          underline: Container(),
                          isExpanded: true,
                          // Down Arrow Icon
                          icon: Icon(Icons.keyboard_arrow_down),
                          hint: Text("Select plan"),
                          // Array list of items
                          items:
                          ['Residence','Commercial'].map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Container(child: Text(items.toString())),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (newValue) {
                            setState(() {
                              mainPlanValue = newValue.toString();
                              //  getSubCategory(categoryValue);
                              print("selected category ${mainPlanValue}");
                            });
                          },
                        ),
                      ),
                    ),

                    /// plan type here
                    Text(
                      "Plan Type",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.7))),
                        child: DropdownButton(
                          // Initial Value
                          value: planType,
                          underline: Container(),
                          isExpanded: true,
                          // Down Arrow Icon
                          icon: Icon(Icons.keyboard_arrow_down),
                          hint: Text("Select plan"),
                          // Array list of items
                          items:
                          ['Economy', 'Premium', 'standard'].map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Container(child: Text(items.toString())),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (newValue) {
                            setState(() {
                              planType = newValue.toString();
                              //  getSubCategory(categoryValue);
                              print("selected category ${planType}");
                            });
                          },
                        ),
                      ),
                    ),

                    /// name controller
                    Text(
                      "Plan Name",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: plannameController,
                      decoration: InputDecoration(
                          hintText: "Plan Name",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                    /// description controller
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Description",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                          hintText: "Description",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                    /// No of person
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Number of Person",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: personController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Number of Person",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),

                    ///   pooja samgri

                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Pooja Samagri",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.7))),
                        child: DropdownButton(
                          // Initial Value
                          value: pujaSamagri,
                          underline: Container(),
                          isExpanded: true,
                          // Down Arrow Icon
                          icon: Icon(Icons.keyboard_arrow_down),
                          hint: Text("Pooja Samagri"),
                          // Array list of items
                          items:
                          ['Yes', 'No'].map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Container(child: Text(items.toString())),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (newValue) {
                            setState(() {
                              pujaSamagri = newValue.toString();
                              //  getSubCategory(categoryValue);
                              print("selected category ${pujaSamagri}");
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    /// Fruites and flower

                    Text(
                      "Fruits and flowers",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.7))),
                        child: DropdownButton(
                          // Initial Value
                          value: fruitAndFlower,
                          underline: Container(),
                          isExpanded: true,
                          // Down Arrow Icon
                          icon: Icon(Icons.keyboard_arrow_down),
                          hint: Text("Select Type"),
                          // Array list of items
                          items:
                          ['Yes', 'No'].map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Container(child: Text(items.toString())),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (newValue) {
                            setState(() {
                              fruitAndFlower = newValue.toString();
                              //  getSubCategory(categoryValue);
                              print("selected category ${fruitAndFlower}");
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Radio(
                    //               value: 1,
                    //               groupValue: _value1,
                    //               onChanged: (int? value) {
                    //                 setState(() {
                    //                   _value1 = value!;
                    //                   productType = "Veg";
                    //                   // roleUser = true;
                    //                   // isUpi = false;
                    //                 });
                    //               }),
                    //           SizedBox(
                    //             width: 10.0,
                    //           ),
                    //           Container(
                    //             padding: EdgeInsets.all(10),
                    //             // height: 40,
                    //             decoration: BoxDecoration(
                    //                 color: AppColor().colorBg1(),
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 border: Border.all(
                    //                     color: AppColor().colorPrimary())),
                    //             child: Row(
                    //               children: [
                    //                 Image.asset(
                    //                   'images/veg.png',
                    //                   height: 20,
                    //                   width: 20,
                    //                 ),
                    //                 SizedBox(
                    //                   width: 5,
                    //                 ),
                    //                 Text("Veg")
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Radio(
                    //               value: 2,
                    //               groupValue: _value1,
                    //               onChanged: (int? value) {
                    //                 setState(() {
                    //                   _value1 = value!;
                    //                   productType = "Non-Veg";
                    //                   // roleUser = false;
                    //                   // isUpi = true;
                    //                 });
                    //               }),
                    //           SizedBox(
                    //             width: 10.0,
                    //           ),
                    //           Container(
                    //             padding: EdgeInsets.all(10),
                    //             // height: 40,
                    //             decoration: BoxDecoration(
                    //                 color: AppColor().colorBg1(),
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 border: Border.all(
                    //                     color: AppColor().colorPrimary())),
                    //             child: Row(
                    //               children: [
                    //                 Image.asset(
                    //                   'images/nonveg.png',
                    //                   height: 20,
                    //                   width: 20,
                    //                 ),
                    //                 SizedBox(
                    //                   width: 5,
                    //                 ),
                    //                 Text("Non-Veg")
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    /// product varient
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                    //   child: Container(
                    //     height: 60,
                    //     padding: EdgeInsets.only(left: 10),
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(7),
                    //         border: Border.all(
                    //             color: Colors.black.withOpacity(0.7))),
                    //     child: DropdownButton(
                    //       // Initial Value
                    //       value: varTypeValue,
                    //       underline: Container(),
                    //       isExpanded: true,
                    //       // Down Arrow Icon
                    //       icon: Icon(Icons.keyboard_arrow_down),
                    //       hint: Text("Select Product Variant"),
                    //       // Array list of items
                    //       items: productsVariants.map((items) {
                    //         return DropdownMenuItem(
                    //           value: items.name,
                    //           child:
                    //               Container(child: Text(items.name.toString())),
                    //         );
                    //       }).toList(),
                    //       // After selecting the desired option,it will
                    //       // change button value to selected value
                    //       onChanged: (newValue) {
                    //         setState(() {
                    //           varTypeValue = newValue;
                    //           // getSubCategory(categoryValue);
                    //           print("selected variant ${varTypeValue}");
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 60,
                    //   padding: EdgeInsets.only(left: 10),
                    //   decoration: BoxDecoration(
                    //     color: AppColor().colorBg1(),
                    //       borderRadius: BorderRadius.circular(7),
                    //       border: Border.all(
                    //           color: Colors.black.withOpacity(0.7))),
                    //   child: DropdownButton(
                    //
                    //     // Initial Value
                    //     value: varTypeValue,
                    //     underline: Container(),
                    //     isExpanded: true,
                    //     // Down Arrow Icon
                    //     icon: Icon(Icons.keyboard_arrow_down),
                    //     hint: Text("Select Variant Type"),
                    //     // Array list of items
                    //     items: variantType.map((items) {
                    //       return DropdownMenuItem(
                    //         value: items,
                    //         child: Container(
                    //             child: Text(items.toString())),
                    //       );
                    //     }).toList(),
                    //     // After selecting the desired option,it will
                    //     // change button value to selected value
                    //     onChanged: (newValue) {
                    //       setState(() {
                    //         varTypeValue = newValue!;
                    //         print(
                    //             "selected category ${varTypeValue.toString()}");
                    //       });
                    //     },
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    Text(
                      "Price",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Price",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    // /// selling price controller
                    // Text(
                    //   "Special Price",
                    //   style:
                    //   TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    // ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    // TextFormField(
                    //   controller: sellingPriceController,
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //       hintText: "Special Price",
                    //       fillColor: Colors.white,
                    //       filled: true,
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(8),
                    //       )),
                    // ),
                    // SizedBox(
                    //   height: 12,
                    // ),

                    // uploadMultiImage(),

                    SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            if (plannameController.text.isNotEmpty &&
                                priceController.text.isNotEmpty &&
                                planType != null) {
                              EditPlansfunction();
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              Fluttertoast.showToast(
                                  msg: "Please fill required fields!");
                            }
                          },
                          child: Container(
                              height: 43,
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColor().colorSecondary()),
                              child: Center(
                                  child: isLoading
                                      ? loadingWidget()
                                      : Text("Submit",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppColor.PrimaryDark)))),
                        )
                      // AppBtn(
                      //   onPress: (){
                      //     setState((){
                      //       isLoading = true;
                      //     });
                      //     EditPlans();
                      //   },
                      //   label: "Submit",
                      // ),
                    ),
                    // InkWell(
                    //   onTap: (){
                    //     EditPlans();
                    //   },
                    //   child: Container(
                    //     height: 45,
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(8),
                    //         color: AppColor.PrimaryDark
                    //     ),
                    //     child: Text("Submit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),),
                    //   ),
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ))),
    );
  }
}
