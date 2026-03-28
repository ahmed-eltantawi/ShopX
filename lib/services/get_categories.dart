import 'package:new_shopx/services/api_class.dart';

class GetCategories {
  Future<List<dynamic>> getCategories() async {
    List<dynamic> data = await Api.get(
      uri: "https://sandbox.mockerito.com/ecommerce/api/products/categories",
    );

    return data;
  }
}
