import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vendar/model/template.dart';
import 'template_model_controller.dart'; // Assuming this is the correct path for your controller

class EditTemplateView extends StatefulWidget {
  final Template template;

  EditTemplateView({Key? key, required this.template}) : super(key: key);

  @override
  _EditTemplateViewState createState() => _EditTemplateViewState();
}

class _EditTemplateViewState extends State<EditTemplateView> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<PlatformFile>? _pickedFiles;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _marketLinkController;
  String? _selectedCategory;
  bool _isLoading = false;

  final EditModelController _controller = EditModelController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "");
    _descriptionController = TextEditingController(text: "");
    _priceController = TextEditingController(text: "");
    _marketLinkController = TextEditingController(text: "");
    _selectedCategory = "Fashion";
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        _pickedFiles = result.files;
      });
    }
  }

  void _submitChanges() {
    if (_formKey.currentState!.validate()) {
      if (_pickedFiles == null || _pickedFiles!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one image.')),
        );
        return;
      }
      setState(() {
        _isLoading = true;
      });

      var formData = {
        'title': _nameController.text,
        'description': _descriptionController.text,
        'price': double.tryParse(_priceController.text) ?? 0,
        'shopUrl': _marketLinkController.text,
        'category': _selectedCategory,
      };

      _controller
          .addModel(formData, _pickedFiles!, widget.template.modelSrc)
          .then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Changes saved successfully!')),
          );
          Navigator.of(context).pop(); // Optionally pop back if needed
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save changes.')),
          );
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Template'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Image.network(widget.template.imageSrc, height: 150),
              const SizedBox(height: 20),
              _buildTextField(_nameController, 'Name', 'Please enter a name.'),
              const SizedBox(height: 20),
              _buildTextField(_descriptionController, 'Description',
                  'Please enter a description.'),
              const SizedBox(height: 20),
              _buildTextField(
                  _priceController, 'Price', 'Please enter a valid price.',
                  isPrice: true),
              const SizedBox(height: 20),
              _buildCategoryDropdown(),
              const SizedBox(height: 20),
              _buildTextField(_marketLinkController, 'Market Link',
                  'Please enter a market link.'),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text('Select Images'),
                onPressed: _pickFiles,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              _displayPickedFiles(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitChanges,
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextField(
      TextEditingController controller, String label, String errorText,
      {bool isPrice = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: isPrice ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        if (isPrice && double.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        return null;
      },
    );
  }

  DropdownButtonFormField<String> _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(),
      ),
      items: ['Fashion', 'Electronics', 'Books', 'Home', 'Other']
          .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category),
              ))
          .toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
    );
  }

  Wrap _displayPickedFiles() {
    return Wrap(
      spacing: 10,
      children: _pickedFiles
              ?.map((file) => Chip(
                    label: Text(file.name),
                    avatar: const Icon(Icons.image),
                  ))
              ?.toList() ??
          [],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _marketLinkController.dispose();
    super.dispose();
  }
}
