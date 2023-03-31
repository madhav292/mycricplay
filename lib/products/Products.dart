import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  late final String name;
  late final double price;
  late final double qty;
  late final String description;
  late final String size;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.qty,
      required this.size});
}

class ProductController {
  final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> getProducts() async {
    final snapshot = await _productCollection.get();
    final products = snapshot.docs
        .map((doc) => Product(
            id: doc.id,
            name: doc['name'],
            price: double.parse(doc['price'].toString()),
            description: '',
            qty: 0,
            size: ''))
        .toList();
    return products;
  }

  Future<void> addProduct(String name, double price) async {
    await _productCollection.add({
      'name': name,
      'price': price,
    });
  }

  Future<void> updateProduct(String id, String name, double price) async {
    await _productCollection.doc(id).update({
      'name': name,
      'price': price,
    });
  }

  Future<void> deleteProduct(String id) async {
    await _productCollection.doc(id).delete();
  }
}

class ProductListView extends StatelessWidget {
  final ProductController controller = ProductController();

  ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Column(
        children: [
          FutureBuilder<List<Product>>(
            future: controller.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final products = snapshot.data!;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('Price: \$${product.price.toString()}'),
                      leading: const CircleAvatar(
                        child: Text('\$'),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProductView(product: product),
                          ),
                        );
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductView(controller: controller),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddProductView extends StatefulWidget {
  final ProductController controller;

  AddProductView({required this.controller});

  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await widget.controller.addProduct(_name, _price);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailsView extends StatelessWidget {
  final Product product;

  ProductDetailsView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(product.name),
          SizedBox(height: 10),
          Text('Price: \$${product.price.toStringAsFixed(2)}'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProductView(product: product),
                    ),
                  );
                },
                child: Text('Edit'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement delete operation here
                },
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EditProductView extends StatefulWidget {
  final Product product;

  EditProductView({required this.product});

  @override
  _EditProductViewState createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.product.name);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Product Price',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.product.name = _nameController.text;
                widget.product.price = double.parse(_priceController.text);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
