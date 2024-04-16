import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Total number of tabs
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.shopping_cart),
                text: 'Marketplace',
              ),
              Tab(
                icon: Icon(Icons.recommend),
                text: 'Recommended',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text('Marketplace View'),
            ),
            Center(
              child: Text('Recommended View'),
            ),
          ],
        ),
      ),
    );
  }
}
