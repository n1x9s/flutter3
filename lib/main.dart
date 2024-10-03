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

  Product(this.name, this.price, this.imageUrl);
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<Product> products = [
    Product('Кот просто прикольный', 29.99, 'images/kot1.jpg'),
    Product('Кот в шапке', 19.99, 'images/kot2.jpg'),
    Product('Кот с хлебом', 39.99, 'images/kot3.jpg'),
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
          );
        },
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
        title: const Text('Лучшие котики'),
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