

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/functions/global_function.dart';
import '../../../../core/rescourcs/app_colors.dart';
import '../../../../core/widgets/custom_appBar.dart';
import '../../../../core/widgets/custom_column_divider.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../core/widgets/custom_sized_box.dart';
import '../../../../core/widgets/responsive_text.dart';
import '../controller/reelscontroller.dart';

class AddReelsView extends StatefulWidget {
  const AddReelsView({super.key});

  @override
  State<AddReelsView> createState() => _AddAdsViewState();
}

class _AddAdsViewState extends State<AddReelsView> {
  final formKey = GlobalKey<FormState>();

  final controller = Get.find<ReelSController>();
  @override
  void dispose() {
    controller.isLoading.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const CustomSizedBox(value: .02),
                  const CustomColumnDivider(title: 'إضافة ريلز جديد'),
                  const CustomSizedBox(value: .02),
                  customForm(context,"reel",5,controller.linkReelController),
                  const CustomSizedBox(value: .05),
                  Obx(
                        () => controller.isLoading.value
                        ? const CustomLoadingWidget()
                        : InkWell(
                      onTap: () {
                        //formKey.currentState!.validate()
                        // if (controller.youtubeLinkController.text.isNotEmpty||
                        //     controller.adsImage != null) {
                        controller.postReel();
                        //}
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.primaryColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: const ResponsiveText(
                          text: 'إضافة ',
                          scaleFactor: .04,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Row customForm(BuildContext context, String title, int maxLine,
      TextEditingController controller) {
    return Row(
      children: [
        FittedBox(
          child: ResponsiveText(
            text: title,
            scaleFactor: .05,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: screenSize(context).width * .6,
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null) {
                return 'Not Valid Empty Value';
              } else if (value.isEmpty) {
                return 'Not Valid Empty Value';
              }
              return null;
            },
            maxLines: maxLine,
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              fillColor: AppColors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}