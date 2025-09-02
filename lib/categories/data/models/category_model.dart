import 'package:flutter/foundation.dart';

class CategoryModel {
  String id;
  String name;
  String lightImage;
  String darkImage;

  CategoryModel({
    required this.id,
    required this.name,
    required this.lightImage,
    required this.darkImage,
  });

  static List<CategoryModel> categories = [
    CategoryModel(
      id: 'general',
      name: 'General',
      lightImage: 'general_light',
      darkImage: 'general',
    ),
    CategoryModel(
      id: 'sports',
      name: 'Sport',
      lightImage: 'sports_light',
      darkImage: 'sport',
    ),
    CategoryModel(
      id: 'business',
      name: 'Business',
      lightImage: 'business_light',
      darkImage: 'business',
    ),
    CategoryModel(
      id: 'entertainment',
      name: 'Entertainment',
      lightImage: 'entertainment_light',
      darkImage: 'entertainment',
    ),
    CategoryModel(
      id: 'health',
      name: 'Health',
      lightImage: 'health_light',
      darkImage: 'health',
    ),
    CategoryModel(
      id: 'science',
      name: 'Science',
      lightImage: 'science_light',
      darkImage: 'science',
    ),
    CategoryModel(
      id: 'technology',
      name: 'Technology',
      lightImage: 'technology_light',
      darkImage: 'technology',
    ),
  ];
}
