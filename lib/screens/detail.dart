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
        title: Text(widget.product['product_name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.product['product_image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              widget.product['product_name'],
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            buildProductVariantsList(widget.product['product_variant']),
            SizedBox(height: 8.0),
            Text(
              '${getSelectedPrice()}',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Description: ${widget.product['product_desc']}',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductVariantsList(List<dynamic> productVariants) {
    return Container(
      color: Colors.transparent,
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productVariants.length,
        itemBuilder: (context, index) {
          final variant = productVariants[index];
          return GestureDetector(
            onTap: () => _onSelected(index),
            child: Column(
              children: [
                Container(
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        selectedIndex == index ? Colors.orange : Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('${variant['pv_qty']} ${variant['pv_unit']}'),
                ),
                SizedBox(height: 8.0),
                // Text(
                //   '${selectedIndex == index ? 'Rs-${variant['pv_dis_price']}-Rs-${variant['pv_ori_price']}' : ''}',
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                // ),
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
      return 'discount price- \₹${variant['pv_dis_price']}\noriginal price- \₹${variant['pv_ori_price']}';
    } else {
      return '';
    }
  }
}
