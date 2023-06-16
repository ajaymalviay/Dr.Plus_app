import 'package:carousel_slider/carousel_slider.dart';
import 'package:dr_plus/controllers/doctorlist_view_controller.dart';
import 'package:dr_plus/views/booking/booking_appointment.dart';
import 'package:dr_plus/views/login/LoginScreen.dart';
import 'package:dr_plus/widgets/commen_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/colors.dart';

class DoctorListScreen extends StatefulWidget {
  // String? doctorId;
  const DoctorListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {

  String? userId;

  getUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      userId =  prefs.getString("user_id");
    });
    print("this is user ID $userId");
  }
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: DoctorListController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(left: 70.0, right: 50),
              child: Text('Doctor List'),
            ),
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
          body: SingleChildScrollView(
            child:controller.homeController.sliderList == null || controller.homeController.sliderList == " "? Center(child:
              CircularProgressIndicator(),) :controller.homeController.sliderList.length == 0 ? Center(child: Text("No data founf!!"),):Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  controller.isBusy
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.secondary,
                          ),
                        )
                      : Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  onPageChanged: (index, result) {
                                    controller.currentPost = index;
                                    controller.update();
                                  },
                                  viewportFraction: 1.0,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 500),
                                  enlargeCenterPage: false,
                                  scrollDirection: Axis.horizontal,
                                  height: 180.0),
                              items: controller.homeController.sliderList
                                  .map((val) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return CommonSlider(
                                        file: "${val.image}" ?? '',
                                        link: "${val.link}" ?? '');
                                    //   InkWell(
                                    //   onTap: () {
                                    //    // U can call function for redirect on google.
                                    //   },
                                    //   child: Container(
                                    //       height: heightSize/4.6,
                                    //       width: widthSize/1,
                                    //       child:Image.network("${val.image}",fit: BoxFit.fill,)),
                                    // );
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Positioned(
                              bottom: 20,
                              child: Row(
                                children: controller.buildDots(),
                              ),
                            ),
                          ],
                        ),
                           const SizedBox(
                    height: 10,
                  ),
                           controller.doctorListData == null || controller.doctorListData == " " ? const Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()):controller.doctorListData.length == 0 ? const Center(child: Padding(padding: EdgeInsets.all(8.0), child: Text("No data to show"),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.doctorListData.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      controller.onTapDoctorDetails(index);
                                    },
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          ListTile(
                                              leading: Container(
                                                  height: 70,
                                                  width: 70,
                                                  child: controller.doctorListData[index].image == null ||
                                                          controller
                                                                  .doctorListData[
                                                                      index]
                                                                  .image ==
                                                              ""
                                                      ? Image.asset(
                                                          'assets/images/doctor4')
                                                      : ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius.all(
                                                                  Radius.circular(
                                                                      10)),
                                                          child: Image.network(controller
                                                                  .doctorListData[index]
                                                                  .image ??
                                                              ''))),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller
                                                            .doctorListData[
                                                                index]
                                                            .title ??
                                                        '',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            AppColors.primary),
                                                  ),
                                                  Text(
                                                    controller
                                                            .doctorListData[
                                                                index]
                                                            .username ??
                                                        '',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            AppColors.primary),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          controller
                                                                  .doctorListData[
                                                                      index]
                                                                  .docDigree ??
                                                              '',
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColors
                                                                  .secondary)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          controller
                                                                  .doctorListData[
                                                                      index]
                                                                  .companyDivision ??
                                                              '',
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          controller
                                                                  .doctorListData[
                                                                      index]
                                                                  .experience ??
                                                              "",
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            'assets/Icons/placeicon.png',
                                                            height: 15,
                                                            width: 10,
                                                          ),
                                                          const SizedBox(
                                                            width: 1,
                                                          ),
                                                          Container(
                                                              width:40,
                                                              child: Text(controller.doctorListData[index].placeName ?? "",
                                                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),maxLines:1, overflow: TextOverflow.ellipsis,
                                                              )),
                                                          Image.asset(
                                                            'assets/Icons/cityicon.png',
                                                            height: 10,
                                                            width: 10,
                                                          ),
                                                          const SizedBox(
                                                            width: 1,
                                                          ),
                                                          Container(
                                                              width: 43,
                                                              child: Text(
                                                                  controller
                                                                          .doctorListData[
                                                                              index]
                                                                          .cityName ??
                                                                      '',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis))),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Image.asset(
                                                            'assets/Icons/state_icon.png',
                                                            height: 10,
                                                            width: 10,
                                                          ),
                                                          const SizedBox(
                                                            width: 1,
                                                          ),
                                                          Container(
                                                              width: 45,
                                                              child: Text(
                                                                  controller
                                                                          .doctorListData[
                                                                              index]
                                                                          .stateName ??
                                                                      '',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500))),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10,),
                                                      // controller.doctorListData[index].isSubcrction == true ? InkWell(
                                                      //   onTap: (){
                                                      //     print("this is ne wuser ID $userId");
                                                      //     if(userId == null || userId == ''){
                                                      //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                                      //    }else{
                                                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingAppointment(doctorListData:controller.doctorListData[index],)));
                                                      //
                                                      //
                                                      //     }
                                                      //   },
                                                      //   child: Container(
                                                      //     height: 35,
                                                      //     width: 150,
                                                      //     decoration: BoxDecoration(color: AppColors.secondary,
                                                      //       borderRadius: BorderRadius.circular(10)
                                                      //     ),
                                                      //
                                                      //     child: Center(child:  Text("Booking",style: TextStyle(color:AppColors.whit),)),
                                                      //   ),
                                                      // ):SizedBox.shrink(),
                                                      SizedBox(height: 10,)
                                                    ],
                                                  ),
                                                  IconButton(
                                                      onPressed: () {

                                                        if (controller.doctorListData[index].isFavorite ==true)
                                                        {
                                                          setState(() {
                                                              controller.getRemoveWishListApi(index);
                                                          });
                                                          controller.doctorData();
                                                        } else {
                                                          setState(() {controller.addWishlistApi(index);// controller.doctorListData[index].isFavorite = ! (controller.doctorListData[index].isFavorite ?? false );
                                                          });
                                                          controller.doctorData();
                                                        }
                                                      },
                                                      icon: controller
                                                                  .doctorListData[
                                                                      index]
                                                                  .isFavorite ==
                                                              true
                                                          ? const Icon(
                                                              Icons.favorite,
                                                              color:
                                                                  AppColors.red,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .favorite_outline,
                                                              color:
                                                                  AppColors.red,
                                                            )),
                                                  
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ) ,


                ]),
          ),
        );
      },
    );
  }



}
