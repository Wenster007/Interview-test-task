import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class CategoriesScreenController extends GetxController {
  RxBool isLoading = false.obs;
  List<Category>? listOfCategories;
  RxList<Category> filteredCategories = <Category>[].obs;

  Future<void> fetchCategories() async {
    const String url = "https://dummyjson.com/products/categories";
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = jsonDecode(response.body);

        // Use Category.fromJson for each category
        List<Category> categories = categoriesJson.map((categoryName) => Category.fromJson(categoryName)).toList();

        listOfCategories = categories;
        filteredCategories.assignAll(listOfCategories!);
      } else {
        throw Exception(
          "Failed to load categories. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void filterProductsBasedOnSearch(String query) {
    if (query.isEmpty) {
      filteredCategories.assignAll(listOfCategories!);
    } else {
      filteredCategories.assignAll(
        listOfCategories!
            .where(
              (category) =>
                  category.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(),
      );
    }
  }
}
