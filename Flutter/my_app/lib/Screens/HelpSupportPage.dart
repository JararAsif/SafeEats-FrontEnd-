import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Help & Support'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'We are here to help you!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            _supportOption(
              context,
              'FAQs',
              'Find answers to frequently asked questions.',
              Icons.question_answer_outlined,
            ),
            const Divider(),
            _supportOption(
              context,
              'Contact Support',
              'Get in touch with our support team.',
              Icons.headset_mic_outlined,
            ),
            const Divider(),
            _supportOption(
              context,
              'Privacy Policy',
              'Learn about our privacy practices.',
              Icons.privacy_tip_outlined,
            ),
            const Divider(),
            _supportOption(
              context,
              'Terms & Conditions',
              'Read our terms and conditions.',
              Icons.article_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _supportOption(
      BuildContext context, String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {
        // Navigate to corresponding pages or show dialogs
        if (title == 'FAQs') {
          // Handle navigation to FAQs
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FAQs page coming soon!')),
          );
        } else if (title == 'Contact Support') {
          // Handle navigation to Contact Support
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contact Support page coming soon!')),
          );
        } else if (title == 'Privacy Policy') {
          // Handle navigation to Privacy Policy
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Privacy Policy page coming soon!')),
          );
        } else if (title == 'Terms & Conditions') {
          // Handle navigation to Terms & Conditions
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Terms & Conditions page coming soon!')),
          );
        }
      },
    );
  }
}
