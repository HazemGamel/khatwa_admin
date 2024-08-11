

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/contants/api.dart';
import '../../../../core/functions/internet_checker.dart';
import '../../../../core/services/cache_storage_services.dart';
import 'package:http/http.dart' as http;

import '../../../../core/widgets/show_awesomeDialog.dart';

class ReelSController extends GetxController {
  var isLoading = false.obs;
  var adsError = ''.obs;
  TextEditingController linkReelController = TextEditingController();
  postReel() async {
    if (await checkInternet()) {
      try {
        isLoading.value = true;
        var headers = {
          'Accept': 'application/json',
          "Authorization": 'Bearer ${CacheStorageServices().token}',
        };
      var  response = await http.post(
          addReelUri,
          body: {
            "url":linkReelController.text.trim(),
          },
          headers: headers);
        Map responsebody = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          isLoading.value = false;
          showDialogWithGetX(responsebody['message']);
        } else {
          showDialogWithGetX(responsebody['message']);
          isLoading.value = false;
        }
      } catch (error) {
        isLoading.value = false;
        showDialogWithGetX(error.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      showDialogWithGetX("لا يوجد اتصال بالانترنت");
    }
  }




  @override
  void dispose() {
    linkReelController.dispose();
    super.dispose();
  }
}
