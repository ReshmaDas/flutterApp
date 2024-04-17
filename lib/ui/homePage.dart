import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:new_flutter_app/controller/apiIntegration.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});
  final contrillerPage = Get.put(UserListController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(actions: [
          // IconButton(
          //   icon: Icon(Icons.favorite),
          //   onPressed: () {
          //     contrillerPage.loadFavorites(); // Load favorites when button is pressed
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              contrillerPage.showSelectedFavorites(); // Show selected favorites when button is pressed
            },
          ),
        
        ],),
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.amber,
          ),
          Obx(
        () => contrillerPage.dataModel.value.data!.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
              shrinkWrap: true,
                itemCount: contrillerPage.dataModel.value.data!.length,
                itemBuilder: (context, index) {
                  var user = contrillerPage.dataModel.value.data![index];
                  return ListTile(

                    title: Row(
                      
                      children: [
                       
                        CircleAvatar(
                            
                          backgroundImage: NetworkImage('${user.avatar}'),
                        ),
                        Text('${user.firstName} ${user.lastName}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: contrillerPage.favorites.contains(user.id)
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border),
                          onPressed: () {
                            contrillerPage.toggleFavorite(user.id!);
                      },
                    ),
                  );
                  
                },
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     controller.fetchUsers();
      //   },
      //   child: Icon(Icons.refresh),
      // ),
        ]
    )
        
    
    );
  }
}