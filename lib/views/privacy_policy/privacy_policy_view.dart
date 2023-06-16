import 'package:dr_plus/controllers/privacy_policy_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/colors.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PrivacyPolicyController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 50.0,right: 50),
            child: Text('Privacy Policy'),
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
              child: Container(child: const Center(child: Text('Creating a Privacy Policy for your '
                  'application or website can take a lot of time. You could either spend tons of money'
                  ' on hiring a lawyer, or you could simply use our service and get a unique Privacy Policy'
                  ' fully customized for your website.'))),
            ),
          ],
        ),
      );
    },);
  }
}
