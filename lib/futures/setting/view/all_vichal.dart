import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/functions/global_function.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../../../core/widgets/custom_loading_widget.dart';
import '../controller/setting_controller.dart';
import '../model/category_model.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_column_divider.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/custom_sized_box.dart';
import '../../../core/widgets/error_compant.dart';
import '../../../core/widgets/responsive_text.dart';
import '../widget/custom_input_dailog.dart';

class AllVicale extends StatefulWidget {
  const AllVicale({super.key});

  @override
  State<AllVicale> createState() => _AllVicaleState();
}

class _AllVicaleState extends State<AllVicale> {
  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: RefreshIndicator(
        onRefresh: () => categoryController.getAllCategories(),
        color: AppColors.primaryColor,
        child: Column(
          children: [
            const CustomSizedBox(value: .02),
            const CustomColumnDivider(
              title: 'المركبات',
              imagePath: 'assets/Car.png',
            ),
            Expanded(
              child: Obx(
                () => categoryController.isLoading.value == true
                    ? const CustomLoadingWidget()
                    : categoryController.categoryList.isEmpty
                        ? ErrorComponent(
                            function: categoryController.getAllCategories,
                            message: categoryController.categoryError.value)
                        : ListView.builder(
                            itemCount: categoryController.categoryList.length,
                            itemBuilder: (context, index) {
                              return customVicelWidget(context,
                                  categoryController.categoryList[index]);
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container customVicelWidget(BuildContext context, CategoryModel? model) {
    return Container(
      width: screenSize(context).width,
      height: screenSize(context).height * .3,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffD9D9D9),
      ),
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CustomNetworkImage(
                    imagePath: model?.image,
                    boxFit: BoxFit.fill,
                    height: 80,
                    width: screenSize(context).width * .8,
                  ),
                ),
              ),
              const Divider(color: AppColors.black),
              FittedBox(
                child: ResponsiveText(
                  text: ' الاسم : ${model?.name ?? ''}',
                  scaleFactor: .04,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 5),
              FittedBox(
                child: ResponsiveText(
                  text: 'العمؤله : ${model?.commission.toString() ?? ''}',
                  scaleFactor: .04,
                  color: AppColors.black,
                ),
              ),
              FittedBox(
                child: ResponsiveText(
                  text: 'توصيل : ${model?.delivery==true ?'1':'0'}',
                  scaleFactor: .04,
                  color: AppColors.black,
                ),
              ),
              FittedBox(
                child: ResponsiveText(
                  text: 'رحالات : ${model?.riding==true ?'1':'0'}',
                  scaleFactor: .04,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(categoryModel: model);
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: const FittedBox(
                        child: ResponsiveText(
                          text: 'تعديل ',
                          scaleFactor: .04,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  InkWell(
                    onTap: () => categoryController.deleteCategory(model?.sId),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.red,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: const FittedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ResponsiveText(
                              text: 'حذف ',
                              scaleFactor: .04,
                              color: AppColors.white,
                            ),
                            SizedBox(width: 2),
                            Icon(
                              Icons.delete,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
