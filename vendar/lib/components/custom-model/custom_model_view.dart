import 'dart:io'; // Required for file operations
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
  bool _isLoading = false;

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

  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty.';
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty.';
    }
    final price = double.tryParse(value);
    if (price == null) {
      return 'Please enter a valid number.';
    }
    return null;
  }

  void _submitModel() {
    if (_formKey.currentState!.saveAndValidate()) {
      if (_pickedFiles == null ||
          _pickedFiles!.isEmpty ||
          _pickedGlbFile == null) {
        print("Please select required files.");
        return;
      }
      setState(() {
        _isLoading = true;
      });
      var formData = _formKey.currentState!.value;
      _controller
          .addModel(formData, _pickedFiles, _pickedGlbFile)
          .then((success) {
        if (success) {
          Navigator.of(context)
              .pop(); // Assuming pop navigates to the home page
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Operation was not successful')),
          );
        }
      }).whenComplete(() => setState(() => _isLoading = false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Model'),
        backgroundColor: Colors.deepPurple,
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
                validator: _validateRequired,
              ),
              const SizedBox(height: 20.0),
              FormBuilderTextField(
                name: 'description',
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                validator: _validateRequired,
              ),
              const SizedBox(height: 20.0),
              FormBuilderTextField(
                name: 'price',
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: _validatePrice,
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
                validator: _validateRequired,
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
                validator: _validateRequired,
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
                            avatar: const Icon(Icons.image),
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
                onPressed: _isLoading ? null : _submitModel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Add Model'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
