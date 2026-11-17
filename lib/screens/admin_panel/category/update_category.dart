import 'package:flutter/material.dart';
import 'package:owais_project/models/Category_model.dart';
import 'package:owais_project/services/Category_service.dart';

class UpdateCategory extends StatefulWidget {
  final CategoryModel model;
  const UpdateCategory({super.key, required this.model});

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    nameController.text = widget.model.categoryName.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Category"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                hintText: "Enter Category Title"
            ),
          ),
          SizedBox(height: 10,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await CategoryService().updateCategory(
                  CategoryModel(
                    docId: widget.model.docId.toString(),
                      categoryName: nameController.text,
                      createdAt: DateTime.now().millisecondsSinceEpoch
                  )
              )
                  .then((value){
                isLoading = false;
                setState(() {});
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Category Update Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text("Okay"))
                    ],
                  );
                },);
              });
            }catch(e){
              isLoading = false;
              setState(() {});
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Update Category"))
        ],
      ),
    );
  }
}
