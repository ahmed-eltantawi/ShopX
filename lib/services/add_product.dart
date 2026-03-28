import 'package:new_shopx/models/product_model.dart';
import 'package:new_shopx/services/api_class.dart';

class AddProduct {
  Future<ProductModel> addProduct({
    required String url,
    required ProductModel product,
  }) async {
    Map<String, dynamic> data = await Api.post(
      url: url,
      body: {
        "title": product.title,
        "price": product.price,
        "description": product.description,
        'image': product.image,
        "category": product.category,
      },
    );
    return ProductModel.fromJson(data);
  }
}
