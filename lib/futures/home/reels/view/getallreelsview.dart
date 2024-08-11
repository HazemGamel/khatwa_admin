import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selivery_controlle_panal/futures/home/reels/controller/allreelscontroller.dart';
import 'package:selivery_controlle_panal/futures/home/reels/modelsreel/reelmodel.dart';

import '../../../../core/functions/global_function.dart';
import '../../../../core/rescourcs/app_colors.dart';
import '../../../../core/widgets/custom_appBar.dart';
import '../../../../core/widgets/custom_column_divider.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../core/widgets/custom_sized_box.dart';
import '../../../../core/widgets/error_compant.dart';
import '../../../../core/widgets/responsive_text.dart';
import '../../../ads/widget/web_view_widget.dart';


class GetAllReelsView extends StatefulWidget {
  const GetAllReelsView({super.key});

  @override
  State<GetAllReelsView> createState() => _AllAdsViewState();
}

class _AllAdsViewState extends State<GetAllReelsView> {
  final controller = Get.find<AllReelsController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAllReelsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.getAllReelsData();
        },
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomSizedBox(value: .01),
              const CustomColumnDivider(title: 'الريلز'),
              const CustomSizedBox(value: .02),
              Expanded(
                child: Obx(
                      () => controller.isLoading.value == true
                      ? const CustomLoadingWidget()
                      : controller.allReelsList.isEmpty
                      ? ErrorComponent(
                      function: controller.getAllReelsData,
                      message: controller.allAdsDataError.value)
                      : ListView.builder(
                    itemBuilder: (context, index) => customAdsWidget(
                        context, index, controller.allReelsList[index]),
                    itemCount: controller.allReelsList.length,
                  ),
                ),
              ),
              const CustomSizedBox(value: .02),
            ],
          ),
        ),
      ),
    );
  }

  Column customAdsWidget(BuildContext context,
      int index, ReelsModel model) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
              color: AppColors.primaryColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ResponsiveText(
              text: '# الريلز ${index + 1} ',
              scaleFactor: .04,
              color: AppColors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // YouTubePlayerWidget(videoId: model.link!),
        Align(alignment: Alignment.centerRight,
            child: Text('')),
        const SizedBox(height: 8),
        // YouTubePlayerWidget(videoId: model.link!),
        Align(
            alignment: Alignment.centerRight,
            child: Text('')),
        const SizedBox(height: 8),
        SizedBox(
          width: screenSize(context).width,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Text("${model.url}"),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).
                  push(MaterialPageRoute(builder: (_) {
                    return WebPage(link: model.url ?? '');
                  }));
                },
                child: Card(
                  elevation: 10,
                  semanticContainer: true,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: 80,
                      child: Image.asset(
                        'assets/Screenshot 2023-11-05 224007.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const CustomSizedBox(value: .02),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor,
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: FittedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CustomAssetsImage(
                          width: 20,
                          path: 'assets/Natural User Interface 5.png'),
                      ResponsiveText(
                        text: 'عدد النقرات  ',
                        scaleFactor: .03,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 3),
            Container(
              height: 50,
              width: 1,
              color: Colors.black,
            ),
            const SizedBox(width: 3),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.deleteAds(model.sId);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.red,
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: const FittedBox(
                    child: Row(
                      children: [
                        ResponsiveText(
                          text: 'حذف الإعلان ',
                          scaleFactor: .03,
                          color: AppColors.white,
                        ),
                        Icon(
                          Icons.delete,
                          color: AppColors.white,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),


      ],
    );
  }
}
