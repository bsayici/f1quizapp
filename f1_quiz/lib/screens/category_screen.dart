import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/db_connect.dart';
import './home_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DBconnect dbConnect = DBconnect();

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Select Category'),
        backgroundColor: background,
        foregroundColor: neutral,
      ),
      body: FutureBuilder<List<String>>(
        future: dbConnect.fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories available'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                color: neutral,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(
                    snapshot.data![index],
                    style: const TextStyle(
                      color: background,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          category: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
