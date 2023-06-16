import 'package:dr_plus/controllers/terms&condition_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/colors.dart';
class TermsCondition extends StatefulWidget {
  const TermsCondition({Key? key}) : super(key: key);

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TermsConditionController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 50.0,right: 50),
            child: Text('Terms & Condition'),
          ),
          flexibleSpace: Container(
            decoration:BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[AppColors.secondary.withOpacity(0.1),AppColors.secondary])),
          ),
          leading:InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios)),
          actions: const [
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10,top: 30),
              child: Container(child: const Center(child: Text('Terms and Conditions” is the document'
                  ' governing the contractual relationship between the provider of a service'
                  ' and its user'))),
            ),
          ],
        ),
      );
    },);
  }
}
