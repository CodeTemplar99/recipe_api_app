// ignore_for_file: prefer_const_declarations

import 'dart:convert';
import 'package:receipe_app/models/recipe.dart';
import 'package:http/http.dart' as http;

final Uri recipesUrl = Uri.https(
  'yummly2.p.rapidapi.com',
  '/feeds/list',
  {'limit': '30', 'start': '0'},
);

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    http.Response res = await http.get(
      recipesUrl,
      headers: {
        'X-RapidAPI-Key': '705419a87emsh6b1d750d62d74a9p15198ajsna657997578e3'
      },
    );
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['feed'];

      List<Recipe> recipes = body.map((dynamic recipe) {
        return Recipe.fromJson(recipe);
      }).toList();
      return recipes;
    } else {
      throw ('Unable to retrieve recipes');
    }
  }
}
