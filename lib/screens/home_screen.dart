import 'package:e_commerce_assignment/models/cart.dart';
import 'package:e_commerce_assignment/models/phone.dart';
import 'package:e_commerce_assignment/screens/product_details_Screen.dart';
import 'package:e_commerce_assignment/widgets/product_widget.dart';
import 'package:e_commerce_assignment/screens/cart_screen.dart'; // Import the CartScreen widget
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller =
      PageController(viewportFraction: 0.8, keepPage: true);

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartScreen()),
        );
      }
    });
  }

  void addPhoneToCart(Phone phone) {
    Provider.of<Cart>(context, listen: false).addItemToCart(phone);

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Successfully Added to Cart!'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello!", style: TextStyle(fontSize: 16)),
              Text('William James', style: TextStyle(fontSize: 16))
            ],
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user_img.png'),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: SizedBox(
                  height: 135.0, // Adjust the height as needed
                  child: ListView(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildOfferContainer(
                          'Get College Discount \n 20% Off \nFor Laptops',
                          'assets/images/laptop_screen.png'),
                      _buildOfferContainer(
                          'Get upto Discount \n 40% off \n For Accessories. ',
                          'assets/images/gift.png'),
                      _buildOfferContainer(
                          "Exchange available!!",
                          'assets/images/smartphone.png'),
                      // Add more offer containers here
                    ],
                  ),
                ),
              ),
              // Add other widgets below the offer containers
              SizedBox(height: 8),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3, // Set the count of pages
                  effect: const ExpandingDotsEffect(),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Popular"),
                    Text('See all')
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.6, // Adjust the height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.getphoneList().length,
                  itemBuilder: (context, index) {
                    Phone phone = value.getphoneList()[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(phone: phone))),
                      child: ProductListwidget(
                        onTap: () => addPhoneToCart(phone),
                        phone: phone,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Color.fromRGBO(96, 85, 216, 1),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color.fromRGBO(96, 85, 216, 1),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Color.fromRGBO(96, 85, 216, 1),
              ),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: Color.fromRGBO(96, 85, 216, 1),
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: Color.fromRGBO(96, 85, 216, 1),
              ),
              label: 'User Account',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferContainer(String title, String imagePath) {
    return Container(
      width: 343,
      height: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromRGBO(96, 85, 216, 1),
      ),
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            SizedBox(height: 8.0),
            Image.asset(imagePath,
                width: 89.0, height: 145), // Adjust image size as needed
          ],
        ),
      ),
    );
  }
}
