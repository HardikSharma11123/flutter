import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartitem = cart[index];

          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(cartitem['imageUrl'] as String),
            ),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Delete Product",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: const Text(
                          "Are You Sure You Want To Remove This Product"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "No",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .removeproduct(cartitem);
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
            title: Text(
              cartitem['title'].toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text("Size ${cartitem['size']}"),
          );
        },
      ),
    );
  }
}
