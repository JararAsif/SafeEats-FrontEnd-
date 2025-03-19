import 'package:flutter/material.dart';
import 'package:my_app/auth_service.dart';
import 'EditProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  final String email;

  const ProfileScreen({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String email;
  List<String> allergies = [];
  final AuthService _authService = AuthService();
  int _selectedIndex = 2; // Default to "Profile" (index 2)

  @override
  void initState() {
    super.initState();
    username = widget.username;
    email = widget.email;
    _fetchUserProfile(); // Fetch latest user profile
  }

  /// Fetch user profile from backend
  Future<void> _fetchUserProfile() async {
    final response = await _authService.getUserProfile(email);
    if (response['success']) {
      setState(() {
        username = response['data']['username'] ?? username;
        email = response['data']['email'] ?? email;
        allergies = List<String>.from(response['data']['allergies'] ?? []);
      });
    } else {
      print("Error fetching profile: ${response['message']}");
    }
  }

  /// Update user profile
  Future<void> updateProfile({
    required String userEmail,
    String? newUsername,
    String? newEmail,
    String? newPassword,
    List<String>? updatedAllergies,
  }) async {
    final response = await _authService.updateUserProfile(
      email: userEmail,
      username: newUsername ?? username,
      newEmail: newEmail,
      password: newPassword,
      allergies: updatedAllergies ?? allergies,
    );

    if (response['success']) {
      setState(() {
        username = response['data']['data']['username'] ?? username;
        email = response['data']['data']['email'] ?? email;
        allergies = List<String>.from(response['data']['data']['allergies'] ?? allergies);
      });
      print("Profile updated successfully!");
      await _fetchUserProfile();
    } else {
      print("Error updating profile: ${response['message']}");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    try {
      switch (index) {
        case 0:
        // Pass username and email as arguments to /home
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: {'username': username, 'email': email},
          );
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/uploadImage');
          break;
        case 2:
        // Already on Profile, no navigation needed
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
        backgroundColor: Colors.orange,
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.orange,
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      email,
                      style: const TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () async {
                        final updatedProfile = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                              currentName: username,
                              currentEmail: email,
                              currentAllergies: allergies.join(', '),
                            ),
                          ),
                        );

                        if (updatedProfile != null) {
                          await updateProfile(
                            userEmail: email,
                            newUsername: updatedProfile['name'],
                            newEmail: updatedProfile['email'],
                            updatedAllergies: updatedProfile['allergies'].split(', '),
                          );
                        }
                      },
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Text(
                    username.isNotEmpty ? username[0] : 'U',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Allergies",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                allergies.isNotEmpty
                    ? Wrap(
                  spacing: 8.0,
                  children: allergies
                      .map((allergy) => Chip(
                    label: Text(allergy),
                    backgroundColor: Colors.orange[100],
                  ))
                      .toList(),
                )
                    : const Text("No allergies specified",
                    style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          const Divider(),
          _profileOption('Detection History', Icons.history, context, '/detectionHistory'),
          _profileOption('Add Picture', Icons.add_a_photo, context, '/uploadImage'),
          _profileOption('Feedback', Icons.feedback_outlined, context, '/feedback'),
          _profileOption('Help & Support', Icons.help_outline, context, '/helpSupport'),
          const Divider(),
          _signOutOption(context),
        ],
      ),
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

  Widget _profileOption(String title, IconData icon, BuildContext context, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _signOutOption(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.orange),
      title: const Text('Sign Out'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {
        Navigator.pushReplacementNamed(context, '/signing');
      },
    );
  }
}