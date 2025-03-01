import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test2/constants/app_colors.dart';
import 'package:test2/constants/font_sizes.dart';
import 'package:test2/constants/size_config.dart';
import 'package:test2/controllers/product_screen_controller.dart';
import 'package:test2/screens/product_detail_screen.dart';
import 'package:test2/widgets/app_text.dart';
import 'package:flutter_svg/svg.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, this.categoryName});

  final String? categoryName;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductScreenController productScreenController = Get.put(ProductScreenController());
  final TextEditingController searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  @override
  void initState() {
    productScreenController.fetchProducts(category: widget.categoryName);
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
      body: Obx(
            () {
          if (productScreenController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          // Filter products based on search query
          var filteredProducts = productScreenController.listOfProduct!
              .where((product) =>
              product.title!.toLowerCase().contains(searchQuery.value.toLowerCase()))
              .toList();

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleHeight(21)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.scaleHeight(36)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.categoryName != null ?GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: SizeConfig.scaleHeight(24),
                      ),
                    ) : SizedBox(),
                    AppText(
                      text: capitalizeFirstLetter(widget.categoryName) ?? 'Products',
                      fontSize: FontSizes.pixel24,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontTypes.playFairDisplay,
                      fontColor: AppColors.black2,
                    ),
                    SizedBox(),
                  ],
                ),
                SizedBox(height: SizeConfig.scaleHeight(10)),

                // Search Bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleHeight(13)),
                  height: SizeConfig.scaleHeight(33),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConfig.scaleHeight(5)),
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

                // Product List
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      var product = filteredProducts[index];

                      return GestureDetector(
                        onTap: () {
                          Get.to(ProductDetailScreen(product: product));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleHeight(15)),
                          margin: EdgeInsets.only(bottom: SizeConfig.scaleHeight(10)),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.black2.withOpacity(0.05)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.red.withOpacity(0.1),
                                height: SizeConfig.scaleHeight(160),
                                width: double.infinity,
                                child: Image.network(
                                  product.thumbnail!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: SizeConfig.scaleHeight(5)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: SizeConfig.scaleHeight(200),
                                    child: AppText(
                                      text: product.title!,
                                      fontSize: FontSizes.pixel14,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                      alignment: TextAlign.start,
                                    ),
                                  ),
                                  AppText(
                                    text: '\$ ${product.price ?? ""}',
                                    fontSize: FontSizes.pixel16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppText(
                                    text: "${product.rating!}",
                                    fontSize: FontSizes.pixel10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(width: 5),
                                  for (int i = 0; i < product.rating!.round(); i++)
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: AppColors.golden,
                                          size: SizeConfig.scaleHeight(12),
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                ],
                              ),
                              SizedBox(height: SizeConfig.scaleHeight(8)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: 'By ${product.brand ?? ""}',
                                    fontColor: AppColors.black2.withOpacity(0.5),
                                    fontSize: FontSizes.pixel10,
                                  ),
                                ],
                              ),
                              SizedBox(height: SizeConfig.scaleHeight(8)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: 'In ${product.category ?? ""}',
                                    fontColor: AppColors.black2,
                                    fontSize: FontSizes.pixel10,
                                  ),
                                ],
                              ),
                              SizedBox(height: SizeConfig.scaleHeight(8)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String? capitalizeFirstLetter(String? input) {
    if (input == null || input.isEmpty) {
      return null;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

}
