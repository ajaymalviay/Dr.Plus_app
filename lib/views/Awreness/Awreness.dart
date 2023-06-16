import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart'as http;

import '../../Services/api_methods.dart';
import '../../Utils/colors.dart';
import '../../models/Get_awreness_model.dart';

class AwrenessScreen extends StatefulWidget {
  const AwrenessScreen({Key? key}) : super(key: key);

  @override
  State<AwrenessScreen> createState() => _AwrenessScreenState();
}

class _AwrenessScreenState extends State<AwrenessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAwarenessListApi();
  }
  GetAwrenessModel? getAwrenessModel;
  getAwarenessListApi() async {
    var headers = {
      'Cookie': 'ci_session=cdbd346aeb637d4f574b95b7476f4f6c0be73896'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_booking/user/app/v1/api/doctor_awareness'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
    var result = await response.stream.bytesToString();
    var finalResult =  GetAwrenessModel.fromJson(jsonDecode(result));
    print('___Divya_______${finalResult}_________');
    setState(() {
      getAwrenessModel =  finalResult;
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
        centerTitle: true,
        title: Text('Awareness '),
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
      body: Column(
        children: [
          SizedBox(height: 20,),
      getAwrenessModel == null || getAwrenessModel == " "? const Center(child: CircularProgressIndicator()): getAwrenessModel!.data!.length == 0 ? Center(child: Text("No data to show"),) :
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
             itemCount: getAwrenessModel!.data!.length,
              itemBuilder:
                  (BuildContext context ,int index){
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal:10,vertical:5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Title: "),
                                SizedBox(height: 5,),
                                Text("Aware Input: "),
                                SizedBox(height: 5,),
                                Text("Aware Language: "),
                                SizedBox(height: 5,),
                                Text("Date: "),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${getAwrenessModel!.data![index].title}",style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600),),
                                SizedBox(height: 5,),
                                Text("${getAwrenessModel!.data![index].awareInput}",style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600),),
                                SizedBox(height: 5,),
                                Text("${getAwrenessModel!.data![index].awareLanguage}",style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600),),
                                SizedBox(height: 5,),
                                Text("${getAwrenessModel!.data![index].date}",style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600),),
                              ],
                            )
                          ],
                        )

                      ]

                    ),
                  ),
                );
              }),
        ],),
    );
  }
}
