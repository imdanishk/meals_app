import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

// Here, we have static dummy meals data which never changes, so using Provider()

/// Define a provider using Riverpod's Provider class. 
/// A provider is a way to expose a piece of state or a value.
final mealsProvider = Provider((ref) {

  /// The callback function here returns the value you want to provide. 
  /// In this case, it's a list of meals.
  return dummyMeals;

  // The 'ref' parameter can be used to interact with other providers if needed.
});
