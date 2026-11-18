// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

class ProductModel {
  final String? docId;
  final String? categoryID;
  final String? productImage;
  final String? productName;
  final String? productDesc;
  final double? productPrice;
  final String? productDetail;
  final int? productNutrition;
  final bool? productStock;
  final int? createdAt;

  ProductModel({
    this.docId,
    this.categoryID,
    this.productImage,
    this.productName,
    this.productDesc,
    this.productPrice,
    this.productDetail,
    this.productNutrition,
    this.productStock,
    this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    docId: json["docId"],
    categoryID: json["categoryID"],
    productImage: json["productImage"],
    productName: json["productName"],
    productDesc: json["productDesc"],
    productPrice: json["productPrice"]?.toDouble(),
    productDetail: json["productDetail"],
    productNutrition: json["productNutrition"],
    productStock: json["productStock"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String productID) => {
    "docId": productID,
    "categoryID": categoryID,
    "productImage": productImage,
    "productName": productName,
    "productDesc": productDesc,
    "productPrice": productPrice,
    "productDetail": productDetail,
    "productNutrition": productNutrition,
    "productStock": productStock,
    "createdAt": createdAt,
  };
}
