import 'package:flutter/material.dart';
import 'package:new_shopx/core/extenuations.dart';
import 'package:new_shopx/models/product_model.dart';
import 'package:new_shopx/services/api_class.dart';
import 'package:new_shopx/widgets/show_snack_bar.dart';

class UpdateProductService {
  static String url = "https://sandbox.mockerito.com/ecommerce/api/products/";
  Future<ProductModel> updateProduct({
    required int id,
    required ProductModel product,
    required BuildContext context,
  }) async {
    try {
      Map<String, dynamic> data = await Api.put(
        url: url,
        id: id.toString(),

        body: {
          "title": product.title,
          "price": product.price,
          "description": product.description,
          'image': product.image,
          "category": product.category,
          "rating": {
            "rate": product.rating.rate,
            "count": product.rating.count,
          },
        },
      );
      showSnackBar(
        context: context,
        massage: "\"${product.title.firstNWords(n: 2)}\" Updated Succsfully",
      );
      return ProductModel.fromJson(data);
    } on Exception catch (e) {
      showSnackBar(
        context: context,
        massage: "There is error happened, try again please",
        isError: true,
      );
      throw Exception(e);
    }
  }
}
