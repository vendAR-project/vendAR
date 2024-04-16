import 'package:flutter/material.dart';
import 'package:vendar/components/marketplace/marketplace_view.dart';

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
              child: MarketplaceView(),
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
