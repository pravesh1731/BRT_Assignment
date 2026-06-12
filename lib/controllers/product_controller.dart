import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';
import '../services/api_service.dart';
import '../utils/wishlist_service.dart';

class ProductController extends GetxController {
  final ApiService api = ApiService();

  final ScrollController scrollController =
  ScrollController();

  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;

  var wishlist = <int>[].obs;

  var isLoading = false.obs;
  var hasMore = true.obs;

  var searchText = ''.obs;

  var selectedCategory = ''.obs;
  int page = 0;

  @override
  void onInit() {
    super.onInit();

    loadProducts();
    loadWishlist();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent -
              300) {
        if (!isLoading.value &&
            hasMore.value) {
          loadProducts();
        }
      }
    });
  }

  List<String> get categories {
    return products
        .map((e) => e.category)
        .toSet()
        .toList();
  }

  Future<void> loadWishlist() async {
    wishlist.value =
    await WishlistService.getWishlist();
  }

  Future<void> loadProducts() async {
    if (!hasMore.value) return;

    try {
      isLoading.value = true;

      final result =
      await api.getProduct(
        limit: 10,
        skip: page * 10,
      );

      if (result.isEmpty) {
        hasMore.value = false;
      } else {
        products.addAll(result);

        page++;

        applyFilters();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilters() {
    filteredProducts.value =
        products.where((product) {

          final matchesSearch = product.title
              .toLowerCase()
              .contains(
            searchText.value.toLowerCase(),
          );

          final matchesCategory =
              selectedCategory.value.isEmpty ||
                  product.category ==
                      selectedCategory.value;

          return matchesSearch &&
              matchesCategory;

        }).toList();
  }

  Future<void> toggleWishlist(
      int productId) async {
    if (wishlist.contains(productId)) {
      wishlist.remove(productId);
    } else {
      wishlist.add(productId);
    }

    await WishlistService.saveWishlist(
      wishlist.toList(),
    );
  }

  Future<void> refreshProducts() async {
    page = 0;

    hasMore.value = true;

    products.clear();

    filteredProducts.clear();

    await loadProducts();
  }
}