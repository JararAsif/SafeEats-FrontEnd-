import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  int _selectedIndex = 1; // Default to "Upload" (index 1)

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _getResults() {
    // Placeholder action; replace with your logic (e.g., API call to Django)
    print("Getting results for uploaded image: ${_image!.path}");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing image...')),
    );
    // Example: Add your backend call here
    // e.g., await uploadImageToBackend(_image);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    try {
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: {'username': 'user', 'email': 'email@example.com'}, // Placeholder; adjust as needed
          );
          break;
        case 1:
        // Already on UploadImageScreen, no navigation needed
          break;
        case 2:
          Navigator.pushReplacementNamed(
            context,
            '/profile',
            arguments: {'username': 'user', 'email': 'email@example.com'}, // Placeholder; adjust as needed
          );
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Navigation error: $e')),
      );
      print("Navigation error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Picture'),
        backgroundColor: Colors.orange, // Match your app’s theme
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _image == null
                  ? const Center(child: Text('No image selected'))
                  : Image.file(_image!, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Upload Image', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Take Picture', style: TextStyle(color: Colors.white)),
            ),
            if (_image != null) ...[
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _getResults,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Get Results', style: TextStyle(color: Colors.white)),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 22, color: Colors.black),
            activeIcon: Icon(Icons.home, size: 22, color: Colors.orangeAccent),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 30, color: Colors.black),
            activeIcon: Icon(Icons.add_circle, size: 30, color: Colors.orangeAccent),
            label: "Upload",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 22, color: Colors.black),
            activeIcon: Icon(Icons.person, size: 22, color: Colors.orangeAccent),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        onTap: _onItemTapped,
      ),
    );
  }
}