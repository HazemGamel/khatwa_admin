import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/functions/global_function.dart';
import '../../../core/widgets/snack_bar_widget.dart';
import '../../../core/contants/api.dart';
import '../../../core/functions/internet_checker.dart';
import '../../../core/widgets/show_awesomeDialog.dart';
import '../../otpscreen.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final phone = TextEditingController();
  final password = TextEditingController();
  final phoneFocus = FocusNode();
  final passwordFocus = FocusNode();
  Future<void> login(context) async {
    isLoading.value = true;
    if (await checkInternet()) {
      try {
        final response = await http.post(
          loginUri,
          body: {
            "phone": phone.text.trim(),
          },
        );
        final result = jsonDecode(response.body);
        if (response.statusCode == 200) {
          //await CacheStorageServices().setToken(result['token']);
          isLoading.value = false;
          phone.clear();
          // password.clear();
          showSnackBarWidget(
              context: context,
              message: 'تم التسجيل بنجاح',
              requestStates: RequestStates.success);
          navigateOff(context, OtpScreen(phone: phone.text,));

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
    phone.dispose();
    password.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
}
