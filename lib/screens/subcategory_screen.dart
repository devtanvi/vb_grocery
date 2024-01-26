import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'detail.dart';

class SubcategoryScreen extends StatefulWidget {
  final String categoryId;

  SubcategoryScreen({required this.categoryId});

  @override
  _SubcategoryScreenState createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  List<Map<String, dynamic>> subcategories = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://www.codeocean.co.in/2023/mandi_at_door/api.php?get_product_pagination_testing&category_id=${widget.categoryId}'));

    if (response.statusCode == 200) {
      print("categoryId:${widget.categoryId}");
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['success'] == '1') {
        setState(() {
          subcategories = List.from(data['JSON_DATA']);
        });
      } else {
        // Handle API error
        print('API Error: ${data['error_message']}');
      }
    } else {
      // Handle HTTP error
      print('HTTP Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subcategory Screen'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          return buildGridItem(subcategories[index]);
        },
      ),
    );
  }

  Widget buildGridItem(Map<String, dynamic> subcategory) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: subcategory),
          ),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              subcategory['product_image'],
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8.0),
            Text(
              subcategory['product_name'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
