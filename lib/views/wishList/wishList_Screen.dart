import 'dart:convert';

import 'package:dr_plus/Utils/colors.dart';
import 'package:dr_plus/controllers/wishList_controller.dart';
import 'package:dr_plus/models/Get_wish_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/Get_wish_list_model.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    getWishListApi();
  }
  getUserId() async {
    SharedPreferences  preferences = await  SharedPreferences.getInstance();
    userId =  preferences.getString("user_id");
    print('____user_Id______${userId}_________');
  }
   String? userId;
  GetWishListModel ? getWishListModel;
  getWishListApi() async {
    SharedPreferences  preferences = await  SharedPreferences.getInstance();
       userId =  preferences.getString("user_id");
    print('__________${userId}_________');
    var headers = {
      'Cookie': 'ci_session=84ac381b0bea62c88d297e89f972727ab7eba30e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_booking/user/app/v1/api/get_wishlist'));
    request.fields.addAll({
      'user_id': userId.toString()
    });
    print('______request.fields____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result =  await response.stream.bytesToString();
     var finalResult = GetWishListModel.fromJson(jsonDecode(result));
     print('____finalResult______${finalResult}_________');
     setState(() {
       getWishListModel = finalResult;
     });
    }
    else {
    print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wish List'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      AppColors.secondary.withOpacity(0.1),
                      AppColors.secondary
                    ])),
          ),
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios)),
          actions: const [],
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              getWishListModel?.data == null || getWishListModel?.data == "" ? Center(child: CircularProgressIndicator()):getWishListModel!.data!.length == 0 ?Center(child: Padding(padding: const EdgeInsets.all(8.0), child: Text("No data found!!"),
              ),) :Container(
                height:MediaQuery.of(context).size.height/1.2,
                child: ListView.builder(
                    itemCount: getWishListModel?.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      height: 90,
                                      width: 90,
                                      child: getWishListModel?.data![index].image == null ||
                                          getWishListModel?.data![index].title ==
                                              ""
                                          ? Image.asset(
                                          'assets/images/doctor4')
                                          : ClipRRect(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  10)),
                                          child: Image.network(getWishListModel?.data![index].image ??
                                              ''))),

                                     Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                     SizedBox(height: 5,),
                                       Row(children: [
                                       Text("${getWishListModel?.data![index].title}",style: TextStyle(color: AppColors.secondary),),
                                       Text("${getWishListModel?.data![index].username}"),
                                     ],),
                                      SizedBox(
                                                   height: 5,
                                                 ),
                                      Text('${getWishListModel?.data![index].docDigree}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.black)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('${getWishListModel?.data![index].companyDivision}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.black)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('${getWishListModel?.data![index].experience}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.black)),
                                      SizedBox(
                                         height: 5,
                                       ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/Icons/placeicon.png',
                                            height: 15,
                                            width: 15,
                                          ),
                                          SizedBox(
                                            width: 1,
                                          ),
                                          Container(
                                              width: 80,
                                              child: Text(
                                                    "${getWishListModel!.data![index].placeName}",
                                                style: TextStyle(
                                                    fontSize:
                                                    12,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500),
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                              )),
                                          Image.asset(
                                            'assets/Icons/cityicon.png',
                                            height: 15,
                                            width: 15,
                                          ),
                                          SizedBox(
                                            width: 1,
                                          ),
                                          Container(
                                              width: 40,
                                              child: Text(
                                                  "${getWishListModel!.data![index].cityName}",
                                                  style: TextStyle(
                                                      fontSize:
                                                      12,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis))),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            'assets/Icons/state_icon.png',
                                            height: 15,
                                            width: 15,
                                          ),
                                          SizedBox(
                                            width: 1,
                                          ),
                                          Container(
                                              width: 70,
                                              child: Text(
                                                  "${getWishListModel!.data![index].stateName}",
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  style: TextStyle(
                                                      fontSize:
                                                      10,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500))),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        )
    );
  }
}
