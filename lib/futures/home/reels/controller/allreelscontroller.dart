

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../core/contants/api.dart';
import '../../../../core/functions/internet_checker.dart';
import '../../../../core/services/cache_storage_services.dart';
import '../../../../core/widgets/show_awesomeDialog.dart';
import '../modelsreel/reelmodel.dart';

class AllReelsController extends GetxController {
  var isLoading = false.obs;
  var allAdsDataError = ''.obs;
  RxList allReelsList = <ReelsModel>[].obs;

  Future<void> getAllReelsData() async {

    if (await checkInternet()) {
      try {
        isLoading.value = true;
        allReelsList.value = <ReelsModel>[].obs;
        final response = await http.get(
          getAllReelUri,
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);

        if (response.statusCode == 200) {
          var r = result['reels'] as List;
          r.map((e) {
            allReelsList.add(ReelsModel.fromJson(e));
          }).toList();
          allReelsList.isEmpty
              ? allAdsDataError.value = 'لا يوجد بيانات'
              : allAdsDataError.value = '';
          isLoading.value = false;
        } else {
          isLoading.value = false;
          allAdsDataError.value = result['message'];
        }
      } catch (e) {
        isLoading.value = false;
        allAdsDataError.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    } else {
      allAdsDataError.value = 'لا يوجد اتصال بالانترنت';
    }
  }

  void deleteAds(String? id) async {

    if (await checkInternet()) {
      try {
        final response = await http.delete(deleteReelUri(id!),
            headers: authHeadersWithToken(CacheStorageServices().token));
        final result = jsonDecode(response.body);
        if (response.statusCode == 200) {
          showDialogWithGetX(result['message']);
          getAllReelsData();
        } else {
          showDialogWithGetX(result['message']);
        }
      } catch (error) {
        showDialogWithGetX(error.toString());
      }
    } else {
      showDialogWithGetX("لا يوجد اتصال بالانترنت");
    }
    update();
  }
}
