import 'package:flutter/material.dart';
import 'ProfilePage.dart';

class EditIconPage extends StatelessWidget {
  const EditIconPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
        title: const Text('Edit Icon'),
      ),
      body: const Center(
        child: Text('Edit Icon Page Content'),
      ),
    );
  }
}
