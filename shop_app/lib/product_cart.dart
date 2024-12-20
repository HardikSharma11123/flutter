import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Color bckgroundcolor;
  final String image;
  final String title;
  final double price;
  const ProductCard(
      {super.key,
      required this.title,
      required this.price,
      required this.image,
      required this.bckgroundcolor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      color: bckgroundcolor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "\$ $price",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Image.asset(
                image,
                height: 175,
              ),
            )
          ],
        ),
      ),
    );
  }
}
