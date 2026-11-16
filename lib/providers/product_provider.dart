import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movies_app/models/product_response.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> allProduct = [];

  ProductProvider() {
    print("Product Provider inicialitzat!");
    getAllProducts();
  }

  getAllProducts() async {
    var url = Uri.https('www.surfstationstore.com',
      '/collections/skate/products.json', {'limit': '50'});

    final result = await http.get(url);

    final allProductResponse = SkateShop.fromRawJson(result.body);
    allProduct = allProductResponse.products;

    notifyListeners();
  }
}
