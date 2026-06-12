import 'package:brt_assignment/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onWishlist;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onWishlist,
    required this.onTap

  });

  @override
  Widget  build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              color: Colors.black12,
            )
          ],
        ),
        child: Column(
          children: [
            Expanded(child: CachedNetworkImage(imageUrl: product.thumbnail,
            fit: BoxFit.cover
              ,)
            ),
            Padding(
                padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                  ),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  IconButton(
                      onPressed: onWishlist,
                      icon: Icon(
                        isFavorite?Icons.favorite:Icons.favorite_border,
                        color: isFavorite?Colors.red:Colors.grey,
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}
