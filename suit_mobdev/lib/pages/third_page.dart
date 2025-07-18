import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:suit_mobdev/controller/user_model.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<User> users = [];
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;
  String selectedUser = "";

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers({bool refresh = false}) async {
    if (isLoading) return;
    if (refresh) {
      setState(() {
        page = 1;
        hasMore = true;
        users.clear();
      });
    }

    setState(() => isLoading = true);

    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=$page&per_page=6'),
      headers: {'x-api-key': 'reqres-free-v1'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<User> fetchedUsers = List<User>.from(
        data['data'].map((x) => User.fromJson(x)),
      );

      setState(() {
        users.addAll(fetchedUsers);
        page++;
        if (page > data['total_pages']) hasMore = false;
      });
    }

    setState(() => isLoading = false);
  }

  Future<void> _refresh() async {
    await fetchUsers(refresh: true);
  }

  bool _onScrollNotification(ScrollNotification scrollInfo) {
    if (!isLoading &&
        hasMore &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      fetchUsers();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User List"), backgroundColor: Colors.teal),
      body: Column(
        children: [
          if (selectedUser.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Selected User: $selectedUser",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: NotificationListener<ScrollNotification>(
                onNotification: _onScrollNotification,
                child:
                    users.isEmpty && !isLoading
                        ? Center(child: Text("No users found"))
                        : ListView.builder(
                          itemCount: users.length + (hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < users.length) {
                              final user = users[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(user.avatar),
                                ),
                                title: Text(
                                  "${user.firstName} ${user.lastName}",
                                ),
                                subtitle: Text(user.email),
                                onTap: () {
                                  setState(() {
                                    selectedUser =
                                        "${user.firstName} ${user.lastName}";
                                  });
                                },
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
