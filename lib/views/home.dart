// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:receipe_app/models/recipe.api.dart';
import 'package:receipe_app/models/recipe.dart';
import 'package:receipe_app/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu_rounded),
            SizedBox(
              width: 10,
            ),
            Text('Food Recipe'),
          ],
        ),
      ),
      body: _buildBody(context),
    );
  }
}

// build body function
FutureBuilder<List<Recipe>> _buildBody(BuildContext context) {
  return FutureBuilder(
    // get the api call function
    future: RecipeApi.getRecipe(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      // check state of connection and data  returned
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          );
        } else {
          // assign recipe variable to snapshot data and return build build item function
          final List<Recipe> recipes = snapshot.data;
          return _buildRecipes(context, recipes);
        }
      }
    },
  );
}

// build recipe item function
ListView _buildRecipes(BuildContext context, List<Recipe> recipes) {
  return ListView.builder(
    itemCount: recipes.length,
    itemBuilder: (context, index) {
      return RecipeCard(
        title: recipes[index].name ?? '',
        cookTime: recipes[index].totalTime ?? '',
        rating: (recipes[index].rating ?? '').toString(),
        thumbnailUrl: recipes[index].images ?? '',
      );
    },
  );
}
