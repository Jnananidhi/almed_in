import 'package:flutter/material.dart';

class Product {
  final int id, price;
  final String title, image;

  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
  });
}

// Our trending Products

List<Product> trendingProducts = [
  Product(
    id: 1,
    image: 'assets/products/capsule.webp',
    title: '''Evion 400mg Capsule 10'S''',
    price: 64,
  ),
  Product(
    id: 2,
    image: "assets/products/inhaler.webp",
    title: "LEVOLIN CFC",
    price: 150,
  ),
  Product(
    id: 3,
    image: "assets/products/injection.webp",
    title: "Renerve Plus Injection 2ml",
    price: 45,
  ),
  Product(
    id: 4,
    image: "assets/products/syrup.webp",
    title: "Alex Syrup 100 ml Sugar Free",
    price: 100,
  ),
];
