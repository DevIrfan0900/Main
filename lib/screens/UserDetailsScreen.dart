import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/UserModel.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailsScreen({required this.user}); // Accepts a UserModel object

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(user.date);

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user.profilePicture),
            ),
            const SizedBox(height: 20),
            // User Details
            Text(
              'Name: ${user.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('ID: ${user.userId}'),
            SizedBox(height: 10),
            Text('Date: $formattedDate'),
          ],
        ),
      ),
    );
  }
}
