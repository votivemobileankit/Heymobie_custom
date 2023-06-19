import 'dart:core';

class CategoryListModel {
 late final String category_id;
 late final String category;
late  final String cat_image;
late  final String status;

  CategoryListModel(
      {required this.category_id,required this.category,required this.cat_image,required this.status});
}
