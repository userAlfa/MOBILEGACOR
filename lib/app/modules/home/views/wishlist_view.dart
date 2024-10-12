import 'package:flutter/material.dart';

class WishlistItem {
  final String name;
  final String imagePath;

  WishlistItem({required this.name, required this.imagePath});
}

class WishlistPage extends StatefulWidget {
  final List<WishlistItem> wishlist;

  WishlistPage({required this.wishlist});

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  void _removeFromWishlist(WishlistItem item) {
    setState(() {
      widget.wishlist.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD3A335),
        title: Text('Wishlist', style: TextStyle(color: Colors.black)),
      ),
      body: widget.wishlist.isEmpty
          ? Center(child: Text('Your wishlist is currently empty.'))
          : ListView.builder(
              itemCount: widget.wishlist.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.asset(
                      widget.wishlist[index].imagePath,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(widget.wishlist[index].name),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _removeFromWishlist(widget.wishlist[index]);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}