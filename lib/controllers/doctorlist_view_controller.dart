import 'dart:convert';

import 'package:dr_plus/controllers/appbased_controller/appbase_controller.dart';
import 'package:dr_plus/controllers/home_controller.dart';
import 'package:dr_plus/controllers/signup_controller.dart';
import 'package:dr_plus/models/doctor_list_response.dart';
import 'package:dr_plus/models/get_place_model.dart';
import 'package:dr_plus/route_management/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/colors.dart';
import '../models/get_banner_model.dart';
import '../services/request_keys.dart';
import '../widgets/show_message.dart';
import 'package:http/http.dart'as http;

class DoctorListController extends AppBaseController{

  String? userId;
  void onInit() {
    // TODO: implement onInit
    catId = Get.arguments ;
    super.onInit();
    getShared();
    print('${catId}_________');
    gerUserId();
    print('___userIdddddd_______${userId}_________');
    doctorData();
  }


  gerUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('user_id');
  }


  final homeController = Get.put(HomeController());
  List <getBannerData> bannerData = [] ;
  String? docId;

  getRemoveWishListApi(int index) async {
   String doc_id = doctorListData[index].id.toString() ;
   update();
   var headers = {
     'Cookie': 'ci_session=4b2d043daee70cd543dd021fac8e91598d8d9a10'
   };
   var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_booking/user/app/v1/api/remove_wishlist'));
   request.fields.addAll({
     'user_id': userId.toString(),
     'dr_id': '${doc_id}'
   });
   update();
   request.headers.addAll(headers);
   http.StreamedResponse response = await request.send();
   if (response.statusCode == 200) {
     var  result =   await response.stream.bytesToString();
     var  finalResult = jsonDecode(result);
     Fluttertoast.showToast(msg: "${finalResult['message']}");

   }
   else {
     print(response.reasonPhrase);
   }

 }


  addWishlistApi( int index) async {
    String doc_id = doctorListData[index].id.toString() ;
    update();
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // userId = preferences.getString('user_id');
    print('____userId!@#______${userId}_________');
    var headers = {
      'Cookie': 'ci_session=8493ab1e62f4c7466bc379bc02c1c8b0d42ad42e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_booking/user/app/v1/api/add_wishlist'));
    request.fields.addAll({
      'user_id': userId.toString(),
      'dr_id': '${doc_id}'
    });
    update();
    print('request.fields${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
   var  result =   await response.stream.bytesToString();
   var  finalResult = jsonDecode(result);
   Fluttertoast.showToast(msg: "${finalResult['message']}");

    }
    else {
      print(response.reasonPhrase);
    }

  }
  final signupController = Get.put(SignupController());
  List <GetPlacedData>getPlacedData = [];
  int currentIndex = 0;
  String? catId ;
  @override

  Future<void> getShared() async {
   SharedPreferences preferences  = await  SharedPreferences.getInstance();
   preferences.setString("categoryId", catId!);

 }

  void onTapDoctorDetails(int index){
    bannerData = homeController.sliderList;
    docId = doctorListData[index].id.toString() ;
    print('___scssasad_______${doctorListData[index].id}_________');
    Get.toNamed(doctorDetailsScreen, arguments: docId);
    Get.toNamed(doctorDetailsScreen);
  }
  void onTapDoctorWishListIcon(int index){
  }
  void onTapDoctorList(int index){
  }
  int currentPost =  0;

   buildDots() {
   List<Widget> dots = [];
   for (int i = 0; i < (homeController.sliderList.length ?? 10); i++) {
     dots.add(
       Container(
         margin: EdgeInsets.all(1.5),
         width: 6,
         height: 6,
         decoration: BoxDecoration(
           shape: BoxShape.circle,
           color: currentPost == i
               ? AppColors.secondary
               : Colors.grey.withOpacity(0.5),
         ),
       ),
     );
     //update();
   }
   return dots;
 }
  List<Map<String,dynamic>> sliderList =[
    {'image':'assets/images/doctor4.png','name':'Dr.Karan Mehra','profession':'Consultant Dermatology','address':'MBBS, MD, FCR (London)','experience':'Year of exp : 12 Years'},
    {'image':'assets/images/doctor5.png','name':'Dr.Karan Mehra','profession':'Consultant Dermatology','address':'MBBS, MD, FCR (London)','experience':'Year of exp : 12 Years'},
    {'image':'assets/images/doctor6.png','name':'Dr.Karan Mehra','profession':'Consultant Dermatology','address':'MBBS, MD, FCR (London)','experience':'Year of exp : 12 Years'},

  ];
  List<Map<String,dynamic>> items =[
    {'icon':'assets/Icons/placeicon.png','State':'Vasai(W)','icon1':'assets/Icons/cityicon.png','City':'Mumbai','icon2':'assets/Icons/state_icon.png','Place':'Maharashtra'},
    {'icon':'assets/Icons/placeicon.png','State':'Vasai(W)','icon1':'assets/Icons/cityicon.png','City':'Mumbai','icon2':'assets/Icons/state_icon.png','Place':'Maharashtra'},
    {'icon':'assets/Icons/placeicon.png','State':'Vasai(W)','icon1':'assets/Icons/cityicon.png','City':'Mumbai','icon2':'assets/Icons/state_icon.png','Place':'Maharashtra'},
  ];
  List <DoctorListData> doctorListData = [] ;
  Future<void> doctorData () async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('user_id');
    print('My place id here u can see${signupController.placeID}');
    isBusy = false;
    update();
    try{
      Map<String, String> body = {};
      body[RequestKeys.catId] = catId.toString();
      body[RequestKeys.areaId] = signupController.placeID.toString();
      body[RequestKeys.userId]= userId.toString() ;
      print('_____Surenda+_jejedgishiugsidhuohhdryuig_____${userId}_________');
      print('_____Surenda+_jejedgishiugsidhuohhdryuig_____${signupController.placeID}_________');
      print('_____Surenda+_jejedgishiugsidhuohhdryuig_____${catId}_________');
      DoctorListResponseModel res  = await api.getDoctor(body) ;
      if(res.status??false){
        doctorListData = res.data??[];
        isBusy = false ;
        update();
      }else {
        isBusy = false;
        update();
        ShowMessage.showSnackBar('Error',"Something went wrong") ;
      }
    }catch(error) {
      ShowMessage.showSnackBar('Error',"${error}") ;
    }
  }
}