import 'package:flutter/material.dart';

class CreateModelView extends StatelessWidget {
  const CreateModelView({Key? key}) : super(key: key);

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
          children: <Widget>[
            Text(
              'Choose your option:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Upload your custom model with a GLB file or use one of our available templates to get started quickly.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.file_upload),
                  label: Text('Upload GLB'),
                  onPressed: () {
                    // Implement your file upload functionality here
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.dashboard_customize),
                  label: Text('Use Template'),
                  onPressed: () {
                    // Implement template selection functionality here
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
