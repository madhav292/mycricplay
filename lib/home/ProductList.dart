import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final List<String> products = [
    'Product 1',
    'Product 2',
    'Product 3',
    'Product 4',
    'Product 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index]),
            subtitle: Text('Price: \$10'),
            leading: CircleAvatar(
              child: Text('\$'),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to the product details page
            },
          );
        },
      ),
    );
  }
}
