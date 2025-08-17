import 'package:flutter/foundation.dart';

class CategoryModel {
  String id;
  String name;
  String imageName;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageName,
  });

  static List<CategoryModel> categories = [
    CategoryModel(id: '', name: 'General', imageName: 'general'),
    CategoryModel(id: '', name: 'Sport', imageName: 'sport'),
    CategoryModel(id: '', name: 'Business', imageName: 'business'),
  ];
}
