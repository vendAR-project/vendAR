import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'custom_model_controller.dart';

class AddModelScreen extends StatefulWidget {
  const AddModelScreen({Key? key}) : super(key: key);

  @override
  State<AddModelScreen> createState() => _AddModelScreenState();
}

class _AddModelScreenState extends State<AddModelScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<PlatformFile>? _pickedFiles;
  PlatformFile? _pickedGlbFile;
  CustomModelController _controller = CustomModelController();
  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _pickedFiles = result.files;
      });
    }
  }

  Future<void> _pickGlbFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickedGlbFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Model'),
        backgroundColor: Colors.deepPurple, // Stylish color for the AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'title',
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              const SizedBox(height: 20.0),
              FormBuilderTextField(
                name: 'description',
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 20.0),
              FormBuilderTextField(
                name: 'price',
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
              const SizedBox(height: 20.0),
              FormBuilderDropdown(
                name: 'category',
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                allowClear: true,
                items: ['Fashion', 'Electronics', 'Books', 'Home', 'Other']
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20.0),
              FormBuilderTextField(
                name: 'shopUrl',
                decoration: const InputDecoration(
                  labelText: 'Shop URL',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.link),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: _pickFiles,
                icon: const Icon(Icons.upload_file),
                label: const Text('Select Images'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: _pickGlbFile,
                icon: const Icon(Icons.file_present),
                label: const Text('Select GLB File'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
              ),
              const SizedBox(height: 20.0),
              if (_pickedFiles != null)
                Wrap(
                  spacing: 10,
                  children: _pickedFiles!
                      .map((file) => Chip(
                            label: Text(file.name),
                          ))
                      .toList(),
                ),
              if (_pickedGlbFile != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Chip(
                    label: Text(_pickedGlbFile!.name),
                    avatar: const Icon(Icons.file_present),
                  ),
                ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    var formData = _formKey.currentState!.value;

                    // Call the controller method with nullable lists handled
                    _controller.addModel(
                        formData, _pickedFiles, _pickedGlbFile);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green, // Color for the "Add Model" button
                  minimumSize: Size(double.infinity, 50), // Make it full width
                ),
                child: const Text('Add Model'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
