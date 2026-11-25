import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:owais_project/models/User_model.dart';

class UserService {

  String UserCollection = "User Collection";
  ///Create User
  Future createUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(UserCollection)
        .doc(model.docId)
        .set(model.toJson());
  }
  ///Update User
  Future updateUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(UserCollection)
        .doc(model.docId)
        .update({"userName" : model.username});
  }
  ///Delete User
  Future deleteUser(String userID)async{
    return await FirebaseFirestore.instance
        .collection(UserCollection)
        .doc(userID)
        .delete();
  }
  ///Get User By ID
  Future<UserModel> getUserByID(String userID){
    return FirebaseFirestore.instance
        .collection(UserCollection)
        .doc(userID)
        .get()
        .then((UserJson) => UserModel.fromJson(UserJson.data()!));
  }
}