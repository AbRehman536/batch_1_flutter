import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owais_project/models/product_model.dart';
import 'package:owais_project/services/cloudinaryService.dart';
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

  XFile? selectedImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.product.productName ?? '');
    descController = TextEditingController(text: widget.product.productDesc ?? '');
    priceController = TextEditingController(
        text: widget.product.productPrice != null ? widget.product.productPrice.toString() : '');
    detailsController = TextEditingController(text: widget.product.productDetail ?? '');
    nutritionController = TextEditingController(
        text: widget.product.productNutrition != null ? widget.product.productNutrition.toString() : '');
  }

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

  Widget _buildImagePreview() {
    if (selectedImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: kIsWeb
            ? Image.network(selectedImage!.path, fit: BoxFit.cover)
            : Image.file(File(selectedImage!.path), fit: BoxFit.cover),
      );
    }

    final existingImage = widget.product.productImage;
    if (existingImage != null && existingImage.isNotEmpty && existingImage != "null") {
      if (existingImage.startsWith('http')) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            existingImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported, size: 50),
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            existingImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image, size: 50),
          ),
        );
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
        SizedBox(height: 8),
        Text("Tap to change product image"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product"),
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
                child: _buildImagePreview(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: "Enter Product Title"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(hintText: "Enter Product Description"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(hintText: "Enter Product Price"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(hintText: "Enter Product Details"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nutritionController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Enter Product Nutritions"),
            ),
            const SizedBox(height: 15),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () async {
                      final nav = Navigator.of(context);
                      final messenger = ScaffoldMessenger.of(context);
                      try {
                        isLoading = true;
                        setState(() {});

                        String? imageUrl = widget.product.productImage;
                        if (selectedImage != null) {
                          imageUrl = await CloudinaryService.uploadImage(selectedImage!);
                        }

                        await ProductService().updateProduct(
                          ProductModel(
                            docId: widget.product.docId,
                            productImage: imageUrl,
                            productName: titleController.text,
                            productDesc: descController.text,
                            productPrice: double.tryParse(priceController.text) ?? 0.0,
                            productDetail: detailsController.text,
                            productNutrition: int.tryParse(nutritionController.text) ?? 0,
                          ),
                        );
                        if (!mounted) return;
                        isLoading = false;
                        setState(() {});
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              content: const Text("Product Updated Successfully"),
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
                    child: const Text("Update Product"),
                  )
          ],
        ),
      ),
    );
  }
}
