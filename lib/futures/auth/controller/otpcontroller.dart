
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/contants/api.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/functions/internet_checker.dart';
import 'package:http/http.dart' as http;

import '../../../core/services/cache_storage_services.dart';
import '../../../core/widgets/show_awesomeDialog.dart';
import '../../../core/widgets/snack_bar_widget.dart';
import '../../home/view/main_view.dart';
import '../../otpscreen.dart';

class OtpController extends GetxController{
  var isLoading = false.obs;
  final otpController = TextEditingController();
  final phoneFocus = FocusNode();
  Future<void> VerifyOtp(context,String phone) async {
    isLoading.value = true;
    if (await checkInternet()) {
      try {
        final response = await http.post(
          OtpUri,
          body: {
            "phone": phone.toString(),
            "otp": otpController.text,
            "deviceToken": "erty65437-uhui",
          },
        );
        final result = jsonDecode(response.body);
        print(response);
        if (response.statusCode == 200) {
          await CacheStorageServices().setToken(result['token']);
          isLoading.value = false;
          //phone.clear();
          // password.clear();
          showSnackBarWidget(
              context: context,
              message: 'تم التسجيل بنجاح',
              requestStates: RequestStates.success);
          navigateOff(context,MainView());

        } else {
          showDialogWithGetX(result['message']);
          isLoading.value = false;
        }
      } catch (e) {
        print(e.toString());
        isLoading.value = false;
        showDialogWithGetX(e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      showDialogWithGetX("لا يوجد اتصال بالانترنت");
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }
}