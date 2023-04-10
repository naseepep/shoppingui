import 'package:flutter/material.dart';
import 'package:shopping_ui/product_model.dart';
import 'package:shopping_ui/repository/api_repo.dart';

class TestUi extends StatefulWidget {
  const TestUi({super.key});

  @override
  State<TestUi> createState() => _TestUiState();
}

class _TestUiState extends State<TestUi> {
  late Future<List<Products>> futureProduct;
  @override
  void initState() {
    super.initState();

    futureProduct = apiRepo().FetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                apiRepo().AddProduct(
                  'Back Pack',
                  '25',
                  'leather bag at best quality',
                  'bags',
                  'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                  {"rate": 4.8, "count": 120},
                );
              },
              icon: Icon(Icons.add)),
        ],
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "PRODUCT LIST",
          style: TextStyle(
            color: Colors.yellow,
          ),
        ),
      ),
      body: FutureBuilder<List<Products>>(
        future: futureProduct,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 500,
                mainAxisSpacing: 2,
                crossAxisSpacing: 4,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return productCard(product: snapshot.data[index]);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class productCard extends StatelessWidget {
  productCard({
    Key? key,
    required this.product,
  }) : super(key: key);
  Products product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Container(
            //height: 150,
            width: 300,
            child: Image(
              image: NetworkImage(product.image.toString()),
              // width: 100,
              // height: 200
            ),
          ),
          Text(product.id.toString()),
          Text(
            product.title.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Row(
            children: const [
              Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              Text('4.5')
            ],
          ),
          //Text(product.rating.toString()),
          Text(product.category.toString()),
          Row(
            children: [
              Icon(Icons.currency_rupee_outlined, size: 15),
              Text(
                product.price.toString(),
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: (() {
                    apiRepo().updateProduct(
                        product.id.toString(), 'new name', '400');
                  }),
                  child: const Text('Update')),
              // SizedBox(
              //   width: 10,
              // ),
              TextButton(
                  onPressed: () {
                    apiRepo().deleteProduct(product.id.toString());
                  },
                  child: const Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }
}
