import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'UserDetailsScreen.dart';
import '../models/UserModel.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search List',
      home: SearchListScreen(),
    );
  }
}

class SearchListScreen extends StatefulWidget {
  @override
  _SearchListScreenState createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  // Sample list of items
  final List<UserModel> _items = [
    UserModel(
      name: 'Alice',
      userId: '001',
      profilePicture: 'https://randomuser.me/api/portraits/women/0.jpg',
      date: DateTime(2024, 12, 4),
    ),
    UserModel(
      name: 'Bob',
      userId: '002',
      profilePicture: 'https://randomuser.me/api/portraits/men/1.jpg',
      date: DateTime(2024, 12, 3),
    ),
    UserModel(
      name: 'Charlie',
      userId: '003',
      profilePicture: 'https://randomuser.me/api/portraits/men/2.jpg',
      date: DateTime(2024, 12, 2),
    ),
    UserModel(
      name: 'Lamb',
      userId: '004',
      profilePicture: 'https://randomuser.me/api/portraits/men/3.jpg',
      date: DateTime(2024, 2, 23),
    ),
    UserModel(
      name: 'Kastro',
      userId: '005',
      profilePicture: 'https://randomuser.me/api/portraits/men/4.jpg',
      date: DateTime(2024, 12, 9),
    ),
    UserModel(
      name: 'Charlie',
      userId: '003',
      profilePicture: 'https://randomuser.me/api/portraits/men/5.jpg',
      date: DateTime(2024, 12, 2),
    ),
    UserModel(
      name: 'Zak Abbel',
      userId: '006',
      profilePicture: 'https://randomuser.me/api/portraits/men/6.jpg',
      date: DateTime(2024, 12, 8),
    ),
    UserModel(
      name: 'Sam Oye',
      userId: '007',
      profilePicture: 'https://randomuser.me/api/portraits/men/7.jpg',
      date: DateTime(2024, 12, 7),
    ),
    UserModel(
      name: 'Zoliosum',
      userId: '008',
      profilePicture: 'https://randomuser.me/api/portraits/men/8.jpg',
      date: DateTime(2024, 12, 6),
    ),
    UserModel(
      name: 'Abraham',
      userId: '010',
      profilePicture: 'https://randomuser.me/api/portraits/men/9.jpg',
      date: DateTime(2024, 12, 22),
    ),
    UserModel(
      name: 'Sakium',
      userId: '0018',
      profilePicture: 'https://randomuser.me/api/portraits/men/10.jpg',
      date: DateTime(2024, 12, 18),
    ),

  ];


  // List to display filtered items
  List<UserModel> _filteredItems = [];

  // TextEditingController for search input
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the filtered list with all items
    _filteredItems = _items;
    // Listen for search input changes
    _searchController.addListener(() {
      _filterItems();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Method to filter items based on search input
  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _items
          .where((item) => item.name.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search List View'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // List View
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final user = _filteredItems[index];
                String formattedDate = DateFormat('dd-MM-yyyy').format(user.date);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell( // Makes the item tappable
                        onTap: () {
                          // Navigate to the details screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailsScreen(user: user), // Pass user data
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Profile Picture
                            CachedNetworkImage(
                              imageUrl: user.profilePicture,
                              placeholder: (context, url) => Container(
                                width: 70,
                                height: 70,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 35,
                              ),
                              imageBuilder: (context, imageProvider) => CircleAvatar(
                                radius: 35,
                                backgroundImage: imageProvider,
                              ),
                            ),
                            const SizedBox(width: 15),
                            // User Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'ID: ${user.userId}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Date: $formattedDate',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )


        ],
      ),
    );
  }
}
