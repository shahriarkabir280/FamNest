import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors. teal,
        title: const Text('About'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Displaying the image
            Image.asset(
              'assets/authentications/famNestlogo.png', // Update the path if necessary
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            // Adding some text
            const Text(
              'Welcome to Famnest!',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text('Team Name : Team Extreme\n'
                ' Tawyabul Islam Tamim - 04\n'
                ' Md. Shahriar Kabir - 20\n '
                'Ovijit Chandra Balo - 28\n'
                ' Faiaz Mahmud Ifti - 46\n '

               ,
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
