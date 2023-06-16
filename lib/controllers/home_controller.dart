
import 'dart:io';
import 'package:dr_plus/Utils/colors.dart';
import 'package:dr_plus/controllers/signup_controller.dart';
import 'package:dr_plus/models/get_banner_model.dart';
import 'package:dr_plus/models/get_categories_data.dart';
import 'package:dr_plus/models/get_cities_model.dart';
import 'package:dr_plus/route_management/routes.dart';
import 'package:dr_plus/services/request_keys.dart';
import 'package:dr_plus/views/login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';
import 'package:http/http.dart'as http;

class HomeController extends AppBaseController {
  
  
  final signupController = Get.put(SignupController());
  List<GetCitiesData>getCitiesData=[];



  List<Map<String,dynamic>> item2 = [
    {'icon':'assets/Icons/allergisticon.png','profession':'Allergist'},
    {'icon':'assets/Icons/anaesthesiologisticon.png','profession':'Anaesthesiologist'},
    {'icon':'assets/Icons/cardiologist.png','profession':'Cardiologist'},
    {'icon':'assets/Icons/dermatologist.png','profession':'Dermatologist'},
    {'icon':'assets/Icons/dentist.png','profession':'Dentist'},
    {'icon':'assets/Icons/endocrinologist.png','profession':'Endocrinologist'},
    {'icon':'assets/Icons/ENTspecialist.png','profession':'ENT Specialist'},
    {'icon':'assets/Icons/epidemiologist.png','profession':'Epidemiologist'},
    {'icon':'assets/Icons/generalphysician.png','profession':'General Physician'},
    {'icon':'assets/Icons/Gastroenterologist.png','profession':'Gastroenterologist'},
    {'icon':'assets/Icons/gynecologistobstetrician.png','profession':'Gynecologist/ Obstetrician'},
    {'icon':'assets/Icons/Hyperbaricphysician.png','profession':'Hyperbaric Physician'},

  ];

 int currentIndex = 0;

 TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> key = GlobalKey();
  @override
  String? catId;
  void onInit() {
    // TODO: implement onInit
    getCurrentLocation();
    catId = Get.arguments ;
    getSliderData ();
    HomeCategoryData();
    super.onInit();
  }
  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  // new GlobalKey<RefreshIndicatorState>();
  //  List<Null> refresh1() {
  //   return Apifunction();
  // }

  // String?
  // getWishListApi() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   userId = preferences.getString('user_id');
  //   var headers = {
  //     'Cookie': 'ci_session=84ac381b0bea62c88d297e89f972727ab7eba30e'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_booking/user/app/v1/api/get_wishlist'));
  //   request.fields.addAll({
  //     'user_id': '401'
  //   });
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  //
  // }


  void Apifunction(){
    HomeCategoryData();
    Future.delayed(const Duration(milliseconds: 500), () {
      getSliderData();
    });

    
  }
  void onTapDoctorList(int index){
   String id = categoryList[index].id.toString() ;
    Get.toNamed(doctorListScreen, arguments: id);
   String sliderId = categoryList[index].id.toString() ;
   Get.toNamed(doctorListScreen, arguments: sliderId);
  }

  void onTapLoginScreen(){
    Get.toNamed(loginScreen);
  }
  void onTapWishListScreen(){
    Get.toNamed(wishScreen);
  }
  void onTapBookingScreen(){
    Get.toNamed(bookingScreen);
  }

  void onTapAwarenessScreen(){
    Get.toNamed(awarenessScreen);
  }


