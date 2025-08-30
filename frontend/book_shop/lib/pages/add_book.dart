import 'dart:io';

import 'package:book_shop/Common/Widgets/custom_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  File? _image;
  File? _preview;
  DateTime? _publishDate;
  DateTime? _lastSoldDate;
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  final _authorController = TextEditingController();
  final _publisherController = TextEditingController();
  final _subjectController = TextEditingController();

  Future<void> _pickPreview() async {
    try {
      final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (pickedFile != null) {
        setState(() {
          _preview = File(pickedFile.files.single.path!);
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void _openImage() async {
    if (_image != null) {
      await OpenFilex.open(_image!.path);
    }
  }

  void _openPreview() async {
    if (_preview != null) {
      await OpenFilex.open(_preview!.path);
    }
  }

  Future<void> _imagePick() async {
    try {
      final picked = ImagePicker();
      final pickedImage = await picked.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _pickDate(bool a) async {
    try {
      final pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1600),
        lastDate: DateTime.now(),
        initialDate: DateTime.now(),
      );
      if (pickedDate == null) return;
      if (a) {
        setState(() {
          _publishDate = pickedDate;
        });
      } else {
        setState(() {
          _lastSoldDate = pickedDate;
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Add book', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter name';
                  }
                  return null;
                },
                controller: _nameController,
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter price';
                  } else if (double.tryParse(value) == null) {
                    return 'Enter valid price';
                  }
                  return null;
                },
                controller: _priceController,
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(labelText: 'Discount'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter price';
                  } else if (double.tryParse(value) == null) {
                    return 'Enter valid price';
                  }
                  return null;
                },
                controller: _discountController,
              ),
              SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter author\'s name';
                  }
                  return null;
                },
                controller: _authorController,
              ),
              SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(labelText: 'Publisher'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter publisher\'s name';
                  }
                  return null;
                },
                controller: _publisherController,
              ),
              SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(labelText: 'Subject'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Subject';
                  }
                  return null;
                },
                controller: _subjectController,
              ),
              SizedBox(height: 20),

              ListTile(
                title: Text(
                  "Publish Date: ${_publishDate == null ? 'Not selected' : DateFormat('yyyy-MM-dd').format(_publishDate!)}",
                ),
                trailing: IconButton(
                  onPressed: () async {
                    await _pickDate(true);
                  },
                  icon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  "Last Sold date: ${_lastSoldDate == null ? 'Not selected' : DateFormat('yyyy-MM-dd').format(_lastSoldDate!)}",
                ),
                trailing: IconButton(
                  onPressed: () {
                    _pickDate(false);
                  },
                  icon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _imagePick();
                    },
                    child: Text('Pick image'),
                  ),
                  SizedBox(width: 5),
                  if (_image != null)
                    TextButton(
                      onPressed: _openImage,
                      style: ElevatedButton.styleFrom(
                        overlayColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        "Open",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),

                  if (_image != null) Icon(Icons.check, color: Colors.green),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickPreview,
                    child: Text('Preview file'),
                  ),
                  SizedBox(width: 5),
                  if (_preview != null)
                    TextButton(
                      onPressed: _openPreview,
                      style: ElevatedButton.styleFrom(
                        overlayColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        "Open",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  if (_preview != null) Icon(Icons.check, color: Colors.green),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: AlignmentGeometry.center,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 40),
                  ),
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
