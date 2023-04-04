import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g10mart/data/models/product_model.dart';
import 'package:g10mart/widgets/colors.dart';

class DetailProductScreen extends StatefulWidget {
  final Product product;
  DetailProductScreen({super.key, required this.product});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: primaryColor.withOpacity(0.9),
          title: Text(widget.product.category.toString()),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    color: Colors.black12,
                    width: double.infinity,
                    child: Image.network(
                      widget.product.images![currentIndex],
                      fit: BoxFit.contain,
                    )),
                _detailTile(),
                const Center(
                  heightFactor: 5,
                  child: Text(
                    "Happiness is not in money, but in shopping.... ",
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _detailTile() {
    return Card(
      margin: EdgeInsets.only(top: 10, right: 5, left: 5),
      color: primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _images(),
            _productName(),
            Text(
              widget.product.brand.toString(),
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Special price",
              style: TextStyle(color: Colors.lightGreenAccent, fontSize: 18),
            ),
            _price(),
            Text(
              "Hurry, Only ${widget.product.stock} left!",
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Discription",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              widget.product.description.toString(),
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(
              height: 10,
            ),
            _bookNowBotton(),
          ],
        ),
      ),
    );
  }

  Widget _images() {
    return Container(
      width: double.infinity,
      height: 80,
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemCount: widget.product.images?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.all(3),
              child: widget.product.images != []
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: NetworkImage(widget.product.images![index]),
                            fit: BoxFit.cover,
                          )),
                    )
                  : const Center(
                      child: Text(
                        "No Images",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _productName() {
    return Row(children: [
      Expanded(
        child: Text(
          widget.product.title.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          softWrap: true,
        ),
      ),
      Text(
        (widget.product.rating ?? 0).toDouble().toStringAsFixed(1).toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      Icon(
        Icons.star,
        color: Colors.yellow,
        size: 20,
      ),
    ]);
  }

  Widget _price() {
    return Row(
      children: [
        Text(
          "₹ ${widget.product.price ?? 0}",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "${widget.product.discountPercentage} % off",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  _bookNowBotton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        showDialogBox();
      },
      child: Text('Book Now'),
      style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shadowColor: Colors.white24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('Congratulations'),
            content: const Text(
                'Thank You ! For being a great customer, Happy shopping'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ));
}
