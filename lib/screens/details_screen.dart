import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/product_response.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product producte =
      ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(producte),
                _Overview(producte),
                CastingCards(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBar però amb bon comportament davant scroll
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(5),
              color: Colors.black,
              child: Text(
                'Skate Shop',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://img.magnific.com/free-photo/silhouette-person-jumping-sunset_52683-112029.jpg?semt=ais_hybrid&w=740&q=80'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Product product;
  const _PosterAndTitle(this.product);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              onTap: () => showImageViewer(
                context,
                NetworkImage(product.images.first.src),
                swipeDismissible: true,
                doubleTapZoomable: true,
              ),
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'),
                image: NetworkImage(product.images.isNotEmpty ? product.images.first.src : 'https://placehold.co/300x400/png'),
                height: 150,
                width: 120,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  product.title,
                  style: textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Row(
                  children: [
                    const Icon(Icons.attach_money, size: 15, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text('Preu: ${product.variants.first.price} \$', style: textTheme.bodySmall),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Product product;
  const _Overview(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        product.overview(),
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
