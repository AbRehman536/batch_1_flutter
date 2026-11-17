import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:owais_project/models/Category_model.dart';

class CategoryService {

  String CategoryCollection = "Category Collection";
  ///Create Category
  Future createCategory(CategoryModel model)async{
    DocumentReference docRef =
    await FirebaseFirestore.instance
        .collection(CategoryCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(CategoryCollection)
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }
  ///Update Category
  Future updateCategory(CategoryModel model)async{
    return await FirebaseFirestore.instance
        .collection(CategoryCollection)
        .doc(model.docId)
        .update({"categoryName" : model.categoryName,
      "categoryImage" : model.categoryImage});
  }
  ///Delete Category
  Future deleteCategory(String categoryID)async{
    return await FirebaseFirestore.instance
        .collection(CategoryCollection)
        .doc(categoryID)
        .delete();
  }
  ///Get All Category
  Stream<List<CategoryModel>> getAllCategory(){
    return FirebaseFirestore.instance
        .collection(CategoryCollection)
        .snapshots()
        .map((CategoryList) => CategoryList.docs
        .map((CategoryJson) => CategoryModel.fromJson(CategoryJson.data())).toList());
  }
  ///Get Category
  Future<List<CategoryModel>> getCategory(){
    return FirebaseFirestore.instance
        .collection(CategoryCollection)
        .get()
        .then((CategoryList) => CategoryList.docs
        .map((CategoryJson) => CategoryModel.fromJson(CategoryJson.data())).toList());
  }

}