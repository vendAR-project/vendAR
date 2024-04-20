import 'package:flutter/material.dart';
import 'package:vendar/components/home/home_view.dart';
import 'package:vendar/components/favourites/favourites_view.dart';
import 'package:vendar/components/profile/profile_view.dart';

class CoreView extends StatefulWidget {
  final Function(int) onItemSelected;
  final int initialSelectedIndex;

  const CoreView(
      {super.key,
      required this.onItemSelected,
      required this.initialSelectedIndex});

  @override
  State<CoreView> createState() => _CoreViewState();
}

class _CoreViewState extends State<CoreView> {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> views = [
      FavouritesView(),
      HomeView(),
      ProfileView(),
    ];

    return Scaffold(
      body: views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
