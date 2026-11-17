// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

class CategoryModel {
  final String? docId;
  final String? categoryName;
  final String? categoryImage;
  final int? createdAt;

  CategoryModel({
    this.docId,
    this.categoryName,
    this.categoryImage,
    this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    docId: json["docID"],
    categoryName: json["categoryName"],
    categoryImage: json["categoryImage"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String categoryID) => {
    "docID": categoryID,
    "categoryName": categoryName,
    "categoryImage": categoryImage,
    "createdAt": createdAt,
  };
}
