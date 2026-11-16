import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movies_app/models/product_response.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> allProduct = [];
  List<Product> byType(ProductType type) => allProduct.where((p) => p.productType == type).toList();
  List<Product> similarTo(Product product) => byType(product.productType)
      .where((p) => p.id != product.id)
      .toList();

  bool isLoading = true;
  String? error;

  ProductProvider() {
    getAllProducts();
  }

  getAllProducts() async {
    var url = Uri.https('www.surfstationstore.com',
      '/collections/skate/products.json', {'limit': '250'});

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await http.get(url);
      if (result.statusCode != 200) {
        error = 'Error del servidor (${result.statusCode})';
      }
      else {
        allProduct = SkateShop.fromRawJson(result.body).products;
      }
    }
    catch (e) {
      error = 'No s\'ha pogut connectar. Revisa la connexió.';
    }
    isLoading = false;
    notifyListeners();
  }
}
