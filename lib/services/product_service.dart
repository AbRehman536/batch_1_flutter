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
}