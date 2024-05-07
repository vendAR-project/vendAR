import 'package:flutter/material.dart';
import 'package:vendar/components/template-model/template_model_view.dart';
import 'package:vendar/model/template.dart';
import 'select_template_controller.dart';

class SelectTemplateView extends StatefulWidget {
  const SelectTemplateView({Key? key}) : super(key: key);

  @override
  _SelectTemplateViewState createState() => _SelectTemplateViewState();
}

class _SelectTemplateViewState extends State<SelectTemplateView> {
  final SelectTemplateController _controller = SelectTemplateController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Template> filteredTemplates =
        _controller.getFilteredTemplates(_searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Template'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Type template name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTemplates.length,
              itemBuilder: (context, index) {
                Template template = filteredTemplates[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading:
                        Image.network(template.imageSrc, width: 50, height: 50),
                    title: Text(template.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditTemplateView(template: template),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
