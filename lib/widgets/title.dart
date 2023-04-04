import 'package:flutter/material.dart';
import 'package:g10mart/data/models/product_model.dart';

class TitleWidget extends StatelessWidget {
  final Product product;
  const TitleWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(

              product.title.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
            ),
          ),
          Text(
            (product.rating ?? 0).toDouble().toStringAsFixed(1).toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
        ],
      ),
    );
  }
}
