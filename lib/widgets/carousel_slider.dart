import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:g10mart/data/models/product_model.dart';
import 'package:g10mart/widgets/colors.dart';

class ProductSlider extends StatefulWidget {
  final Product product;
  const ProductSlider({super.key, required this.product});

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  int currentImageIndex = 0;
  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          items: widget.product.images?.map((items) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    color: primaryColor.withOpacity(0.45),
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Image.network(
                      items,
                      fit: BoxFit.contain,
                    ));
              },
            );
          }).toList(),
          options: CarouselOptions(
              scrollPhysics: BouncingScrollPhysics(),
              autoPlay: true,
              height: 300,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  currentImageIndex = index;
                });
              }),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CarouselIndicator(
                count: widget.product.images?.length,
                index: currentImageIndex,
                cornerRadius: 100,
                width: 10,
                height: 10,
                activeColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
