import 'package:flutter/material.dart';

class AddNewModelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Model'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Photos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // Add your image sliders here
                  Container(
                    width: 100,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.grey[300],
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Product Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter product name',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Product Price',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter product price',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Product Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter product features',
              ),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement import model functionality
              },
              child: Text('Import Model'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement select from template functionality
              },
              child: Text('Select from Template'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement add model functionality
              },
              child: Text('Add Model'),
            ),
          ],
        ),
      ),
    );
  }
}
