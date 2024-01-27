import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:vb_grocery/model/subcategory.dart';
import 'product_detail.dart';

import 'package:cached_network_image/cached_network_image.dart';

// ... other imports

class SubcategoryScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  SubcategoryScreen({required this.categoryId, required this.categoryName});

  @override
  _SubcategoryScreenState createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  late Future<void> fetchDataFuture;
  List<Map<String, dynamic>> subcategories = [];

  @override
  void initState() {
    super.initState();
    fetchDataFuture = fetchData();
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
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Color(0xffEFFAEE),
          ),
        ),
        backgroundColor: Color(0xff5BCC52),
        title: Text(
          widget.categoryName,
          style: TextStyle(
              fontSize: 20,
              fontFamily: "Nunito Sans",
              fontWeight: FontWeight.w700,
              color: Color(0xffEFFAEE)),
          textAlign: TextAlign.start,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: fetchDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: subcategories.length,
                itemBuilder: (context, index) {
                  return buildGridItem(subcategories[index]);
                },
              );
            }
          },
        ),
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
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.transparent,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: subcategory['product_image'],
                  placeholder: (context, url) =>
                      Image.asset("assets/image/placeholder.jpg"),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  // height: 160,
                  // width: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 2.0),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5.0),
              child: Text(
                subcategory['product_name'],
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Nunito Sans",
                    fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
