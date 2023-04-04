import 'package:flutter/material.dart';
import 'package:g10mart/data/models/product_model.dart';
import 'package:g10mart/widgets/carousel_slider.dart';
import 'package:g10mart/widgets/title.dart';

import '../widgets/colors.dart';
import 'detail_screen.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10, right: 5, left: 5),
      color: primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(
            product: widget.product,
          ),
          ProductSlider(
            product: widget.product,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.product.description.toString(),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ),
          _bookBotton()
        ],
      ),
    );
  }

  _bookBotton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailProductScreen(
                  product: widget.product,
                ),
              ));
        },
        child: Text('Book Now'),
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shadowColor: Colors.white24,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )),
      ),
    );
  }
}
