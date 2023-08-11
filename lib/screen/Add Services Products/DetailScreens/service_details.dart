import 'dart:convert';

import 'package:fixerking/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fixerking/new model/vendor_services_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../../api/api_path.dart';
import '../../../new model/myPlanModel.dart';
import '../../Pandit plans/EditPlan.dart';


class ServiceDetails extends StatefulWidget {
  final Products? model;
  String? serviceId;
   ServiceDetails({Key? key, this.model,this.serviceId}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  Widget buildGridView() {
    return Expanded(
      // height: 165,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.model!.servicesImage!.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.network(widget.model!.servicesImage![index].toString(),
                    fit: BoxFit.cover),
              ));
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500),(){
      return getMyPlans();
    });
  }

  MyPlanModel? myPlanModel;
  getMyPlans()async{

    var headers = {
      'Cookie': 'ci_session=8293aecfffc8b14d423d5f0a043feced4886e492'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.BASH_URL}get_plans'));
    request.fields.addAll({
      's_id': '${widget.serviceId}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = MyPlanModel.fromJson(json.decode(finalResult));
      setState(() {
        myPlanModel = jsonResponse;
      });
      return MyPlanModel.fromJson(json.decode(finalResult));
    }
    else {
      print(response.reasonPhrase);
    }
  }

  deletePlan(ids)async{
    var headers = {
      'Cookie': 'ci_session=ac5a5744499c6038606458b7035684b03a14bfb5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.BASH_URL}delete_plan'));
    request.fields.addAll({
      'id': '${ids}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['response_code'] == '1'){
        setState(() {
          Fluttertoast.showToast(msg: "${jsonResponse['message']}");
        });
        getMyPlans();
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }

  @override
  Widget build(BuildContext context) {
    print("ddddddddddddddddddd ${widget.serviceId}");
    return Scaffold(
      backgroundColor: AppColor().colorPrimary(),
      // floatingActionButton: FloatingActionButton(onPressed: (){
      // Navigator.push(context, MaterialPageRoute(builder: (context) => AddService()));
      // },
      // // Icon(Icons.add,color: AppColor.PrimaryDark,),
      // //   backgroundColor: Colors.white,
      // ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor().colorPrimary(),
        title: Text(
          "Service Details here",
          style: TextStyle(
            color: AppColor().colorBg1(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColor().colorSecondary(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  )),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColor().colorBg1(),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30,left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: Container(
                            // padding: const EdgeInsets.all(10),
                            // only(left: 85, right: 20),
                            height: 190,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              child: Image.network(
                                "${widget.model!.servicesImage![0].toString()}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        buildGridView(),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${widget.model!.artistName.toString()}",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("₹ ${widget.model!.mrpPrice}",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough
                          ),),
                        Text("₹ ${widget.model!.specialPrice}",
                          style: TextStyle(
                              color: AppColor.PrimaryDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Descriptions",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500
                          ),),
                        SizedBox(
                          height: 8,
                        ),
                        Text("${widget.model!.serDesc!.toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
              ),
            ),
            SizedBox(height: 10,),
            Text("Plans for service",style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.w600),),
            SizedBox(height: 10,),
            FutureBuilder(
                future: getMyPlans(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  MyPlanModel? model = snapshot.data;
                  // print("this is moddel ==========>>>>> ${model!.products![0].productPrice.toString()}");
                  if (snapshot.hasData) {
                    return
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: model!.data!.length == 0 ? Center(child: Text("No plans to show",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),) : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: model!.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    bottom: 10.0),
                                child: Stack(
                                  children: [
                                    Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              15),
                                      ),
                                      child: Container(
                                        padding:
                                        const EdgeInsets.all(10),
                                        // only(left: 85, right: 20),
                                        height: 115,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppColor().colorPrimary()),
                                            borderRadius:
                                            BorderRadius.circular(
                                                15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  // model.data![index].image == null ||
                                                  //     model.data![index].image == ""?
                                                  // Container(
                                                  //   height: 60,
                                                  //   width: 60,
                                                  //   decoration:
                                                  //   BoxDecoration(
                                                  //     borderRadius:
                                                  //     BorderRadius
                                                  //         .circular(
                                                  //         10),
                                                  //   ),
                                                  //   child: ClipRRect(
                                                  //     borderRadius:
                                                  //     BorderRadius
                                                  //         .circular(
                                                  //         6),
                                                  //     child:
                                                  //     Icon(
                                                  //       Icons.image,
                                                  //       size: 50,
                                                  //     ),
                                                  //   ),
                                                  // )
                                                  //     : Container(
                                                  //   height: 60,
                                                  //   width: 60,
                                                  //   decoration:
                                                  //   BoxDecoration(
                                                  //     borderRadius:
                                                  //     BorderRadius
                                                  //         .circular(
                                                  //         10),
                                                  //   ),
                                                  //   child: ClipRRect(
                                                  //     borderRadius:
                                                  //     BorderRadius
                                                  //         .circular(
                                                  //         6),
                                                  //     child:
                                                  //     Image
                                                  //         .network(
                                                  //       "${model.data![index].image.toString()}",
                                                  //       fit: BoxFit
                                                  //           .fill,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Container(
                                                        width: 150,
                                                        child: Text(
                                                          "${model.data![index].title}"[0].toUpperCase()  + "${model.data![index].title}".substring(1),
                                                          style:
                                                          TextStyle(
                                                            color: Colors
                                                                .black,
                                                            fontSize:
                                                            14,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: 5),
                                                      Text(
                                                          "\u{20B9} ${model.data![index].price}"),
                                                      SizedBox(
                                                          height: 5),
                                                      Text(
                                                        "${model.data![index].planType}",
                                                        style: TextStyle(
                                                            color:
                                                            Colors.green
                                                        ),)
                                                      // Text("\u{20B9}" + serviceList[i]['price'],
                                                      //   style: TextStyle(
                                                      //     fontSize: 12,
                                                      //     color: Colors.black,
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Row(
                                            //   children: [
                                            //     Card(
                                            //       elevation: 2,
                                            //       child: InkWell(
                                            //           onTap: () {
                                            //             Navigator.push(
                                            //                 context,
                                            //                 MaterialPageRoute(
                                            //                     builder: (context) => EditPlans(
                                            //                       myPlanModel: model.data![index],
                                            //                     )));
                                            //           },
                                            //           child: Icon(
                                            //             Icons.edit,
                                            //             color: AppColor
                                            //                 .PrimaryDark,
                                            //           )),
                                            //     ),
                                            //     SizedBox(
                                            //       width: 6,
                                            //     ),
                                            //     InkWell(
                                            //       onTap: () async{
                                            //         var newResult = await showDialog(
                                            //             context: context,
                                            //             barrierDismissible: false,
                                            //             builder: (BuildContext context) {
                                            //               return AlertDialog(
                                            //                 title: Text("Delete Services?"),
                                            //                 content: Text("Are you sure you want to delete this service?"),
                                            //                 actions: <Widget>[
                                            //                   ElevatedButton(
                                            //                     style: ElevatedButton.styleFrom(
                                            //                         primary: AppColor().colorPrimary()
                                            //                     ),
                                            //                     child: Text("YES"),
                                            //                     onPressed: () async{
                                            //                       await deletePlan(model
                                            //                           .data![index].id.toString());
                                            //                       Future.delayed(Duration(milliseconds: 500), (){
                                            //                         Navigator.pop(context, true);
                                            //                       });
                                            //                       // Navigator.pop(context);
                                            //                     },
                                            //                   ),
                                            //                   ElevatedButton(
                                            //                     style: ElevatedButton.styleFrom(
                                            //                         primary: AppColor().colorPrimary()
                                            //                     ),
                                            //                     child: Text("NO"),
                                            //                     onPressed: () {
                                            //                       Navigator.of(context).pop();
                                            //                     },
                                            //                   )
                                            //                 ],
                                            //               );
                                            //             }
                                            //         );
                                            //         print("this is result ====> ${newResult}");
                                            //
                                            //         if(newResult == true){
                                            //           // await getServices();
                                            //         }
                                            //
                                            //
                                            //       },
                                            //       child: Card(
                                            //         elevation: 2,
                                            //         child: Icon(
                                            //           Icons
                                            //               .delete_forever_rounded,
                                            //           color:
                                            //           Colors.red,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),

                                            // Container(
                                            //   height: 25,
                                            //   width: 80,
                                            //   decoration: BoxDecoration(
                                            //       color: AppColor.PrimaryDark,
                                            //       borderRadius: BorderRadius.circular(30)),
                                            //   child: const Center(
                                            //     child: Text(
                                            //       "View",
                                            //       style: TextStyle(color: Colors.white),
                                            //     ),
                                            //   ),
                                            // )
                                            // AppBtn(
                                            //   title: "View",
                                            //   onPress: (){
                                            //
                                            //   },
                                            //   height: 15,
                                            //   width: 70,
                                            //   fSize: 14,
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                    // CircleAvatar(
                                    //   radius: 37,
                                    //   child: ClipRRect(
                                    //     child: Image.network("${model.products![index].productImage!.toString()}",
                                    //     fit: BoxFit.fill,),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              );
                              //cardWidget(model, i
                            }),
                      );

                  } else if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  } else {
                    return Container(
                        height: 30,
                        width: 30,
                        // MediaQuery.of(context).size.height / 1.5,
                        child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.PrimaryDark,
                            )));
                  }
                })
          ],
        ),
      ),

    );
  }
}
