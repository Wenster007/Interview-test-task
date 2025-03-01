import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test2/constants/size_config.dart';
import 'package:get/get.dart';
import 'package:test2/controllers/categories_screen_controller.dart';
import 'package:test2/screens/products_screen.dart';

import '../constants/app_colors.dart';
import '../constants/font_sizes.dart';
import '../models/category.dart';
import '../widgets/app_text.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesScreenController categoryScreenController = Get.put(
    CategoriesScreenController(),
  );
  final TextEditingController searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  @override
  void initState() {
    categoryScreenController.fetchCategories();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (categoryScreenController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        var filteredProducts =
            categoryScreenController.listOfCategories!
                .where(
                  (category) => category.name.toLowerCase().contains(
                    searchQuery.value.toLowerCase(),
                  ),
                )
                .toList();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleHeight(21)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.scaleHeight(36)),
              AppText(
                text: 'Categories',
                fontSize: FontSizes.pixel24,
                fontWeight: FontWeight.w600,
                fontFamily: FontTypes.playFairDisplay,
                fontColor: AppColors.black2,
              ),
              SizedBox(height: SizeConfig.scaleHeight(10)),

              // Search Bar
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.scaleHeight(13),
                ),
                height: SizeConfig.scaleHeight(33),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    SizeConfig.scaleHeight(5),
                  ),
                  border: Border.all(color: AppColors.black2, width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/search.svg',
                      width: SizeConfig.scaleHeight(16),
                      height: SizeConfig.scaleHeight(13),
                    ),
                    SizedBox(width: SizeConfig.scaleHeight(15)),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isCollapsed: true,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontSize: FontSizes.pixel12,
                            color: AppColors.black2.withOpacity(0.6),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: FontSizes.pixel12,
                          color: AppColors.black2,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (value) {
                          searchQuery.value = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: SizeConfig.scaleHeight(10)),

              // Result Count
              Row(
                children: [
                  SizedBox(width: SizeConfig.scaleHeight(11)),
                  AppText(
                    text: '${filteredProducts.length} results found',
                    fontColor: AppColors.black2.withOpacity(0.25),
                    fontSize: FontSizes.pixel10,
                  ),
                ],
              ),

              SizedBox(height: SizeConfig.scaleHeight(10)),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two columns in the grid
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.2, // Adjust height to width ratio
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final category = filteredProducts[index];
                    return categoryCardBuilder(category: category);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget categoryCardBuilder({required Category category}) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductsScreen(categoryName: category.slug));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5), // Rounded corners
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              "assets/images/beauty.jpeg", // Placeholder image from Unsplash
              fit: BoxFit.cover,
            ),

            // Category Name at the Bottom
            Positioned(
              bottom: 20,
              left: 10,
              child: AppText(
                text: category.name,
                fontWeight: FontWeight.w600,
                fontSize: FontSizes.pixel12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
