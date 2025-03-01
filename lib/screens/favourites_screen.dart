import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:test2/controllers/favourite_screen_controller.dart';

import '../constants/app_colors.dart';
import '../constants/font_sizes.dart';
import '../constants/size_config.dart';
import '../widgets/app_text.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  FavouriteScreenController favouriteScreenController =
      Get.find<FavouriteScreenController>();
  RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    favouriteScreenController.filterProductsBasedOnSearch(searchQuery.value);
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
        var filteredProducts =
            favouriteScreenController.listOfFavourites
                .where(
                  (product) => product.title!.toLowerCase().contains(
                    searchQuery.value.toLowerCase(),
                  ),
                )
                .toList();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleHeight(21)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.scaleHeight(36)),
              AppText(
                text: 'Favourites',
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
                    text:
                        '${favouriteScreenController.filteredProducts.length} results found',
                    fontColor: AppColors.black2.withOpacity(0.25),
                    fontSize: FontSizes.pixel10,
                  ),
                ],
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder:
                      (context, index) => Container(
                        height: SizeConfig.scaleHeight(100),
                        padding: EdgeInsets.all(SizeConfig.scaleHeight(12)),
                        margin: EdgeInsets.only(
                          bottom: SizeConfig.scaleHeight(12),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.black2.withOpacity(0.05),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: SizeConfig.scaleHeight(62),
                                  width: SizeConfig.scaleHeight(62),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(
                                      SizeConfig.scaleHeight(31),
                                    ),
                                  ),
                                  child: Image.network(
                                    filteredProducts[index].thumbnail!,
                                  ),
                                ),
                                SizedBox(width: SizeConfig.scaleHeight(16)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.scaleHeight(150),
                                      child: AppText(
                                        text: filteredProducts[index].title!,
                                        fontWeight: FontWeight.w600,
                                        fontSize: FontSizes.pixel14,
                                        overflow: TextOverflow.ellipsis,
                                        alignment: TextAlign.start,
                                      ),
                                    ),
                                    AppText(
                                      text:
                                          "\$ ${filteredProducts[index].price!}",
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSizes.pixel14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        AppText(
                                          text:
                                              "${filteredProducts[index].rating!}",
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSizes.pixel10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(width: 5),
                                        for (
                                          int i = 0;
                                          i <
                                              filteredProducts[index].rating!
                                                  .round();
                                          i++
                                        )
                                          Icon(
                                            Icons.star,
                                            color: AppColors.golden,
                                            size: SizeConfig.scaleHeight(11),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                favouriteScreenController.toggleFavourite(
                                  filteredProducts[index],
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/icons/favourite_red.svg',
                                height: SizeConfig.scaleHeight(24),
                              ),
                            ),
                          ],
                        ),
                      ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