  void onTapSearchScreen(){
    Get.toNamed(doctorSearchScreen);
  }
void onTapSignupScreen(){
    Get.toNamed(singUpScreen);
}
  Position? currentPosition;
  bool choose1=true;
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentPosition = position;
      print('MY CURRENT POSITION____${currentPosition}');
      update();
    } catch (e) {
      print(e);
    }
  }

  searchProduct(String value) {
    if (value.isEmpty) {
      HomeCategoryData();
      update();
    } else {
      final suggestions = categoryList.where((element) {
        final productTitle = element.name!.toLowerCase();
        print('___element.name_______${element.name}_________');
        final input = value.toLowerCase();
        return productTitle.contains(input);
      }).toList();
      categoryList = suggestions;
      update();
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex=0;
  getDrawer(){
   // print("checking user pic ${userPic}");
    return Drawer(
      backgroundColor:AppColors.whit,
      child: ListView(
        children: <Widget>[
            Container(
              height: 125,
              width: 200,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[AppColors.primary,AppColors.secondary]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Container(
                    height: 90,
                    width: 90,
                    child:Image.asset('assets/images/dr_plus_logo.png',),
                  ),

                ],
              ),
            ),
          const SizedBox(height: 10,),//
          // DrawerHeader
          Column(
            children: [
              Container(
                height: 55,
                width:320,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: selectedIndex == 0 ?[AppColors.primary,AppColors.whit]:[AppColors.whit,AppColors.whit]),
               // color: selectedIndex == 0 ? Colors.blue : AppColors.whit,
              ),
                child: ListTile(
                  leading:Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color:selectedIndex == 0 ? AppColors.whit:AppColors.transparent,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Image.asset('assets/Icons/Awareness-Input.png')),
                  title: const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text('Awareness Inputs'),
                  ),
                  onTap: () {
                    Get.toNamed(awarenessScreen);
                    selectedIndex == 0;
                    update();
                  },
                ),
              ),
              SizedBox(height:5,),
              Container(
                height: 50,
                width:320,
                decoration: BoxDecoration(
                  color: selectedIndex == 1 ? Colors.blue : AppColors.whit,
                ),
                child: ListTile(
                  leading:Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color:selectedIndex ==0? AppColors.transparent:AppColors.whit,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child:Image.asset('assets/Icons/Booking.png')),
                  title:  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text('Booking',style: TextStyle(color:selectedIndex ==0?Colors.grey:AppColors.black ),),
                  ),
                  onTap: () {
                    Get.toNamed(bookingScreen);
                    selectedIndex == 1;
                    update();
                  },
                ),
              ),
              SizedBox(height:5,),
              Container(
                height: 50,
                width:320,
                decoration: BoxDecoration(
                  color: selectedIndex == 2 ? Colors.blue : AppColors.whit,
                ),
                child: ListTile(
                  leading:Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color:selectedIndex ==0? AppColors.transparent:AppColors.whit,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child:Image.asset('assets/Icons/Wishlist.png')),

                  title:  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: InkWell(
                      onTap: (){
                        Get.toNamed(wishScreen);
                      },
                        child: Text('WishList',style: TextStyle(color:selectedIndex ==0?Colors.grey:AppColors.black ),)),
                  ),
                  onTap: () {
                    //Get.toNamed(termsConditionScreen);
                    selectedIndex == 2;
                    update();
                  },
                ),
              ),
              SizedBox(height:5,),
              Container(
                height: 50,
                width:320,
                decoration: BoxDecoration(
                  color: selectedIndex == 3 ? Colors.blue : AppColors.whit,
                ),
                child: ListTile(
                  leading:Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color:selectedIndex ==0 ? AppColors.transparent:AppColors.whit,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Image.asset('assets/Icons/login.png')),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: InkWell(
                      onTap: (){
                     Get.toNamed(loginScreen);
                      },
                        child: Text('Login',style: TextStyle(color:selectedIndex ==0?Colors.grey:AppColors.black ),)),
                  ),
                  onTap: () {
                    //Get.toNamed(privacyPolicyScreen);
                    selectedIndex ==3;
                    update();
                  },
                ),
              ),
              // SizedBox(height:5,),
              // Container(
              //   height: 50,
              //   width:320,
              //   decoration: BoxDecoration(
              //     color: selectedIndex == 4 ? Colors.blue : AppColors.whit,
              //   ),
              //   child: ListTile(
              //
              //     leading:Container(
              //         height: 40,
              //         width: 40,
              //         decoration: BoxDecoration(
              //             color:selectedIndex ==0? AppColors.transparent:AppColors.whit,
              //             borderRadius: BorderRadius.circular(50)
              //         ),
              //         child: Image.asset('assets/Icons/rate us.png')),
              //     title:Padding(
              //       padding: const EdgeInsets.only(left: 5.0),
              //       child: Text('Logout',style: TextStyle(color:selectedIndex ==0?Colors.grey:AppColors.black )),
              //     ),
              //     onTap: () {
              //       //Get.toNamed(rateUsScreen);
              //       selectedIndex == 4;
              //       update();
              //     },
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
  //
  File? imageFile;
  String? imagePath;
  final _picker = ImagePicker();


