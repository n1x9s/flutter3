import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Продажа котиков',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductList(),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  Product(this.name, this.price, this.imageUrl, this.description);
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<Product> products = [
    Product('Просто крутой кот', 29.99, 'images/kot1.jpg', 'Самый крутой котик, которого вы когда либо пробовали'),
    Product('Котик с шапкой', 19.99, 'images/kot2.jpg', 'Котик, после которого у вас снесет шапку'),
    Product('Котик в хлебе', 39.99, 'images/kot3.jpg', 'Котик, после которого вас пробьет на поесть'),
  ];

  final Set<Product> favoriteProducts = {};

  void toggleFavorite(Product product) {
    setState(() {
      if (favoriteProducts.contains(product)) {
        favoriteProducts.remove(product);
      } else {
        favoriteProducts.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Продажа котиков'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteProducts(favoriteProducts: favoriteProducts),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final isFavorite = favoriteProducts.contains(product);
          return ListTile(
            leading: Image.asset(product.imageUrl),
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
            trailing: IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () => toggleFavorite(product),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetail(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(product.imageUrl),
            const SizedBox(height: 16.0),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              '\$${product.price}',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 16.0),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteProducts extends StatelessWidget {
  final Set<Product> favoriteProducts;

  const FavoriteProducts({super.key, required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранные котики'),
      ),
      body: ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts.elementAt(index);
          return ListTile(
            leading: Image.asset(product.imageUrl),
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
          );
        },
      ),
    );
  }
}