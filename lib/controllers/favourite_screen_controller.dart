import 'package:get/get.dart';
import '../models/product.dart';

class FavouriteScreenController extends GetxController{
  RxBool isLoading = false.obs;
  RxList<Product> listOfFavourites = <Product>[].obs;
  RxList<Product> filteredProducts = <Product>[].obs;


  void toggleFavourite(Product product) {
    if (listOfFavourites.contains(product)) {
      listOfFavourites.remove(product); // Remove if already in favorites
    } else {
      listOfFavourites.add(product); // Add if not in favorites
    }
    filterProductsBasedOnSearch('');

  }

  bool isFavourite(Product product) {
    return listOfFavourites.any((p) => p.id == product.id);
  }

  void filterProductsBasedOnSearch(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(listOfFavourites);
    } else {
      filteredProducts.assignAll(
        listOfFavourites
            .where((product) =>
            product.title!.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }
}