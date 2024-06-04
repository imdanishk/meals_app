import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

// Here, we have dynamic favourites meals data which data changes, so using StateNotifierProvider()

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  bool toggleMealFavouriteStatus(Meal meal) {
    // Check if the meal is already in the list of favourites.
    final mealIsFavourite = state.contains(meal);

    if (mealIsFavourite) {
      // If it is, remove it from the list.
      state = state.where((oldMeal) => oldMeal.id != meal.id).toList();
      return false;
    } else {
      // If it isn't, add it to the list.
      state = [...state, meal];
      return true;
    }
  }
}

/// Define a StateNotifierProvider for favourite meals.
/// StateNotifierProvider provides an instance of StateNotifier and the state it manages.
final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});

