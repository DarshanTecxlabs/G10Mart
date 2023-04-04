import 'package:dio/dio.dart';
import 'package:g10mart/data/models/product_model.dart';

class Api {
  final dio = Dio();
  final url = "https://dummyjson.com/products";

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await dio.get(url);
      var result = ProductModel.fromJson(response.data);
      return result.products ?? [];
    } catch (exception) {
      throw (exception);
    }
  }
}
