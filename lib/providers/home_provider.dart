import 'package:flutter/material.dart';
import 'package:g10mart/data/repository/api.dart';
import 'package:g10mart/data/models/product_model.dart';

class HomeProvider extends ChangeNotifier {
  List<Product> productList = [];
  Api api = Api();

  fetchProductsDetails() async {
    try {
      productList = await api.getAllProducts();
    } catch (exception) {
      print(exception);
    }
    notifyListeners();
  }
}
