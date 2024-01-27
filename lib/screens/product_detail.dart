import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedIndex = 0;

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
        title: Text("Product Detail",
            style: TextStyle(
                color: Color(0xffEFFAEE),
                fontSize: 20,
                fontFamily: "Nunito Sans"),
            textAlign: TextAlign.start),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: widget.product['product_image'],
                  placeholder: (context, url) =>
                      Image.asset("assets/image/placeholder.jpg"),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.product['product_name'],
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  fontFamily: "Nunito Sans"),
            ),
            SizedBox(height: 8.0),
            buildProductVariantsList(widget.product['product_variant']),
            SizedBox(height: 5.0),
            Text(
              '${getSelectedPrice()}',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  fontFamily: "Nunito Sans"),
            ),
            SizedBox(height: 15.0),
            Text(
              'Description:',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  fontFamily: "Nunito Sans"),
            ),
            SizedBox(height: 8.0),
            Text(
              '${widget.product['product_desc']}',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Nunito Sans"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductVariantsList(List<dynamic> productVariants) {
    return Container(
      color: Colors.transparent,
      height: 70.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productVariants.length,
        itemBuilder: (context, index) {
          final variant = productVariants[index];
          return GestureDetector(
            onTap: () => _onSelected(index),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 90,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectedIndex == index
                        ? Color(0xff444444)
                        : Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    '${variant['pv_qty']} ${variant['pv_unit']}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Nunito Sans",
                        color: selectedIndex == index
                            ? Color(0xffEFFAEE)
                            : Color(0xff444444)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  String getSelectedPrice() {
    if (selectedIndex >= 0 &&
        selectedIndex < widget.product['product_variant'].length) {
      final variant = widget.product['product_variant'][selectedIndex];
      return 'Discount price- \₹${variant['pv_dis_price']}\nOriginal price- \₹${variant['pv_ori_price']}';
    } else {
      return '';
    }
  }
}
