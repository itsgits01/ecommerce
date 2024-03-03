import 'package:e_commerce_assignment/models/cart.dart';
import 'package:e_commerce_assignment/models/phone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ProductDetailPage extends StatefulWidget {
  final Phone phone;

  const ProductDetailPage({Key? key, required this.phone}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  void _shareItem() {
    Share.share('Check out this item: ${widget.phone.name}');
  }

  void addPhoneToCartDetailScreen(Phone phone) {
    Provider.of<Cart>(context, listen: false).addItemToCart(phone);

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Successfully Added to Cart!'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: _shareItem,
            icon: const Icon(Icons.share),
            iconSize: 32,
          ),
        ],
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        buttonPadding: EdgeInsets.zero,
        children: [
          Text(
            '\$${widget.phone.price}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.red[800],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              addPhoneToCartDetailScreen(widget.phone);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(StadiumBorder()),
            ),
            child: Text(
              'Add to Cart',
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            GestureDetector(
              onScaleStart: (ScaleStartDetails details) {
                _previousScale = _scale;
                setState(() {});
              },
              onScaleUpdate: (ScaleUpdateDetails details) {
                _scale = _previousScale * details.scale;
                setState(() {});
              },
              onScaleEnd: (ScaleEndDetails details) {
                _previousScale = 1.0;
                setState(() {});
              },
              child: Transform.scale(
                scale: _scale,
                child: Image.network(
                  widget.phone.image,
                  fit: BoxFit.fitHeight,
                  height: 250,
                  width: double.infinity,
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.phone.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.phone.desc,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      generateDummyText(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String generateDummyText({int paragraphs = 1}) {
  const loremIpsumText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';

  final List<String> paragraphsList =
      List<String>.generate(paragraphs, (_) => loremIpsumText);
  return paragraphsList.join('\n\n');
}
