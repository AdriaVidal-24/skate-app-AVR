import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/product_response.dart';
import 'package:movies_app/providers/product_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product producte =
      ModalRoute.of(context)!.settings.arguments as Product;
    final List<Product> productes =
      Provider.of<ProductProvider>(context).similarTo(producte);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(producte),
                _Overview(producte),
                ProductesSimilars(products: productes),
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
    // "Skate - Parts - Wheels" -> "Wheels"
    final category = productTypeValues.reverse[product.productType]!.split(' - ').last;
    final disponible = product.variants.any((v) => v.available);

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
                NetworkImage(product.images.isNotEmpty ? product.images.first.src : 'https://placehold.co/300x400/png'),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                const SizedBox(height: 5),
                _InfoRow(Icons.sell_outlined, 'Marca: ${product.vendor}'),
                _InfoRow(Icons.category_outlined, 'Categoria: $category'),
                _InfoRow(Icons.attach_money, 'Preu: ${product.variants.first.price} \$'),
                _InfoRow(
                  disponible ? Icons.check_circle_outline : Icons.cancel_outlined,
                  disponible ? 'Disponible' : 'Esgotat',
                  color: disponible ? Colors.green : Colors.red,
                ),
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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const _InfoRow(this.icon, this.text, {this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
