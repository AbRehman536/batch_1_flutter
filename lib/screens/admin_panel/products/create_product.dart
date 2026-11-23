import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owais_project/models/product_model.dart';
import 'package:owais_project/services/Category_service.dart';
import 'package:owais_project/services/product_service.dart';

import '../../../models/Category_model.dart';
import '../../../services/cloudinaryService.dart';

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
  XFile? selectedImage;

  void _showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      final img = await CloudinaryService.pickImage(source: ImageSource.gallery);
                      if (img != null) {
                        setState(() {
                          selectedImage = img;
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.image, size: 50, color: Colors.green),
                        SizedBox(height: 8),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      final img = await CloudinaryService.pickImage(source: ImageSource.camera);
                      if (img != null) {
                        setState(() {
                          selectedImage = img;
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.camera_alt, size: 50, color: Colors.green),
                        SizedBox(height: 8),
                        Text("Camera"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _showImagePickerOption(context),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: kIsWeb
                            ? Image.network(selectedImage!.path, fit: BoxFit.contain)
                            : Image.file(File(selectedImage!.path), fit: BoxFit.contain),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                          SizedBox(height: 8),
                          Text("Tap to add product image"),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Enter Product Title",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                hintText: "Enter Product Description",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                hintText: "Enter Product Price",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(
                hintText: "Enter Product Details",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nutritionController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Enter Product Nutritions",
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<CategoryModel>(
              hint: const Text("Select Category"),
              value: selectedCategory,
              items: categoryList.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.categoryName.toString()),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedCategory = val;
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isBestSelling,
                      onChanged: (val) {
                        setState(() {
                          isBestSelling = val ?? false;
                        });
                      },
                    ),
                    const Text("Best Selling"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isExclusiveOffer,
                      onChanged: (val) {
                        setState(() {
                          isExclusiveOffer = val ?? false;
                        });
                      },
                    ),
                    const Text("Exclusive Offer"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () async {
                      final nav = Navigator.of(context);
                      final messenger = ScaffoldMessenger.of(context);
                      try {
                        isLoading = true;
                        setState(() {});

                        String? imageUrl;
                        if (selectedImage != null) {
                          imageUrl = await CloudinaryService.uploadImage(selectedImage!);
                        }

                        await ProductService().createProduct(
                          ProductModel(
                            categoryID: selectedCategory?.docId,
                            productImage: imageUrl,
                            productName: titleController.text,
                            productDesc: descController.text,
                            productPrice: double.tryParse(priceController.text) ?? 0.0,
                            productDetail: detailsController.text,
                            productNutrition: int.tryParse(nutritionController.text) ?? 0,
                            exclusiveOffer: isExclusiveOffer,
                            bestSelling: isBestSelling,
                            productStock: true,
                            createdAt: DateTime.now().millisecondsSinceEpoch,
                          ),
                        );
                        if (!mounted) return;
                        isLoading = false;
                        setState(() {});
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              content: const Text("Product Created Successfully"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                    nav.pop();
                                  },
                                  child: const Text("Okay"),
                                )
                              ],
                            );
                          },
                        );
                      } catch (e) {
                        if (!mounted) return;
                        isLoading = false;
                        setState(() {});
                        messenger.showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                    child: const Text("Create Product"),
                  ),
          ],
        ),
      ),
    );
  }
}
