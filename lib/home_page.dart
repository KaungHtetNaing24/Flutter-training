import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Signed In as',style: TextStyle(fontSize: 16),),
            const SizedBox(height: 8),
            Text(
              user.email!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: ()=>FirebaseAuth.instance.signOut(), 
            icon: const Icon(Icons.arrow_back,size: 32,), 
            label: const Text('Sign Out',style: TextStyle(fontSize: 24),),
          ),
          ],
        ),
      ),
    );
  }
}