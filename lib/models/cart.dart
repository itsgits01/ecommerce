import 'dart:convert';

import 'package:e_commerce_assignment/models/phone.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends ChangeNotifier {
  //list of phone for sale

  List<Phone> phoneShop = [
    Phone(
        id: 1,
        name: "iPhone 12 Pro",
        desc: "Apple iPhone 12th generation",
        price: 899,
        color: "#33505a",
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRISJ6msIu4AU9_M9ZnJVQVFmfuhfyJjEtbUm3ZK11_8IV9TV25-1uM5wHjiFNwKy99w0mR5Hk&usqp=CAc"),
    Phone(
        id: 2,
        name: "Pixel 5",
        desc: "Pixel 5",
        price: 699,
        color: "#00ac51",
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd0JhwLvm_uLDLc-la7hK9WyVpe9naJFcebKfhcICiq2KtvXDePNAU_9QO06LPcQ0K0fLByc7m&usqp=CAc"),
    Phone(
        id: 3,
        name: "M1 Macbook Air",
        desc: "Apple Macbook air with apple silicon",
        price: 1099,
        color: "#e0bfae",
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMOMstwtmLnjFb3NHiDJ_kcQnueNVH-rv_3ps96HZmXlFumKWaiBqq_L4Uoyx3iFiNTrXNEbyB&usqp=CAc"),
    Phone(
        id: 4,
        name: "Playstation 5",
        desc: "Sony Playstation 5th generation",
        price: 500,
        color: "#544ee4",
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMOMstwtmLnjFb3NHiDJ_kcQnueNVH-rv_3ps96HZmXlFumKWaiBqq_L4Uoyx3iFiNTrXNEbyB&usqp=CAc"),
  ];

  //list of items in cart
  List<Phone> userCart = [];
  Cart() {
    // Load cart items from shared preferences when Cart is initialized
    _loadCartFromPrefs();
  }

  //getting list of items for sale
  List<Phone> getphoneList() {
    return phoneShop;
  }

  //get list of items in cart
  List<Phone> getUserCart() {
    return userCart;
  }

  //adding items to the cart
   void addItemToCart(Phone phone) {
    userCart.add(phone);
    saveCartToPrefs();
    notifyListeners();
  }

  //remove items from cart
  void removeItemFromCart(Phone phone) {
    userCart.remove(phone);
    saveCartToPrefs();
    notifyListeners();
  }
Future<void> _loadCartFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartIds = prefs.getStringList('cart') ?? [];
    userCart = phoneShop.where((phone) => cartIds.contains(phone.id.toString())).toList();
    notifyListeners();
  }
  
   Future<void> saveCartToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartIds = userCart.map((phone) => phone.id.toString()).toList();
    await prefs.setStringList('cart', cartIds);
  }
}
