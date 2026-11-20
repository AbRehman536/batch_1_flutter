import 'package:flutter/material.dart';
import 'package:owais_project/models/product_model.dart';
import 'package:owais_project/services/Category_service.dart';
import 'package:owais_project/services/product_service.dart';

import '../../../models/Category_model.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController nutritionController = TextEditingController();

  List<CategoryModel> categoryList = [];
  CategoryModel? selectedCategory;
  bool isLoading = false;
  bool isExclusiveOffer = false;
  bool isBestSelling = false;
  @override
  void initState(){
    super.initState();
    CategoryService().getCategory()
    .then((val){
      setState(() {
        categoryList = val;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Product"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Enter Product Title"
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: descController,
            decoration: InputDecoration(
              hintText: "Enter Product Description"
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: priceController,
            decoration: InputDecoration(
              hintText: "Enter Product Price"
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: detailsController,
            decoration: InputDecoration(
              hintText: "Enter Product Details"
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: nutritionController,
            decoration: InputDecoration(
              hintText: "Enter Product Nutritions"
            ),
          ),
          SizedBox(height: 10,),
          DropdownButtonFormField(
            hint: Text("Select Category"),
              value: selectedCategory,
              items: categoryList.map((category){
                return DropdownMenuItem(
                  value: category,
                    child: Text(category.categoryName.toString()));
              }).toList(),
              onChanged: (val){
              setState(() {
                selectedCategory = val;
              });
              }),
          SizedBox(height: 10,),
          Row(
            children: [
              Row(
                children: [
                  Checkbox(
                      value: isBestSelling,
                      onChanged: (val){
                        setState(() {
                          isBestSelling = val ?? false;
                        });
                      }),
                  Text("Best Selling")
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: isExclusiveOffer,
                      onChanged: (val){
                        setState(() {
                          isExclusiveOffer = val ?? false;
                        });
                      }),
                  Text("Exclusive Offer")
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),
          isLoading ? Center(child: CircularProgressIndicator(),)
          :ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await ProductService().createProduct(
                ProductModel(
                  categoryID: selectedCategory!.docId,
                  productName: titleController.text,
                  productDesc: descController.text,
                  productPrice: double.parse(priceController.text),
                  productDetail: detailsController.text,
                  productNutrition: int.parse(nutritionController.text),
                  exclusiveOffer: isExclusiveOffer,
                  bestSelling: isBestSelling,
                  productStock: true,
                  createdAt: DateTime.now().millisecondsSinceEpoch
                )
              )
                  .then((value){
                isLoading = false;
                setState(() {});
                    showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("Product Create Successfully"),
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
          }, child: Text("Create Product"))
        ],
      ),
    );
  }
}
