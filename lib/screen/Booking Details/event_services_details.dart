
import 'dart:convert';
import 'dart:io';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/modal/New%20models/PostStatusModel.dart';
import 'package:fixerking/new%20model/Get_vendor_order_Model.dart';
import 'package:fixerking/new%20model/VendorBookingModel.dart';
import 'package:fixerking/new%20model/delivery_booking_model.dart';
import 'package:fixerking/new%20model/update_order.dart';
import 'package:fixerking/screen/notification_screen.dart';
import 'package:fixerking/token/app_token_data.dart';
import 'package:fixerking/token/token_string.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class EventServiceDetails extends StatefulWidget {
  Data data;

  EventServiceDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<EventServiceDetails> createState() => _EventServiceDetailsState();
}

class _EventServiceDetailsState extends State<EventServiceDetails> {
  var profilePic = null;
  bool cnfrmDelivery = false;
  TextEditingController otpController = TextEditingController();
  TextEditingController? otpC;

  String? dropdownvalue;
  var items = [
    'Accepted',
    'Start',
    'Completed',
    'Cancel',
  ];

  Future updateFoodOrderStatus(String id, status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(TokenString.userid);
    // var userId = await MyToken.getUserID();
    // print("usre id here ${userId}");
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.acceptRejectServiceStatus}'));
    request.fields.addAll({'booking_id': '$id', 'status': '$status','user_id':uid.toString()});
    print("request of status ${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var data = UpdateOrder.fromJson(json.decode(str));
      // await _refresh();
      Fluttertoast.showToast(msg: data.message.toString());
      Navigator.pop(context, true);
      return UpdateOrder.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Widget customerDetails() {
    // print(" checking date ${widget.data.date}");
    // var dateFormate =
    // DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.data.date ?? ""));
    // var bookingTime = TimeOfDay(hour: DateTime.parse(widget.data.createDate!).hour , minute: DateTime.parse(widget.data.createDate!).minute) ;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.PrimaryDark),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Name",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Text("${widget.data.username}",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      ))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Container(
                    width: 200,
                    alignment: Alignment.centerRight,
                    child: Text("${widget.data.address}",
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: AppColor().colorPrimary(),
                          fontWeight: FontWeight.normal,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mobile No.",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Text("${widget.data.mobile}",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bookCard() {
    // var dateFormate =
    // DateFormat("dd, MMMM yyyy").format(DateTime.parse(widget.data.date!));
    // var bookingTime = TimeOfDay(
    //     hour: DateTime.parse(widget.data.date!).hour,
    //     minute: DateTime.parse(widget.data.date!).minute);
    // var timeString =
    //     "${bookingTime.hour} : ${bookingTime.minute} ${bookingTime.period.name}";
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.PrimaryDark),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Job Status",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  widget.data.status == "3" ?
                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green
                    ),
                    child: Center(child: Text("Completed",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    ),
                  ):
                  widget.data.status == "4" ?
                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red
                    ),
                    child: Center(
                        child: Text("Cancelled",
                      style: TextStyle(
                          color: Colors.white
                      ),
                        ),
                    ),
                  ) :
                  widget.data.status == "0" ?
                  SizedBox.shrink()
                      :  Padding(
                    padding: const EdgeInsets.only(),
                    child: Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.PrimaryDark),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            // hint: Text("Status Update"),
                            value: dropdownvalue,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 24,
                              color: AppColor.PrimaryDark,
                            ),
                            elevation: 10,
                            // underline: Container(
                            //   height: 3,
                            //   color: colors.whit,
                            // ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownvalue = value!;
                              });
                              if(value != "Start" && value != "Completed"){
                                updateDeliveryStatus(
                                    widget.data.bookingId.toString(),
                                    dropdownvalue.toString());
                              }
                            },
                            items: items.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: AppColor.PrimaryDark),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  RawMaterialButton(
                    constraints: BoxConstraints.expand(width: 40, height: 40),
                    // onPressed: () {},
                    onPressed: () {
                      otpDialog(widget.data.status, widget.data.otp, widget.data.bookingId);
                      // print("statusssssss");
                      // print("${widget.data.otp}________otp");
                      // print("${widget.data.otp!.isNotEmpty}________otp");
                      // print("${widget.data.otp!= "0"}________otp");
                      // print("${widget.data.status == "2" || widget.data.status == "3"}________stsuss");
                      // print("${widget.data.status}________stsuss");
                      // print("check alll condition herereer ${widget.data.otp != null &&
                      //     widget.data.otp!.isNotEmpty && widget.data.otp!= "0" &&
                      //     widget.data.status == "2" || widget.data.status == "3"}");
                      // // otpDialog(widget.data.status, widget.data.otp, widget.data.bookingId);
                      // if (widget.data.otp != null &&
                      //     widget.data.otp!.isNotEmpty &&
                      //     widget.data.otp!= "0" &&
                      //     widget.data.status == "2" || widget.data.status == "3") {
                      //   print("${widget.data.status}________stsuss");
                      //   otpDialog(widget.data.status, widget.data.otp, widget.data.bookingId);
                      // }
                      // else {
                      //   print("working nowwwwww");
                      //  // updateDeliveryStatus(widget.data.bookingId.toString(), widget.data.status!);
                      // }
                    },
                    elevation: 2.0,
                    padding: const EdgeInsets.only(left: 5),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.send,
                        size: 20,
                        color: colors.primary,
                      ),
                    ),
                    shape: CircleBorder(),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(12),
                  //   height: 40,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: widget.data.status == "0" ||
                  //           widget.data.status == "1" ||
                  //           widget.data.status == "2"
                  //           ? colors.yellow
                  //           : widget.data.status == "3"
                  //           ? colors.green
                  //           : colors.red),
                  //   child: Center(
                  //     child: Text(
                  //       widget.data.status == "0"
                  //           ? "Ongoing"
                  //           : widget.data.status == "1"
                  //           ? "Ongoing"
                  //           : widget.data.status == "2"
                  //           ? "Ongoing"
                  //           : widget.data.status == "3"
                  //           ? "Delivered"
                  //           : "Cancelled",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w600,
                  //           color:
                  //           widget.data.status == "0"
                  //               ? colors.primary
                  //               : widget.data.status == "1"
                  //               ?  colors.primary
                  //               : widget.data.status == "2"
                  //               ?  colors.primary
                  //               : widget.data.status == "3"
                  //               ? colors.whit
                  //               : colors.whit),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 5),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Booking Id",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      ),
                  ),
                  Text("${widget.data.bookingId}",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Order Id',
              //     ),
              //     Container(
              //         alignment: Alignment.centerRight,
              //         child: widget.data.pStatus == "0"
              //             ? Text(
              //                 "In Progress",
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     color: AppColor().colorPrimary()),
              //               )
              //             : widget.data.pStatus == "1"
              //                 ? Text(
              //                     "Accepted by Delivery Services",
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         color: AppColor().colorPrimary()),
              //                   )
              //                 : widget.data.pStatus == "2"
              //                     ? Text(
              //                         "Cancelled by User",
              //                         textAlign: TextAlign.center,
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold,
              //                             color: AppColor().colorPrimary()),
              //                       )
              //                     : widget.data.pStatus == "3"
              //                         ? Text(
              //                             "Shipped",
              //                             textAlign: TextAlign.center,
              //                             style: TextStyle(
              //                                 fontWeight: FontWeight.bold,
              //                                 color:
              //                                     AppColor().colorPrimary()),
              //                           )
              //                         : widget.data.pStatus == "4"
              //                             ? Text(
              //                                 "On the way",
              //                                 textAlign: TextAlign.center,
              //                                 style: TextStyle(
              //                                     fontWeight: FontWeight.bold,
              //                                     color: AppColor()
              //                                         .colorPrimary()),
              //                               )
              //                             : widget.data.pStatus == "5"
              //                                 ? Text(
              //                                     "Delivered",
              //                                     textAlign: TextAlign.center,
              //                                     style: TextStyle(
              //                                         fontWeight:
              //                                             FontWeight.bold,
              //                                         color: AppColor()
              //                                             .colorPrimary()),
              //                                   )
              //                                 : Text(
              //                                     "",
              //                                     textAlign: TextAlign.center,
              //                                     style: TextStyle(
              //                                         fontWeight:
              //                                             FontWeight.bold,
              //                                         color: AppColor()
              //                                             .colorPrimary()),
              //                                   )
              //         // decoration: BoxDecoration(
              //         //     color: Colors.grey.shade100,
              //         //     borderRadius: BorderRadius.circular(5)),
              //         ),
              //   ],
              // ),
              Divider(),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Schedule Date',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Text('${widget.data.scheduleDate}',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                ],
              ),
              Divider(),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Booking Date',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Text('${widget.data.date}',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Booking Time',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      ),
                  ),
                  Text('${widget.data.slot}',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Payment Mode',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Text("${widget.data.paymentMode}",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                ],
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  otpDialog(String? status, String? otp, String? bookingId,) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStater) {
                return AlertDialog(
                  contentPadding: const EdgeInsets.all(0.0),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  content: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(20.0, 20.0, 20, 2.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text("₹ ${widget.data!.total!}",
                                  //     style: TextStyle(
                                  //         fontWeight: FontWeight.bold,
                                  //         color: colors.primary,
                                  //         fontSize: 22)),
                                ],
                              ),
                            ),
                            Padding(
                                padding:
                                const EdgeInsets.fromLTRB(20.0, 40.0, 0, 2.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Otp:-",
                                      style: Theme.of(this.context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(color: colors.primary),
                                    ),
                                    SizedBox(width: 10),
                                    Text("${widget.data.otp}", style: Theme.of(this.context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(color: colors.primary)
                                    ),
                                  ],
                                ),
                            ),
                            const Divider(color: Colors.black38),
                            Form(
                                key: _formkey,
                                child: Column(
                                  children: <Widget>[
                                    Padding(padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "Field Required";
                                            } else if (value.trim() != otp) {
                                              return "Enter Otp";
                                            } else {
                                              return null;
                                            }
                                          },
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          decoration: InputDecoration(
                                            hintText: "Enter Otp",
                                            hintStyle: Theme.of(this.context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                color: colors.primary,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          controller: otpController,
                                        ),),
                                  ],
                                ),),
                          ]),
                  ),
                   actions: <Widget>[
                    TextButton(
                        child: Text(
                          "Cancel",
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    TextButton(
                        child: Text(
                          "Send",
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          final form = _formkey.currentState!;
                          if(status == "1" && dropdownvalue == "Start"){
                            print("Working api in send button");
                            updateDeliveryStatus(bookingId!, "2");
                            Navigator.pop(context);
                          }
                          else if(status == "1" && dropdownvalue == "Completed"){
                            updateDeliveryStatus(bookingId!, "3");
                            Navigator.pop(context);
                          }
                          // if (form.validate()) {
                          //   form.save();
                          //   setState(() {
                          //     Navigator.pop(context);
                          //   });
                          //   updateDeliveryStatus(bookingId!, status!);
                          // }
                        }),
                  ],
                );
              });
        });
  }


  Widget newsev() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.PrimaryDark),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                  ),
                  Container(
                    height: 40,
                    child: VerticalDivider(
                      color: AppColor.PrimaryDark,
                    ),
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                  ),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              ListView.builder(
                  itemCount: widget.data.products!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 4.0, bottom: 4, left: 15, right: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Job",
                                  style: TextStyle(
                                      color: AppColor().colorPrimary(),
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "${widget.data.products![index].artistName}",
                                  // maxLines: 2,
                                  style: TextStyle(
                                      color: AppColor().colorPrimary(),
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Amount",
                                  style: TextStyle(
                                      color: AppColor().colorPrimary(),
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "₹ ${widget.data.products![index].specialPrice}",
                                  // maxLines: 2,
                                  style: TextStyle(
                                      color: AppColor().colorPrimary(),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
 
  
  Widget addOnItem() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.PrimaryDark),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Image.network(widget.data.addOnItem!.img!, scale: 4),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(widget.data.addOnItem!.name!,style: TextStyle(
                  color: AppColor().colorPrimary(),
                  fontWeight: FontWeight.normal,
                ),),
                Text("₹ " + widget.data.addOnItem!.price!,
                  style: TextStyle(
                    color: AppColor().colorPrimary(),
                    fontWeight: FontWeight.normal,
                  ),
                  // style: TextStyle(
                  //     fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ],)
            ],
          ),
        ),
      ),
    );
  }
  
  
  Widget pricingCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.PrimaryDark),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('Subtotal',
              //         style: TextStyle(
              //           color: AppColor().colorPrimary(),
              //           fontWeight: FontWeight.normal,
              //         ),
              //     ),
              //     Text("₹ " + widget.data.subtotal!,
              //         style: TextStyle(
              //           color: AppColor().colorPrimary(),
              //           fontWeight: FontWeight.normal,
              //         ),
              //       //   style: TextStyle(
              //       //       fontSize: 15.0, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('Mehendi GST',
              //         style: TextStyle(
              //           color: AppColor().colorPrimary(),
              //           fontWeight: FontWeight.normal,
              //         )),
              //     Text("₹ " + widget.data.vendorGst!,
              //         style: TextStyle(
              //           color: AppColor().colorPrimary(),
              //           fontWeight: FontWeight.normal,
              //         )
              //       //   style: TextStyle(
              //       //       fontSize: 15.0, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('Platform Charges',
              //         style: TextStyle(
              //           color: AppColor().colorPrimary(),
              //           fontWeight: FontWeight.normal,
              //         ),
              //     ),
              //     Text("- ₹ " + widget.data.platformCharge!,
              //         style: TextStyle(
              //           color: AppColor().colorPrimary(),
              //           fontWeight: FontWeight.normal,
              //         )
              //       //   style: TextStyle(
              //       //       fontSize: 15.0, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('GST & Service Charge',
              //         style: TextStyle(
              //           color: AppColor().colorPrimary(),
              //           fontWeight: FontWeight.normal,
              //         )),
              //     Text("₹ " + widget.data.gstAmount!,
              //         style: TextStyle(
              //           color: AppColor().colorPrimary(),
              //           fontWeight: FontWeight.normal,
              //         )
              //       // style: TextStyle(
              //       //     fontSize: 15.0, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Vendor Pay Amt.',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      ),),
                  Text("₹ " + widget.data.subtotal.toString(),
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      ),
                    // style: TextStyle(
                    //     fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Price',
                    style: TextStyle(
                      color: AppColor().colorPrimary(),
                      fontWeight: FontWeight.normal,
                    ),),
                  Text("₹ " + widget.data.total.toString(),
                    style: TextStyle(
                      color: AppColor().colorPrimary(),
                      fontWeight: FontWeight.normal,
                    ),
                    // style: TextStyle(
                    //     fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget confirmButton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            cnfrmDelivery = true;
            // cnfrmDelivery =!cnfrmDelivery;
          });
        },
        style: ElevatedButton.styleFrom(
            primary: AppColor().colorPrimary(),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            fixedSize: Size(MediaQuery.of(context).size.width - 40, 45)),
        child: Text(""));
  }

  // Future getImage(context, ImgSource source, {from}) async {
  //   var image = await ImagePickerGC.pickImage(
  //       // enableCloseButton: true,
  //       // closeIcon: Icon(
  //       //   Icons.close,
  //       //   color: Colors.red,
  //       //   size: 12,
  //       // ),
  //       context: context,
  //       source: source,
  //       barrierDismissible: true,
  //       cameraIcon: Icon(
  //         Icons.camera_alt,
  //         color: Colors.red,
  //       ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
  //       cameraText: Text(
  //         "From Camera",
  //         style: TextStyle(color: Colors.red),
  //       ),
  //       galleryText: Text(
  //         "From Gallery",
  //         style: TextStyle(color: Colors.blue),
  //       ));
  //   setState(() {
  //     profilePic = image;
  //   });
  // }

  Widget dropDwon() {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.PrimaryDark),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownvalue,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 24,
                  color: AppColor.PrimaryDark,
                ),
                elevation: 10,
                // underline: Container(
                //   height: 3,
                //   color: colors.whit,
                // ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownvalue = value!;
                  });
                },
                hint: Text("Status Update"),
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: AppColor.PrimaryDark),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ));
  }

  updateDeliveryStatus(String id, String status) async {
    print('${status}_____________');
    String stats;
    if (status == "Completed"){
      stats = "3";
    } else if (status == "Cancel"){
      stats = "4";
    } else if (status == "Start"){
      stats = "2";
    }else{
      stats= "1";
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(TokenString.userid);
    var headers = {
      'Authorization':
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjU3NDI0MjgsImlhdCI6MTY2NTc0MjEyOCwiaXNzIjoiZXNob3AifQ.W1CPYxzUdedOnqF_9RCnXzxfXsrgXjD6afFscII8Ijc',
      'Cookie': 'ci_session=pkgacirfg4clhtgbfsecc4g4sg48jfnk'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(Apipath.acceptRejectServiceStatus));
    request.fields.addAll({
      'booking_id': '${id.toString()}',
      'status': '${stats.toString()}',
      'user_id':uid.toString(),
      // 'driver_id': '${uid.toString()}'
      'otp': "${otpController.text.toString()}",
    });
  print("request are here ${request.fields}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("this is response @@ ${response.statusCode}");
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = PostStatusModel.fromJson(json.decode(finalResult));
      print("final result here ${jsonResponse.message}");
      if (jsonResponse.responseCode == "1") {
        Navigator.pop(context);
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
        // isStatus = true;
        // updateRequestFunction('${id}', '${value}');
      } else {
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  String? uid;
  String? type;
  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString(TokenString.userid);
      type = prefs.getString(TokenString.type);
    });
    print("this is type =======>>>${type.toString()}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.data.status == "4"){
      dropdownvalue = 'Cancel';
    }
    else if(widget.data.status == "2"){
      dropdownvalue = 'Start';
    }
    else if(widget.data.status == "3"){
      dropdownvalue = 'Completed';
    }else{
      dropdownvalue = 'Accepted';
    }
    checkingLogin();
  }

  @override
  Widget build(BuildContext context) {
    print("addddd ${widget.data.addOnItem}");
    return Scaffold(
        backgroundColor: AppColor().colorPrimary(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: AppColor().colorPrimary(),
          // title: Text(
          //   type == "5"?
          //   "Mehendi Booking details"
          //       :"Event Booking Details",
          //   style: TextStyle(color: AppColor().colorBg1()),
          // ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()));
                },
                icon: Icon(
                  Icons.notifications,
                  color: AppColor().colorBg1(),
                ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: AppColor().colorSecondary(),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45),
                    )),
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColor().colorBg1(),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 12.0, right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.data.status == "4"
                                ? Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                "Booking Cancelled",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 20),
                              ),
                            )
                                : SizedBox.shrink(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, bottom: 7, top: 10),
                              child: Text(
                                "Customer Details",
                                style: TextStyle(
                                    color: AppColor().colorTextPrimary(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            customerDetails(),
                            // bookDetailCard(),

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 15, left: 10, bottom: 7),
                              child: Text(
                                'Job Details',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            bookCard(),
                             SizedBox(
                            height: 30,
                            ),
                          type == "7"  ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, bottom: 10),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.data.plans!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            border: Border.all(
                                                color: AppColor.PrimaryDark),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  "Plan Detail",
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .colorPrimary(),
                                                      fontWeight:
                                                      FontWeight.normal),
                                                ),
                                                Text(
                                                  "${widget.data.plans![index].title}",
                                                  // maxLines: 2,
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .colorPrimary(),
                                                      fontWeight:
                                                      FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  "Amount",
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .colorPrimary(),
                                                      fontWeight:
                                                      FontWeight.normal),
                                                ),
                                                Text(
                                                  "₹ ${widget.data.subtotal}",
                                                  // maxLines: 2,
                                                  style: TextStyle(
                                                      color: AppColor().colorPrimary(),
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            type == "6" ? SizedBox.shrink(): Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "No. of person",
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .colorPrimary(),
                                                      fontWeight:
                                                      FontWeight.normal),
                                                ),
                                                widget.data.plans![index].noOfPerson == null || widget.data.plans![index].noOfPerson == "null" ? Text("0",style: TextStyle(
                                                    color: AppColor()
                                                        .colorPrimary(),
                                                    fontWeight:
                                                    FontWeight.w600)) :      Text(
                                                  "${widget.data.plans![index].noOfPerson}",
                                                  // maxLines: 2,
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .colorPrimary(),
                                                      fontWeight:
                                                      FontWeight.w600),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  "Plan Type",
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .colorPrimary(),
                                                      fontWeight:
                                                      FontWeight.normal),
                                                ),
                                                Text(
                                                  "${widget.data.plans![index].planType}",
                                                  // maxLines: 2,
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .colorPrimary(),
                                                      fontWeight:
                                                      FontWeight.w600),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  "Main Plan Type",
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .colorPrimary(),
                                                      fontWeight:
                                                      FontWeight.normal),
                                                ),
                                                Text(
                                                  "${widget.data.plans![index].mainPlanType}",
                                                  // maxLines: 2,
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .colorPrimary(),
                                                      fontWeight:
                                                      FontWeight.w600),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  "Pooja Samagri",
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .colorPrimary(),
                                                      fontWeight:
                                                      FontWeight.normal),
                                                ),
                                                Text(
                                                 widget.data.plans![index].poojaSamagri == "0" ? " No" : "Yes" ,
                                                  // maxLines: 2,
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .colorPrimary(),
                                                      fontWeight:
                                                      FontWeight.w600),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  "Fruits & Flower",
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .colorPrimary(),
                                                      fontWeight:
                                                      FontWeight.normal),
                                                ),
                                                Text(
                                                widget.data.plans![index].fruitFlower == "0"  ? "No" :"Yes" ,
                                                  // maxLines: 2,
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .colorPrimary(),
                                                      fontWeight:
                                                      FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ) :
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, bottom: 10),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.data.products!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      border: Border.all(
                                          color: AppColor.PrimaryDark)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            "Job",
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.normal),
                                          ),
                                          Text(
                                            "${widget.data.products![index].artistName}",
                                            // maxLines: 2,
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      type != "6" ?
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            "Amount",
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.normal),
                                          ),
                                          Text(
                                            "₹ ${widget.data.products![index].specialPrice}",
                                            // maxLines: 2,
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.w600),
                                          )
                                        ],
                                      ): SizedBox(),
                                     type == "5" ? Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            "No. of cheff",
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.normal),
                                          ),
                                          Text(
                                            "${widget.data.noOfChef}",
                                            // maxLines: 2,
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.w600),
                                          )
                                        ],
                                      ): SizedBox(),
                                      type == "5" ? Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            "No. of helper",
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.normal),
                                          ),
                                          Text(
                                            "${widget.data.noOfHelper}",
                                            // maxLines: 2,
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.w600),
                                          )
                                        ],
                                      ): SizedBox(),
                                    type == "6" ?  Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            "Per hour charge",
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.normal),
                                          ),
                                          Text(
                                            "${widget.data.vendorPayemntAmount}",
                                            // maxLines: 2,
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.w600),
                                          )
                                        ],
                                      ) : SizedBox(),
                                      type == "6" ?  Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            "Hours",
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.normal),
                                          ),
                                          Text(
                                            "${widget.data.hours} hr.",
                                            // maxLines: 2,
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.w600),
                                          )
                                        ],
                                      ) : SizedBox(),
                                 type == "8" ?  Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            "Main Plan Type",
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.normal),
                                          ),
                                          Text(
                                            "${widget.data.products![index].serviceType}",
                                            // maxLines: 2,
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.w600),
                                          )
                                        ],
                                      ) : SizedBox(),
                                      type == "6" || type == "1" || type == "8" || type == "5" ? SizedBox.shrink() : Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            "No. of person",
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.normal),
                                          ),
                                          widget.data.plans![index].noOfPerson == null || widget.data.plans![index].noOfPerson == "null" ? Text("0",style: TextStyle(
                                              color: AppColor()
                                                  .colorPrimary(),
                                              fontWeight:
                                              FontWeight.w600)) :      Text(
                                            "${widget.data.plans![index].noOfPerson}",
                                            // maxLines: 2,
                                            style: TextStyle(
                                                color: AppColor()
                                                    .colorPrimary(),
                                                fontWeight:
                                                FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                            (widget.data.addOnItem?.status ?? false) == "1" ?
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, bottom: 7, top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Add On Item",
                                    style: TextStyle(
                                        color: AppColor().colorTextPrimary(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(height: 5),
                                  addOnItem(),
                                ],
                              ),
                            ):
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 15, left: 10, bottom: 7),
                              child: Text(
                                'Payment Details',
                                style: TextStyle(
                                    fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            pricingCard(),
                             SizedBox(
                              height: 15,
                            ),
                            widget.data.status == "0" ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      updateFoodOrderStatus(
                                          "${widget.data.bookingId.toString()}", "1");
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        fixedSize: Size(140, 35),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                    child: Text(
                                      "Accept",
                                      style:
                                      TextStyle(fontWeight: FontWeight.w400),
                                    )),
                                const SizedBox(
                                  width: 15,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      updateFoodOrderStatus(
                                          "${widget.data.bookingId.toString()}", "4");
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        fixedSize: Size(140, 35),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                    child: Text(
                                      "Decline",
                                      style:
                                      TextStyle(fontWeight: FontWeight.w400),
                                    ))
                              ],
                            )
                                : SizedBox.shrink(),
                            // dropDwon(),

                            // const SizedBox(
                            //   height: 30,
                            // ),
                            // cnfrmDelivery
                            //     ? SizedBox.shrink()
                            //     : Center(
                            //         child: AppBtn(
                            //           label: "Submit",
                            //           onPress: () {
                            //             updateDeliveryStatus(
                            //                 widget.data.bookingId.toString(),
                            //                 dropdownvalue.toString());
                            //             // setState(() {
                            //             //   cnfrmDelivery = true;
                            //             //   // cnfrmDelivery =!cnfrmDelivery;
                            //             // });
                            //           },
                            //         ),
                            //       ),

                            // customerDetails(),
                            // // bookDetailCard(),
                            //
                            // bookCard(),
                            // newsev(),
                            // pricingCard(),
                            // dropDwon(),
                            //
                            // cnfrmDelivery ? SizedBox.shrink() :
                            // AppBtn(
                            //   label: "Submit",
                            //   onPress: (){
                            //     // setState(() {
                            //     //   cnfrmDelivery = true;
                            //     //   // cnfrmDelivery =!cnfrmDelivery;
                            //     // });
                            //
                            //   },
                            // ),
                            // confirmButton(),

                            SizedBox(
                              height: 20,
                            ),
                            // cnfrmDelivery ? updateDelivery() : SizedBox.shrink()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
            ),
        ),
    );
  }
}
