import 'package:Amit_Retail_App/Cart/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:Amit_Retail_App/item_compnenets/home_screen.dart';
import 'package:flutter_cart/flutter_cart.dart';

import 'Login_Register/login_page.dart';
import 'categories/categories_screen.dart';

void main() => runApp(const BottomBar());

/// This is the main application widget.
class BottomBar extends StatelessWidget {
  const BottomBar({Key key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int selectedPage = 0;

  final _pageOptions = [
    HomeScreen(),
    CategoriesScreen(),
   CartPage(),
    LoginPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black38,

          items: const <BottomNavigationBarItem>[

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconData(0xe148, fontFamily: 'MaterialIcons')),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
          currentIndex: selectedPage,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          }),
    );
  }
}