import 'package:flutter/material.dart';
import 'package:new_shopx/core/extenuations.dart';
import 'package:new_shopx/models/product_model.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: .none,
      children: [
        Card(
          elevation: 15,
          color: Colors.white,
          child: Padding(
            padding: .symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .end,
              children: [
                Text(
                  product.title.firstNWords(n: 2),
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text("\$ ${product.price}", style: TextStyle(fontSize: 16)),
                    Icon(Icons.favorite, color: Colors.red),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -70,
          right: 30,
          child: Image.network(product.image, height: 120, width: 150),
        ),
      ],
    );
  }
}
