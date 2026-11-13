import 'package:flutter/material.dart';
import 'package:owais_project/models/product_model.dart';
import 'package:owais_project/services/product_service.dart';

class UpdateProduct extends StatefulWidget {
  final ProductModel product;
  const UpdateProduct({super.key, required this.product});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController nutritionController = TextEditingController();

  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    titleController = TextEditingController(text: widget.product.productName.toString());
    descController = TextEditingController(text: widget.product.productDesc.toString());
    priceController = TextEditingController(text: widget.product.productPrice.toString());
    detailsController = TextEditingController(text: widget.product.productDetail.toString());
    nutritionController = TextEditingController(text: widget.product.productNutrition.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
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
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await ProductService().updateProduct(
                  ProductModel(
                    docId: widget.product.docId,
                      productName: titleController.text,
                      productDesc: descController.text,
                      productPrice: double.parse(priceController.text),
                      productDetail: detailsController.text,
                      productNutrition: int.parse(nutritionController.text),
                  )
              )
                  .then((value){
                isLoading = false;
                setState(() {});
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Product Update Successfully"),
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
          }, child: Text("Update Product"))
        ],
      ),
    );
  }
}
