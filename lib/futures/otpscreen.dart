import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:selivery_controlle_panal/core/rescourcs/app_colors.dart';
import 'package:selivery_controlle_panal/futures/auth/controller/otpcontroller.dart';

import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_loading_widget.dart';

class OtpScreen extends StatelessWidget {
  final String phone ;

   OtpScreen({super.key, required this.phone});

  late String otpcode;

  @override
  Widget build(BuildContext context) {
    final otpController = Get.put(OtpController());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.asset("assets/logo2.jpeg"),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text("Verify phone",
                          style:TextStyle(
                            fontSize: 17
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                          "$phone",
                          style:TextStyle(
                              fontSize: 17
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: PinCodeTextField(
                        length: 6,
                        appContext: context,
                        textStyle:TextStyle(
                          fontSize: 18
                        ),
                        keyboardType: TextInputType.phone,
                        pinTheme: PinTheme(
                          fieldHeight: 50,
                          fieldWidth: 50,
                          activeColor: Colors.green,
                          selectedColor: Colors.grey,
                          inactiveColor:  Colors.grey,
                          activeFillColor:  Colors.grey,
                          inactiveFillColor:  Colors.grey,
                          selectedFillColor:  Colors.grey,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enableActiveFill: true,
                        cursorColor:  Colors.grey,
                        controller:otpController.otpController ,
                        onCompleted: (submittedCode) async {
                          otpcode=submittedCode;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),

                  ],
                ),
              ),
              Obx(
                    () => otpController.isLoading.value
                    ? const CustomLoadingWidget(
                  color: Colors.white,
                )
                    :
                CustomButton(
                    function: () {
                      FocusScope.of(context).unfocus();
                      otpController.VerifyOtp(context,
                          phone.toString());
                    },
                    title: 'دخول',
                    fontSize: 25,
                    color: Colors.black),
              ),
            ],
          )),
    );
  }
}
