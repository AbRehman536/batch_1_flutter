import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:owais_project/models/product_model.dart';

class ProductService {

  String productCollection = "Product Collection";
  ///Create Product
  Future createProduct(ProductModel model)async{
    DocumentReference docRef =
    await FirebaseFirestore.instance
        .collection(productCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(productCollection)
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }
  ///Update Product
  Future updateProduct(ProductModel model)async{
    return await FirebaseFirestore.instance
        .collection(productCollection)
        .doc(model.docId)
        .update({"productName" : model.productName,
              "productImage" : model.productImage});
  }
  ///Delete Product
  Future deleteProduct(String productID)async{
    return await FirebaseFirestore.instance
        .collection(productCollection)
        .doc(productID)
        .delete();
  }
  ///Mark Product
  Future markProduct(String productID, bool isStock)async{
    return await FirebaseFirestore.instance
        .collection(productCollection)
        .doc(productID)
        .update({"productStock" : isStock});
  }
  ///Get All Products
  Stream<List<ProductModel>> getAllProducts(){
    return FirebaseFirestore.instance
        .collection(productCollection)
        .snapshots()
        .map((productList) => productList.docs
        .map((productJson) => ProductModel.fromJson(productJson.data())).toList());
  }
  ///Get In Stock Products
  Stream<List<ProductModel>> getInStockProducts(){
    return FirebaseFirestore.instance
        .collection(productCollection)
        .where("productStock", isEqualTo: true)
        .snapshots()
        .map((productList) => productList.docs
        .map((productJson) => ProductModel.fromJson(productJson.data())).toList());
  }
  ///Get Out Stock Products
  Stream<List<ProductModel>> getOutStockProducts(){
    return FirebaseFirestore.instance
        .collection(productCollection)
        .where("productStock", isEqualTo: false)
        .snapshots()
        .map((productList) => productList.docs
        .map((productJson) => ProductModel.fromJson(productJson.data())).toList());
  }

  ///Get Product By Category ID
  Stream<List<ProductModel>> getProductByCategoryID(String categoryID){
    return FirebaseFirestore.instance
        .collection(productCollection)
        .where("categoryID" , isEqualTo:  categoryID)
        .snapshots()
        .map((productList) => productList.docs
        .map((productJson) => ProductModel.fromJson(productJson.data())).toList());
  }
  ///Get My Cart Products
  Stream<List<ProductModel>> getMyCartProducts(String userID){
    return FirebaseFirestore.instance
        .collection(productCollection)
        .where("myCart", arrayContains: userID)
        .snapshots()
        .map((productList) => productList.docs
        .map((productJson) => ProductModel.fromJson(productJson.data())).toList());
  }
  ///add to cart
  Future addToCart({
    required String userID, required String productID
})async{
    return await FirebaseFirestore.instance
        .collection(productCollection)
        .doc(productID)
        .update({"myCart": FieldValue.arrayUnion([userID])});
  }
  ///remove From cart
  Future removeFromCart({
    required String userID, required String productID
  })async{
    return await FirebaseFirestore.instance
        .collection(productCollection)
        .doc(productID)
        .update({"myCart": FieldValue.arrayRemove([userID])});
  }
  ///Get Favorite Products
  Stream<List<ProductModel>> getFavoriteProducts(String userID){
    return FirebaseFirestore.instance
        .collection(productCollection)
        .where("favorite", arrayContains: userID)
        .snapshots()
        .map((productList) => productList.docs
        .map((productJson) => ProductModel.fromJson(productJson.data())).toList());
  }
  ///add to favorite
  Future addToFavorite({
    required String userID, required String productID
})async{
    return await FirebaseFirestore.instance
        .collection(productCollection)
        .doc(productID)
        .update({"favorite": FieldValue.arrayUnion([userID])});
  }
  ///remove From Favorite
  Future removeFromFavorite({
    required String userID, required String productID
  })async{
    return await FirebaseFirestore.instance
        .collection(productCollection)
        .doc(productID)
        .update({"favorite": FieldValue.arrayRemove([userID])});
  }

  ///Get Exclusive Offer Products
  Stream<List<ProductModel>> getExclusiveOfferProducts(){
    return FirebaseFirestore.instance
        .collection(productCollection)
        .where("exclusiveOffer", isEqualTo: true)
        .snapshots()
        .map((productList) => productList.docs
        .map((productJson) => ProductModel.fromJson(productJson.data())).toList());
  }
  ///Mark Product Exclusive
  Future markExclusiveProduct(String productID, bool value)async{
    return await FirebaseFirestore.instance
        .collection(productCollection)
        .doc(productID)
        .update({"exclusiveOffer" : value});
  }
  ///Get Best Selling Products
  Stream<List<ProductModel>> getBestSellingProducts(){
    return FirebaseFirestore.instance
        .collection(productCollection)
        .where("bestSelling", isEqualTo: true)
        .snapshots()
        .map((productList) => productList.docs
        .map((productJson) => ProductModel.fromJson(productJson.data())).toList());
  }
  ///Mark Product Best Selling
  Future markBestSellingProduct(String productID, bool value)async{
    return await FirebaseFirestore.instance
        .collection(productCollection)
        .doc(productID)
        .update({"bestSelling" : value});
  }
}