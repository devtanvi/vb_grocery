import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vb_grocery/screens/subcategory_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> fetchData;
  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    fetchData = fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    final response = await http.get(Uri.parse(
        'https://www.codeocean.co.in/2023/mandi_at_door/api.php?get_category'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('JSON_DATA')) {
        setState(() {
          categories = List.from(data['JSON_DATA']);
        });
      } else {
        print('API Error: ${data['error_message']}');
      }
    } else {
      print('HTTP Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Home',
              style: TextStyle(
                  color: Color(0xffEFFAEE),
                  fontSize: 20,
                  fontFamily: "Nunito Sans"),
            ),
            backgroundColor: Color(0xff5BCC52),
            actions: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.notifications,
                  size: 25,
                  color: Color(0xffEFFAEE),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(Icons.shopping_cart,
                    size: 25, color: Color(0xffEFFAEE)),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder(
              future: fetchData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show loader while waiting for the API call to complete
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Handle error
                  return Center(child: Text('Error loading data'));
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 6.0,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return buildGridItem(categories[index]);
                    },
                  );
                }
              },
            ),
          ),
        ));
  }

  Widget buildGridItem(Map<String, dynamic> category) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubcategoryScreen(
                      categoryId: category['category_id'],
                      categoryName: category['categoty_name']),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CachedNetworkImage(
                height: 90,
                width: 90,
                placeholder: (context, url) =>
                    Image.asset("assets/image/placeholder.jpg"),
                imageUrl: category['category_image'],
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          category['categoty_name'],
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              fontFamily: "Nunito Sans"),
        ),
      ],
    );
  }
}
