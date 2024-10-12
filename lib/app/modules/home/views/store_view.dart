import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/views/cart_view.dart';
import 'package:flutter_application_1/app/modules/home/views/chat_view.dart';
import 'package:flutter_application_1/app/modules/home/views/profile_view.dart';
import 'package:flutter_application_1/app/modules/home/views/wishlist_view.dart';
import 'package:get/get.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List<WishlistItem> wishlist = [];
  int _currentIndex = 0; // Track the current index

  void _addToWishlist(String name, String imagePath) {
    setState(() {
      wishlist.add(WishlistItem(name: name, imagePath: imagePath));
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });

    switch (index) {
      case 0:
        // Home Page - This is the current page, do nothing
        break;
      case 1:
        // Navigate to Wishlist
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WishlistPage(wishlist: wishlist),
          ),
        );
        break;
      case 2:
        // Navigate to CartPage
        Get.to(CartPage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFD3A335),
          elevation: 0,
          title: Text("Sneaker Space"),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(ProfilePage(), arguments: {
                  'username': 'Fazza',
                  'email': 'fazzazevana@gmail.com',
                });
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/default_profile_picture.png'),
              ),
            ),
            SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                Get.to(ChatPage()); // Navigate to ChatPage
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'What are you looking for ?',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 16),
              // Banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1,  color: Colors.black),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Air Jordan 1 X Travis Scoot",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "DISCOUNT 20%",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFD3A335), 
                            ),
                            child: Text("Shop Now"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Image.asset(
                      'assets/Jordan-1-High-OG-Travis-Scott-x-Fragment-1.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // Brand Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Brand",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("See all"),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBrandIcon('assets/puma.png'),
                  _buildBrandIcon('assets/nike.png'),
                  _buildBrandIcon('assets/adidas.png'),
                  _buildBrandIcon('assets/reebok.png'),
                ],
              ),
              SizedBox(height: 24),
              // New Arrival Section
              Text(
                "New Arrival",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildProductCard('Nike Air Force 1', 'assets/air-force-1-low-x-peaceminusone.jpg', 6700000, 4.7),
                  _buildProductCard('Adidas NMD', 'assets/adidas-nmd-r1.jpg', 2800000, 4.9),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // Set the current index
          onTap: _onItemTapped, // Handle taps
          selectedItemColor: Color(0xFFD3A335), // Gold Color
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
        ),
      ),
    );
  }
  

  Widget _buildBrandIcon(String assetPath) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(
          assetPath,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildProductCard(String title, String assetPath, int price, double rating) {
    return Container(
      width: 150,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            assetPath,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "\IDR $price",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
              ),
              Text(
                "$rating/5",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          ElevatedButton(
            onPressed: () {
              _addToWishlist(title, assetPath);
            },
            child: Text('Add to Wishlist'),
          ),
        ],
      ),
    );
  }  
}
