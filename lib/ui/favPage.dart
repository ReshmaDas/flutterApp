import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:new_flutter_app/controller/apiIntegration.dart';
import 'package:new_flutter_app/controller/modelClass.dart';

class FavoriteUsersPage extends StatelessWidget {
  final List<User> selectedFavorites;

  FavoriteUsersPage(this.selectedFavorites);
final favoriteUsers = Get.put(UserListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Favorites'),
      ),
      body: 
      ListView.builder(
        itemCount: selectedFavorites.length,
        itemBuilder: (context, index) {
          var user = selectedFavorites[index];
          return ListTile(
            title: Text('${user.data!.first.firstName} ${user.data!.first.lastName}'),
          );
        },
      ),
    );
  }
}