void Dialoguebox(){
  Get.defaultDialog(
      title:'Select Image',
      backgroundColor: Colors.white,
      titleStyle: TextStyle(color:AppColors.black),
      radius: 10,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
           _getFromCamera();
          },
          child:Text('Camera'),
        ),
        const SizedBox(width: 15,),
        ElevatedButton(
          onPressed: (){
           _getFromGallery();
          },
          child:const Text('Gallery'),
        ),
      ],
    )

  );

}
  void BackforAsk(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text("Are you sure you want to exit?."),
          actions: <Widget>[
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(primary: AppColors.primary),
              child: const Text("YES"),
              onPressed: () {
                exit(0);
                // SystemNavigator.pop();
              },
            ),
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(primary: AppColors.primary),
              child: Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      print('image======${imageFile}');
      Get.back();
      update();
    }

  }
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      Get.back();
      update();
    }
  }

  List <getCategoriesData> categoryList = [] ;
  Future<void> HomeCategoryData () async{

    isBusy = true ;
    update();
    try{
      Map<String, String> body = {};
      GetCategoriesResponseModel res  = await api.homeCategories(body);
      if(res.status?? false){
        categoryList = res.data??[];
        isBusy = false;
        update();
      }else {
        isBusy = false ;
        ShowMessage.showSnackBar('Error',"Something went wrong") ;
        update();
      }

    }catch(error) {
      ShowMessage.showSnackBar('Error',"${error}") ;
    }


  }

  int currentPost =  0;
  //  buildDots() {
  //    List<Widget>dots = [];
  //   for (int i = 0; i < (homeController.sliderList.length?? 10) ; i++) {
  //     dots.add(
  //       Container(
  //         margin:EdgeInsets.all(1.5),
  //         width:30,
  //         height: 4,
  //         decoration: BoxDecoration(
  //          // shape: BoxShape.circle,
  //           color: currentPost == i
  //               ? AppColors.black
  //               : Colors.blue,
  //             borderRadius: BorderRadius.circular(40)
  //         ),
  //       ) ,
  //     );
  //   }
  //   return dots;
  // }
  buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < (sliderList.length ?? 10); i++) {
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
     // update();

    }
    return dots;
  }

  List <getBannerData> sliderList = [] ;

  String? bannerId;
  Future<void> getSliderData () async{
    SharedPreferences preferences  = await  SharedPreferences.getInstance();
   bannerId =  preferences.getString("categoryId",);
   print('_____ccsscsasasadsfsadsadsadsadsadsadsadsad_____${bannerId}_________');

    isBusy = true ;
    update();
    try{
      Map<String ,String> body = {};
      body[RequestKeys.catId] = bannerId.toString();
      GetBannerResponseModel res  = await api.SliderApi(body);
      print('_____sliderId_____${bannerId}_________');

      if(res.status ??false){
        sliderList = res.data ?? [] ;
        isBusy = false;
        update();
      }else {
        isBusy = false ;
        update();
        ShowMessage.showSnackBar('Error',"Something Went Wrong ") ;
      }
    }catch(error) {
      ShowMessage.showSnackBar('Error',"${error}") ;
    }

  }


}






