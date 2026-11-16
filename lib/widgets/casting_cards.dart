import 'package:flutter/material.dart';
import 'package:movies_app/models/product_response.dart';

class CastingCards extends StatelessWidget {
  final List<Product> products;
  const CastingCards({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 200,
      // color: Colors.red,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => _CastCard(product: products[index])),
    );
  }
}

class _CastCard extends StatelessWidget {
  final Product product;
  const _CastCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      // color: Colors.green,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
              arguments: product),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(product.images.isNotEmpty ? product.images.first.src : 'https://placehold.co/150x300/png'),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
