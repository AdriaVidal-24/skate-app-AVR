import 'package:flutter/material.dart';
import 'package:movies_app/models/product_response.dart';
import 'package:movies_app/providers/product_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productes'),
        elevation: 0,
        actions: [
          IconButton(onPressed: ()  {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: productsProvider.error != null
        ? _ErrorView(
            message: productsProvider.error!,
            onRetry: () => productsProvider.getAllProducts(),
          )
        : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(products: productsProvider.byType(ProductType.SKATE_COMPLETES), title: "Complete decks"),

              // Slider de productes
              ProductSlider(products: productsProvider.byType(ProductType.SKATE_DECKS), title: "Decks",),
              ProductSlider(products: productsProvider.byType(ProductType.SKATE_PARTS_GRIP_TAPE), title: "Grip tape"),
              ProductSlider(products: productsProvider.byType(ProductType.SKATE_PARTS_WHEELS), title: "Wheels"),
              ProductSlider(products: productsProvider.byType(ProductType.SKATE_PARTS_TRUCKS), title: "Trucks"),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 60, color: Colors.grey),
            const SizedBox(height: 15),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 15),
            ElevatedButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      ),
    );
  }
}
