import 'package:flutter/material.dart';
import 'package:vendar/components/marketplace/marketplace_view.dart';
import 'package:vendar/components/create-model/create_model_view.dart';
import 'package:vendar/components/recommendations/recommendations_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          automaticallyImplyLeading: false,
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
              child: RecommendedView(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateModelView()),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
