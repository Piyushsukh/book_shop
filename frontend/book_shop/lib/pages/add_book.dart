import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();

  DateTime? _publishDate;
  DateTime? _lastSoldDate;

  File? _imageFile;
  File? _previewFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isPreview) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        if (isPreview) {
          _previewFile = File(picked.path);
        } else {
          _imageFile = File(picked.path);
        }
      });
    }
  }

  Future<void> _pickDate(bool isPublish) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        if (isPublish) {
          _publishDate = pickedDate;
        } else {
          _lastSoldDate = pickedDate;
        }
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://127.0.0.1:8000/api/books/"), // change URL
    );

    request.fields['name'] = _nameController.text;
    request.fields['price'] = _priceController.text;
    request.fields['discount'] = _discountController.text;
    request.fields['publish_date'] = _publishDate?.toIso8601String() ?? '';
    request.fields['last_sold'] = _lastSoldDate?.toIso8601String() ?? '';

    if (_imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', _imageFile!.path),
      );
    }
    if (_previewFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath('preview', _previewFile!.path),
      );
    }

    // Later you can add subject, author, publisher IDs (drop-downs)
    request.fields['subject'] = "1"; // example
    request.fields['author'] = "1";
    request.fields['publisher'] = "1";

    var response = await request.send();
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Book added successfully ✅")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed ❌ Code: ${response.statusCode}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Book")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (v) => v!.isEmpty ? "Enter name" : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _discountController,
                decoration: const InputDecoration(labelText: "Discount"),
                keyboardType: TextInputType.number,
              ),
              ListTile(
                title: Text(
                  "Publish Date: ${_publishDate != null ? DateFormat('yyyy-MM-dd').format(_publishDate!) : 'Not selected'}",
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _pickDate(true),
                ),
              ),
              ListTile(
                title: Text(
                  "Last Sold: ${_lastSoldDate != null ? DateFormat('yyyy-MM-dd').format(_lastSoldDate!) : 'Not selected'}",
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _pickDate(false),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(false),
                    child: const Text("Pick Image"),
                  ),
                  const SizedBox(width: 10),
                  _imageFile != null
                      ? const Icon(Icons.check, color: Colors.green)
                      : const SizedBox(),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(true),
                    child: const Text("Pick Preview File"),
                  ),
                  const SizedBox(width: 10),
                  _previewFile != null
                      ? const Icon(Icons.check, color: Colors.green)
                      : const SizedBox(),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Add Book"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
