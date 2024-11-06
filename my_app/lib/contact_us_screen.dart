import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.jpeg'), // Add your logo here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact Email:', style: TextStyle(fontSize: 18)),
            GestureDetector(
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'shahriarkabir834@gmail.com',
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'Contact Us',
                  }),
                );
                launchUrl(emailLaunchUri);
              },
              child: Text('shahriarkabir834@gmail.com', style: TextStyle(color: Colors.blue)),
            ),
            SizedBox(height: 20),
            Text('Phone Number:', style: TextStyle(fontSize: 18)),
            GestureDetector(
              onTap: () async {
                String phoneNumber = 'tel:+1234567890';
                if (await canLaunch(phoneNumber)) {
                  await launch(phoneNumber);
                } else {
                  throw 'Could not launch $phoneNumber';
                }
              },
              child: Text('+1234567890', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
