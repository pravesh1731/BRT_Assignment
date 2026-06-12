import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ProductController controller =
  Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xffF6F8FB),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Product Store",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(
            () => RefreshIndicator(
          onRefresh:
          controller.refreshProducts,

          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 12,
                      color: Colors.black12,
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Search products",
                        prefixIcon:
                        const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(16),
                        ),
                      ),
                      onChanged: (value) {
                        controller.searchText.value =
                            value;

                        controller.applyFilters();
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: controller
                          .selectedCategory.value
                          .isEmpty
                          ? null
                          : controller
                          .selectedCategory.value,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(16),
                        ),
                      ),

                      hint: const Text(
                        "Select Category",
                      ),

                      items: [
                        const DropdownMenuItem(
                          value: '',
                          child: Text("All Categories"),
                        ),

                        ...controller.categories.map(
                              (category) =>
                              DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ),
                        )
                      ]
                          .toList(),

                      onChanged: (value) {
                        controller.selectedCategory.value =
                            value ?? '';

                        controller.applyFilters();
                      },
                    ),
                  ],
                ),
              ),

              Expanded(
                child: GridView.builder(
                  controller: controller
                      .scrollController,

                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),

                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio:
                    0.68,
                  ),

                  itemCount: controller
                      .filteredProducts
                      .length +
                      1,

                  itemBuilder:
                      (context, index) {

                    if (index ==
                        controller
                            .filteredProducts
                            .length) {
                      return Obx(
                            () => controller
                            .hasMore
                            .value
                            ? const Center(
                          child:
                          CircularProgressIndicator(),
                        )
                            : const SizedBox(),
                      );
                    }

                    final product =
                    controller
                        .filteredProducts[
                    index];

                    return ProductCard(
                      product: product,

                      isFavorite:
                      controller
                          .wishlist
                          .contains(
                        product.id,
                      ),

                      onWishlist: () {
                        controller
                            .toggleWishlist(
                          product.id,
                        );
                      },

                      onTap: () {
                        Get.to(
                              () =>
                              ProductDetailScreen(
                                product:
                                product,
                              ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
