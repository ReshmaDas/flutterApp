import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/controller/modelClass.dart';
import 'package:new_flutter_app/ui/favPage.dart';
import 'package:http/http.dart'as http;

class UserListController extends GetxController {
  @override
  void onInit() {
    getApiResponse();
    //loadFavorites();
    super.onInit();
  }

  var dataModel = User().obs;
  final favorites = <int>[].obs;

  Future<void> loadFavorites() async {
    final storage = GetStorage();
    if (storage.hasData('favorites')) {
      favorites.value = List<int>.from(storage.read('favorites'));
    }
    // Print favorites to the terminal when loaded
    printFavorites();
  }

  void toggleFavorite(int userId) {
    final index = favorites.indexOf(userId);
    if (index != -1) {
      favorites.removeAt(index);
    } else {
      favorites.add(userId);
    }
    saveFavorites();
    // Get.to(FavoriteUsersPage(
    //   selectedFavoritesData,
    // ));
  }

  void saveFavorites() {
    final storage = GetStorage();
    storage.write('favorites', favorites);
    update();
    // Print favorites to the terminal when updated
    printFavorites();
  }

  void printFavorites() {
    print('Favorites: $favorites');
  }

void showSelectedFavorites() {
  if (favorites.isNotEmpty) {
    final List<User> selectedFavoritesData = [];
    for (int userId in favorites) {
      final user = dataModel.value.data!.firstWhere((user) => user.id == userId);
      selectedFavoritesData.add(User(
        data: [user], // You can pass a list containing the 'user' object
       
      ));
    }
    Get.to(FavoriteUsersPage(
      selectedFavoritesData,
    ));
  } else {
    print('No favorites selected.');
  }
}






  Future<void> getApiResponse() async {
    try {
      final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=2'),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Decoded JSON data: $data');

        User dataApi = User.fromJson(data);
        dataModel.value = dataApi;
        print('Data model updated successfully');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
