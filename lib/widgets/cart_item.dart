import 'package:e_commerce_assignment/models/cart.dart';
import 'package:e_commerce_assignment/models/phone.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  Phone phone;
  CartItem({super.key, required this.phone});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  void removeFromCart() {
    Provider.of<Cart>(context, listen: false).removeItemFromCart(widget.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) =>  Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: Image.network(widget.phone.image),
          title: Text(widget.phone.name),
          subtitle: Text(widget.phone.price.toString()),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => removeFromCart(),
          ),
        ),
      ),
    );
  }
}
