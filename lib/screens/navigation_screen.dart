import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test2/constants/size_config.dart';
import 'package:test2/controllers/favourite_screen_controller.dart';
import 'package:test2/screens/products_screen.dart';
import '../constants/app_colors.dart';
import '../widgets/app_text.dart';
import 'package:get/get.dart';

import 'categories_screen.dart';
import 'favourites_screen.dart';
import 'mittkonto_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  FavouriteScreenController favouriteScreenController = Get.put(FavouriteScreenController());


  final List<Widget> _screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    MittkontoScreen(),
  ];

  final List<String> _icons = [
    "assets/icons/product.svg",
    "assets/icons/categories.svg",
    "assets/icons/favourite.svg",
    "assets/icons/person.svg",
  ];

  final List<String> _labels = [
    "Product",
    "Categories",
    "Favourites",
    "Mitt Konto",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: SizeConfig.scaleHeight(75),

        decoration: BoxDecoration(color: AppColors.black2),
        child: Row(
          children: List.generate(_icons.length, (index) {
            final bool isSelected = _selectedIndex == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => _onItemTapped(index),
                child: Container(
                  color:
                      isSelected
                          ? Colors.grey.withOpacity(0.1)
                          : AppColors.black2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        _icons[index],
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          isSelected ? Colors.white : AppColors.lightWhite,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(height: 4),
                      AppText(
                        text: _labels[index],
                        fontSize: SizeConfig.scaleHeight(12),
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        fontColor:
                            isSelected ? AppColors.white : AppColors.lightWhite,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
