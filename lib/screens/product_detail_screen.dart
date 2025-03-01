import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:test2/constants/app_colors.dart';
import 'package:test2/constants/font_sizes.dart';
import 'package:test2/constants/size_config.dart';
import 'package:test2/models/product.dart';
import 'package:test2/widgets/app_text.dart';
import 'package:test2/controllers/favourite_screen_controller.dart'; // Import the controller

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key, required this.product});

  final Product product;
  final FavouriteScreenController favouriteController =
      Get.find<FavouriteScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.scaleHeight(36)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.scaleHeight(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: SizeConfig.scaleHeight(24),
                    ),
                  ),
                  AppText(
                    text: 'Product Details',
                    fontSize: FontSizes.pixel24,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontTypes.playFairDisplay,
                    fontColor: AppColors.black2,
                  ),
                  SizedBox(),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.scaleHeight(10)),
            Container(
              height: SizeConfig.scaleHeight(200),
              width: double.infinity,
              color: Colors.red.withOpacity(0.1),
              child: Image.network(product.thumbnail!, fit: BoxFit.contain),
            ),
            SizedBox(height: SizeConfig.scaleHeight(20)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.scaleHeight(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Details Header with Favorite Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: 'Product Details:',
                        fontSize: FontSizes.pixel18,
                        fontWeight: FontWeight.w600,
                      ),

                      // Favourite Icon with GetX Observer
                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            favouriteController.toggleFavourite(product);
                          },
                          child: SvgPicture.asset(
                            favouriteController.isFavourite(product)
                                ? 'assets/icons/favourite_red.svg' // Favorite icon
                                : 'assets/icons/favourite_light.svg',
                            // Not Favorite
                            height: SizeConfig.scaleHeight(24),
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(10)),

                  // Product Details
                  Row(
                    children: [
                      AppText(
                        text: 'Name:',
                        fontSize: FontSizes.pixel12,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: 5),
                      AppText(
                        text: product.title!,
                        fontSize: FontSizes.pixel10,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(10)),

                  Row(
                    children: [
                      AppText(
                        text: 'Price:',
                        fontSize: FontSizes.pixel12,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: 5),
                      AppText(
                        text: "\$ ${product.price!}",
                        fontSize: FontSizes.pixel10,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(10)),

                  Row(
                    children: [
                      AppText(
                        text: 'Category:',
                        fontSize: FontSizes.pixel12,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: 5),
                      AppText(
                        text: product.category!,
                        fontSize: FontSizes.pixel10,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(10)),

                  // Rating Section
                  Row(
                    children: [
                      AppText(
                        text: 'Rating:',
                        fontSize: FontSizes.pixel12,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: 5),
                      AppText(
                        text: "${product.rating!}",
                        fontSize: FontSizes.pixel10,
                      ),
                      SizedBox(width: 5),
                      for (int i = 0; i < product.rating!.round(); i++)
                        Icon(
                          Icons.star,
                          color: AppColors.golden,
                          size: SizeConfig.scaleHeight(11),
                        ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(10)),

                  Row(
                    children: [
                      AppText(
                        text: 'Stock:',
                        fontSize: FontSizes.pixel12,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: 5),
                      AppText(
                        text: "${product.stock!}",
                        fontSize: FontSizes.pixel10,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(10)),

                  // Description Section
                  AppText(
                    text: 'Description:',
                    fontSize: FontSizes.pixel12,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(2)),
                  AppText(
                    text: product.description!,
                    fontSize: FontSizes.pixel10,
                    alignment: TextAlign.start,
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(10)),

                  // Product Gallery Section
                  AppText(
                    text: 'Product Gallery:',
                    fontSize: FontSizes.pixel12,
                    fontWeight: FontWeight.w600,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio:
                          SizeConfig.scaleHeight(154) /
                          SizeConfig.scaleHeight(109),
                    ),
                    itemCount: product.images!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.red.withOpacity(0.1),
                        child: Image.network(
                          product.images![index],
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
