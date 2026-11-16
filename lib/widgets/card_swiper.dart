import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/product_response.dart';

class CardSwiper extends StatelessWidget {
  final List<Product> products;
  final String title;
  const CardSwiper({Key? key, required this.products, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        width: double.infinity,
        // Aquest multiplicador estableix el tant per cent de pantalla ocupada 50%
        height: size.height * 0.5,
        // color: Colors.red,
        child: Swiper(
          itemCount: products.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: (BuildContext context, int index) {
            final product = products[index];

            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: product),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(product.images.isNotEmpty ? product.images.first.src : 'https://placehold.co/300x400/png'),
                    fit: BoxFit.contain),
              ),
            );
          },
        ));
  }
}
