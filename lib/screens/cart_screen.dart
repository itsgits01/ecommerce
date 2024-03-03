import 'package:e_commerce_assignment/models/cart.dart';
import 'package:e_commerce_assignment/models/phone.dart';
import 'package:e_commerce_assignment/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_assignment/models/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: value.getUserCart().length,
                itemBuilder: (context, index) {
                  Phone indiPhone = value.getUserCart()[index];

                  return CartItem(phone: indiPhone);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
