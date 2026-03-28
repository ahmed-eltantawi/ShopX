import 'package:new_shopx/models/product_model.dart';
import 'package:new_shopx/services/api_class.dart';

class GetAllProducts {
  Future<List<ProductModel>> getAllProducts({required String url}) async {
    List<dynamic> data = await Api.get(uri: url);
    List<ProductModel> productList = [];
    for (int i = 0; i < data.length; i++) {
      productList.add(ProductModel.fromJson(data[i]));
    }
    return productList;
  }
}
