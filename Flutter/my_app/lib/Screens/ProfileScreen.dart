import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;

  const ProfileScreen({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header section with username and email
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
                      style: const TextStyle(color: Colors.white70),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/activity'); // Navigate to activity screen
                      },
                      child: const Text(
                        'View Activity',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Text(
                    username.isNotEmpty ? username[0] : 'U', // Initial letter
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
          // Profile options
          _profileOption('Detection History', Icons.history, context, '/detectionHistory'),
          _profileOption('Add Picture', Icons.add_a_photo, context, '/uploadImage'),
          _profileOption('Feedback', Icons.feedback_outlined, context, '/feedback'), // Feedback option
          _profileOption('Help & Support', Icons.help_outline, context, '/helpSupport'),
          const Divider(),
          // Sign Out option
          _signOutOption(context),
        ],
      ),
    );
  }

  Widget _profileOption(String title, IconData icon, BuildContext context, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {
        Navigator.pushNamed(context, route); // Navigate to the appropriate route
      },
    );
  }

  Widget _signOutOption(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.orange),
      title: const Text('Sign Out'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {
        Navigator.pushReplacementNamed(context, '/signing'); // Navigate back to the sign-in page
      },
    );
  }
}
