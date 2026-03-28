import 'package:new_shopx/models/product_model.dart';
import 'package:new_shopx/services/api_class.dart';

class GetCategoryProducts {
  Future<List<ProductModel>> getCategoryProducts({
    required String categoryName,
  }) async {
    List<dynamic> data = await Api.get(
      uri:
          "https://sandbox.mockerito.com/ecommerce/api/products/category/$categoryName",
    );
    List<ProductModel> productsList = [];
    for (int i = 0; i < data.length; i++) {
      productsList.add(ProductModel.fromJson(data[i]));
    }
    return productsList;
  }
}
