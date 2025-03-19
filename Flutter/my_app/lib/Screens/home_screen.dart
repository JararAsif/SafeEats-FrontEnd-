import 'package:flutter/material.dart';
import 'UploadImageScreen.dart';
import 'ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  final String username;

  const HomeScreen({super.key, required this.email, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
              email: widget.email,
              username: widget.username,
            )),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UploadImageScreen(

            )),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileScreen(
              email: widget.email,
              username: widget.username,
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text("Welcome, ${widget.username}!"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Card
              Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.settings, color: Colors.green),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Just keep moving forward.",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            Text("Kimberly Nguyen",
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Search Box
              TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),

              const SizedBox(height: 10),

              // Category Section
              const Text(
                "Category",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text("Bartholomew Henderson",
                  style: TextStyle(color: Colors.black54)),

              const SizedBox(height: 10),

              // Work In Progress Card
              Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.construction, color: Colors.green),
                          SizedBox(width: 10),
                          Text(
                            "Work in Progress",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Believe in the magic of the food.",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/ai_scanning_food.png",
                              width: 50, height: 50),
                          Image.asset("assets/robotic_scanner.png",
                              width: 50, height: 50),
                          Image.asset("assets/allergy_warning_app.png",
                              width: 50, height: 50),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Articles Section
              const Text(
                "Latest Articles",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              _buildArticleCard(
                title: "AI Detecting Allergens in Food",
                description:
                "How AI is transforming food safety using allergen detection models.",
                image: "assets/ai_scanning_food.png",
                time: "3 mins ago",
                author: "Michael",
                comments: 145,
              ),

              _buildArticleCard(
                title: "Robotic Scanner for Food Safety",
                description:
                "Exploring robotic scanners and their role in detecting allergens in food packaging.",
                image: "assets/robotic_scanner.png",
                time: "15 mins ago",
                author: "Rachelle",
                comments: 98,
              ),

              _buildArticleCard(
                title: "Smartphone App for Allergy Detection",
                description:
                "An AI-powered app that helps consumers detect allergens in food before purchase.",
                image: "assets/allergy_warning_app.png",
                time: "25 mins ago",
                author: "David",
                comments: 67,
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 22, color: Colors.black), // Black by default
            activeIcon: Icon(Icons.home, size: 22, color: Colors.orangeAccent), // Orange when selected
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 30, color: Colors.black), // Black by default
            activeIcon: Icon(Icons.add_circle, size: 30, color: Colors.orangeAccent), // Orange when selected
            label: "Upload",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 22, color: Colors.black), // Black by default
            activeIcon: Icon(Icons.person, size: 22, color: Colors.orangeAccent), // Orange when selected
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orangeAccent, // Selected label turns orange
        unselectedItemColor: Colors.black, // Unselected items stay black
        backgroundColor: Colors.white, // Clean background
        elevation: 5, // Slightly reduced for a subtler look
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12, // Reduced font size
        unselectedFontSize: 10, // Reduced font size
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildArticleCard({
    required String title,
    required String description,
    required String image,
    required String time,
    required String author,
    required int comments,
  }) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(image, width: 60, height: 60, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(description,
                      style: const TextStyle(color: Colors.black54, fontSize: 14)),
                  const SizedBox(height: 5),
                  Text("Posted $time by $author",
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Column(
              children: [
                const Icon(Icons.comment, color: Colors.red),
                Text("$comments", style: const TextStyle(color: Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}