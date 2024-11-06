import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.jpeg'), // Add your logo here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/Tamim.jpeg'), // Ensure this image exists
            ),
            SizedBox(height: 10),
            Text('Tawyabul Islam Tamim', style: TextStyle(fontSize: 20)),
            Text('Roll no: 04', style: TextStyle(fontSize: 15)),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/shahriar.jpeg'), // Ensure this image exists
            ),
            SizedBox(height: 10),
            Text('Md. Shahriar Kabir', style: TextStyle(fontSize: 20)),
            Text('Roll no: 20',style: TextStyle(fontSize: 15)),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/Ovijit.jpeg'), // Ensure this image exists
            ),
            SizedBox(height: 10),
            Text('Ovijit Chandra Balo', style: TextStyle(fontSize: 20)),
            Text('Roll no: 28',style: TextStyle(fontSize: 15)),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/ifti.jpeg'), // Ensure this image exists
            ),
            SizedBox(height: 10),
            Text('Faiaz Mahmud', style: TextStyle(fontSize: 20)),
            Text('Roll no: 46',style: TextStyle(fontSize: 15)),

          ],
        ),
      ),
    );
  }
}
