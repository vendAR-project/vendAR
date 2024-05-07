import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vendar/components/profile/profile_view.dart';
import 'package:vendar/model/product.dart';

// Import the function that handles API interaction
import 'modify_model_controller.dart';

class ModifyModelView extends StatefulWidget {
  final Product product;

  const ModifyModelView({Key? key, required this.product}) : super(key: key);

  @override
  _ModifyModelViewState createState() => _ModifyModelViewState();
}

class _ModifyModelViewState extends State<ModifyModelView> {
  final _formKey = GlobalKey<FormBuilderState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _marketLinkController;
  String? _selectedCategory;
  List<PlatformFile>? _pickedImages;
  PlatformFile? _pickedGlbFile;
  ModifyModelController _controller = ModifyModelController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _marketLinkController =
        TextEditingController(text: widget.product.marketLink);
    _selectedCategory = widget.product.category;
  }

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        _pickedImages = result.files;
      });
    }
  }

  Future<void> _pickGlbFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['bin'],
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickedGlbFile = result.files.first;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final formData = _formKey.currentState!.value;
      bool success = await _controller.modifyModel(
        formData,
        _pickedImages,
        _pickedGlbFile,
        widget.product.id,
      );
      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileView(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Product modified successfully!"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to modify product."),
        ));
      }
    }
  }

  void delete() async {
    bool success = await _controller.delete(
      widget.product.id,
    );
    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileView(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Product modified successfully!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to modify product."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modify Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              delete();
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _submitForm,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: false,
                    aspectRatio: 16 / 9,
                    initialPage: 0,
                    enableInfiniteScroll: false),
                items: widget.product.imageUrls.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.network(url, fit: BoxFit.cover),
                      );
                    },
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        suffixIcon: Icon(Icons.edit),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'description',
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        suffixIcon: Icon(Icons.edit),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'price',
                      controller: _priceController,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        suffixIcon: Icon(Icons.edit),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'marketLink',
                      controller: _marketLinkController,
                      decoration: InputDecoration(
                        labelText: 'Market Link',
                        suffixIcon: Icon(Icons.edit),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    FormBuilderDropdown(
                      name: 'category',
                      initialValue: _selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: <String>[
                        'Fashion',
                        'Electronics',
                        'Books',
                        'Home',
                        'Other'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategory = newValue as String?;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickImages,
                      child: Text('Add New Images'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _pickGlbFile,
                      child: Text('Change Model File'),
                    ),
                    if (_pickedImages != null)
                      Wrap(
                        spacing: 10,
                        children: _pickedImages!
                            .map((file) => Chip(
                                  label: Text(file.name),
                                  avatar: Icon(Icons.image),
                                ))
                            .toList(),
                      ),
                    if (_pickedGlbFile != null)
                      Chip(
                        label: Text(_pickedGlbFile!.name),
                        avatar: Icon(Icons.file_present),
                      ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
