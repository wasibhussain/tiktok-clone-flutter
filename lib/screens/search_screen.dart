import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tiktok_clone/controller/search_controller.dart';
import 'package:tiktok_clone/model/user_model.dart';
import 'package:tiktok_clone/screens/profile_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController searchController = Get.put(SearchController());

  final TextEditingController searchedText = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(244, 67, 54, 1),
            title: TextFormField(
              controller: searchedText,
              decoration: const InputDecoration(
                  filled: false,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              // onFieldSubmitted: (value) => searchController.searchUser(value),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    searchController.searchUser(searchedText.text);
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: searchController.searchUsers.isEmpty
              ? const Center(
                  child: Text(
                    'Search for users!',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
                  itemCount: searchController.searchUsers.length,
                  itemBuilder: (context, index) {
                    final User user = searchController.searchUsers[index];
                    return InkWell(
                      onTap: () {
                        Get.to(ProfileScreen(uid: user.uid));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profileImage),
                        ),
                        title: Text(
                          user.name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    );
                  }));
    });
  }
}
