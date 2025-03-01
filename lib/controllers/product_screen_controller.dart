import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test2/models/product.dart';

class ProductScreenController extends GetxController {
  RxBool isLoading = false.obs;
  List<Product>? listOfProduct;
  RxList<Product> filteredProducts = <Product>[].obs;


  Future<void> fetchProducts({String? category}) async {
    final String url = "https://dummyjson.com/products?limit=50";
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<dynamic> productsJson = jsonData['products'];

        List<Product> products = productsJson.map((json) => Product.fromJson(json)).toList();

        // If a category is provided, filter the products
        if (category != null) {
          products = products.where((product) => product.category == category).toList();
        }

        listOfProduct = products;
        filteredProducts.assignAll(products);
      } else {
        throw Exception("Failed to load products. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void filterProductsBasedOnSearch(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(listOfProduct!);
    } else {
      filteredProducts.assignAll(
        listOfProduct!
            .where((product) =>
            product.title!.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }
}
