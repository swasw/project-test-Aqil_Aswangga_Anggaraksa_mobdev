import 'package:flutter/material.dart';
import 'package:suit_mobdev/globals/global_var.dart';
import 'package:suit_mobdev/main.dart';
import 'package:suit_mobdev/pages/third_page.dart';

class SecondPage extends StatefulWidget {
  final String nameDisplay;

  const SecondPage({super.key, required this.nameDisplay});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ThirdScreen()),
          );
        },
        label: Text('Choose a User'),
        icon: Icon(Icons.person_add),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              height: 100,
              color: Colors.grey[300],
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
                  ),
                  SizedBox(width: 8),
                  Text("Second Screen", style: TextStyle(fontSize: 20)),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // List of chosen users
            Expanded(
              child:
                  chosen.isEmpty
                      ? Center(
                        child: Text(
                          "Selected user",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                      : ListView.builder(
                        itemCount: chosen.length,
                        itemBuilder: (context, index) {
                          final user = chosen[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.avatar),
                            ),
                            title: Text('${user.firstName} ${user.lastName}'),
                            subtitle: Text(user.email),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
