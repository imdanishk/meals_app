import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

// FiltersNotifier is a StateNotifier that manages a Map of Filter to bool,
// representing the current state of each filter.
class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  // The constructor initializes the state with all filters set to false.
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  // Method to set multiple filters at once.
  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters; // Update the state with the new filter settings.
  }

  // Method to set a single filter.
  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; // mutating state directly is not allowed.
    // Instead, create a new state map with the updated filter status.
    state = {...state, filter: isActive};
  }
  
}


final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

// Define a Provider to filter the meals based on the current filter settings.
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final currentFilters = ref.watch(filtersProvider);

  // Return a list of meals that match the filter criteria.
  return meals.where((meal) {
    // Check each filter and exclude meals that do not match the criteria.
    if (currentFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (currentFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (currentFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (currentFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    // Include the meal if it passes all filter checks.
    return true;
  }).toList(); // Convert the filtered results to a list and return.
});