import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_ui/product_model.dart';

class apiRepo {
  Uri url = Uri.parse('https://fakestoreapi.com/products/');
  Uri url1 = Uri.parse('https://fakestoreapi.com/products/');

  Future<List<Products>> FetchProduct() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body).cast<Map<String, dynamic>>();
      print(data[0]);
      return data.map<Products>((json) => Products.fromJson(json)).toList();
      print(response.body);
    } else
      print('no data');
    throw Exception('Failed to load products');
  }

  Future<void> AddProduct(
    String title,
    String price,
    String des,
    String catg,
    String img,
    Map rating,
  ) async {
    final response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'price': price,
          'description': des,
          'category': catg,
          'image': img,
          'rating': rating,
        }));
    if (response.statusCode == 200) {
      print(response.body);
      print('product added successfully');
    } else
      print('product not added');
  }

  Future<void> updateProduct(
    String id,
    String title,
    String price,
  ) async {
    final response = await http.patch(
      Uri.parse('https://fakestoreapi.com/products/$id'),
      headers: <String, String>{
        'content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'title': title,
          'id': id,
          'price': price,
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.body);
      print('product updated successfully');
    } else
      print('product not updated');
  }

  Future<void> deleteProduct(
    String id,
  ) async {
    final response = await http.delete(
      Uri.parse('https://fakestoreapi.com/products/7'),
      headers: <String, String>{
        'content-type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      print('product deleted successfully');
    } else
      print('product not deleted');
  }
}
