import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_loading_widget.dart';
import '../model/vehicle_model.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/error_compant.dart';
import '../../../core/widgets/responsive_text.dart';
import '../controller/clients_controller.dart';

class BestVicale extends StatefulWidget {
  const BestVicale({super.key});

  @override
  State<BestVicale> createState() => _BestVicaleState();
}

class _BestVicaleState extends State<BestVicale> {
  final clientController = Get.find<ClientController>();
  @override
  void initState() {
    super.initState();
    clientController.getTopVehiclesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: RefreshIndicator(
        onRefresh: () {
          return clientController.getTopVehiclesData();
        },
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const CustomSizedBox(value: .02),
              const CustomColumnDivider(
                title: 'المركبات',
                imagePath: 'assets/Car.png',
              ),
              const CustomSizedBox(value: .02),
              Expanded(
                child: Obx(() {
                  return clientController.vehicleIsLoading.value == true
                      ? const CustomLoadingWidget()
                      : clientController.vehicleList.isEmpty
                          ? ErrorComponent(
                              function: clientController.getTopVehiclesData,
                              message: clientController.vehiclesDataError.value)
                          : ListView.builder(
                              itemBuilder: (context, index) => bestClientWidget(
                                  context,
                                  index,
                                  clientController.vehicleList[index]),
                              itemCount: clientController.vehicleList.length,
                            );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column bestClientWidget(
      BuildContext context, int index, VehicleModel? model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black.withOpacity(.5),
              radius: 16,
              child: const Icon(
                Icons.star,
                color: AppColors.primaryColor,
                size: 25,
              ),
            ),
            const SizedBox(width: 5),
            ResponsiveText(
              text: 'رقم ${index + 1}',
              scaleFactor: .06,
              color: AppColors.black,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
            height: screenSize(context).height * .2,
            padding: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffD9D9D9),
            ),
            child: LayoutBuilder(
              builder: (p0, p1) => Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          FittedBox(
                            child: ResponsiveText(
                              text: model?.model ?? '',
                              scaleFactor: .04,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(
                            width: screenSize(context).width * .4,
                            child: const Divider(
                              thickness: 2,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const ResponsiveText(
                            text: 'رقم المالك',
                            scaleFactor: .04,
                            color: AppColors.black,
                          ),
                          const FittedBox(
                            child: ResponsiveText(
                              text: ' 01000000',
                              scaleFactor: .04,
                              color: AppColors.black,
                            ),
                          ),
                          // SizedBox(
                          //   width: screenSize(context).width * .2,
                          //   child: const Divider(
                          //     thickness: 2,
                          //     color: AppColors.primaryColor,
                          //   ),
                          // ),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 8, horizontal: 15),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10),
                          //     color: AppColors.red,
                          //   ),
                          //   child: const Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       ResponsiveText(
                          //         text: 'حذف',
                          //         scaleFactor: .04,
                          //         color: AppColors.white,
                          //       ),
                          //       Icon(
                          //         Icons.delete,
                          //         color: AppColors.white,
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: CustomNetworkImage(
                      imagePath: checkImage(model?.images),
                      width: p1.maxWidth * .4,
                      height: p1.maxHeight,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 5),
      ],
    );
  }

  String checkImage(List<String>? images) {
     
    if (images == null) {
      return '';
    } else if (images.isEmpty) {
      return '';
     
    }
    return images[0];
  }
}
