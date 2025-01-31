import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_image.dart';
import 'add_vical.dart';
import 'all_vichal.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/services/cache_storage_services.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/responsive_text.dart';
import '../../auth/view/login_view.dart';
import '../controller/setting_controller.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final settingController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomSizedBox(value: .02),
              const Align(
                alignment: Alignment.center,
                child: CustomColumnDivider(
                  title: 'الإعدادات',
                  imagePath: 'assets/Settings (1).png',
                ),
              ),
              customSettingWidget(context, 'assets/Car (1).png', 'المركبات'),
              const CustomSizedBox(value: .01),
              InkWell(
                onTap: () => navigateTo(context, const AddVehicleView()),
                child: const SizedBox(
                  height: 50,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Divider(color: Colors.grey),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 40,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                      right: 0,
                                      top: 0,
                                      child: CustomAssetsImage(
                                          path: 'assets/Add.png')),
                                  Positioned(
                                    left: 0,
                                    child: CustomAssetsImage(
                                      path: 'assets/Car.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 5),
                            ResponsiveText(
                              text: 'اضافه مركبه',
                              scaleFactor: .06,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const CustomSizedBox(value: .01),
              customExitWidget(),
            ],
          ),
        ));
  }

  customExitWidget() {
    return InkWell(
      onTap: () async {
        CacheStorageServices().clear();
        navigateOff(context, LoginView());
      },
      child: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: SizedBox(
          height: 50,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Divider(color: Colors.grey),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5),
                    ResponsiveText(
                      text: 'تسجيل الخروج',
                      scaleFactor: .06,
                      color: AppColors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customSettingWidget(
      BuildContext context, String imagePath, String title) {
    return InkWell(
      onTap: () => navigateTo(context, const AllVicale()),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SizedBox(
          height: 50,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const Divider(color: Colors.grey),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAssetsImage(path: imagePath),
                    const SizedBox(width: 5),
                    ResponsiveText(
                      text: title,
                      scaleFactor: .06,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
