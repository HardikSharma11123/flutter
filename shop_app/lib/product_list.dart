import 'package:flutter/material.dart';
import 'package:shop_app/global_varib.dart';
import 'package:shop_app/product_cart.dart';
import 'package:shop_app/product_details.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ["All", "Adidas", "Nike", "Bata"];
  late String selectedFilters;
  @override
  void initState() {
    super.initState();
    selectedFilters = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Shoes\nCollection",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilters = filter;
                        });
                      },
                      child: Chip(
                        backgroundColor: selectedFilters == filter
                            ? Theme.of(context).colorScheme.primary
                            : const Color.fromARGB(255, 243, 246, 249),
                        side: const BorderSide(
                          color: Color.fromRGBO(211, 219, 227, 1),
                        ),
                        labelStyle: const TextStyle(fontSize: 16),
                        label: Text(
                          filter,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductDetails(product: product);
                            },
                          ),
                        );
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        bckgroundcolor: index.isEven
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromARGB(255, 244, 250, 255),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
