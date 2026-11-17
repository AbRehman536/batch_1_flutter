import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/constants/app_colors.dart';
import 'package:owais_project/models/product_model.dart';
import 'package:owais_project/screens/admin_panel/category/get_all_category.dart';
import 'package:owais_project/screens/admin_panel/products/create_product.dart';
import 'package:owais_project/screens/admin_panel/products/get_inStock_products.dart';
import 'package:owais_project/screens/admin_panel/products/get_out_stock_product.dart';
import 'package:owais_project/services/product_service.dart';
import 'package:owais_project/utils/widgets/custom_grid.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List<String> imageList = [
    "https://cdn.pixabay.com/photo/2016/11/21/06/53/beautiful-natural-image-1844362_1280.jpg",
    "https://cdn.pixabay.com/photo/2019/10/05/11/36/switzerland-4527757_640.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdsDUznDIrzbJWrMGhfdVSZ0LTs_Nhtxpr1MZvHvvPM6AN2LxiFUgk9mfP&s=10",
  ];
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateProduct()));
      },child: Icon(Icons.add),),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.secondaryColor,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> InStockScreen()));
          }, icon: Icon(Icons.check)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> OutStockScreen()));
          }, icon: Icon(Icons.close)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminExploreScreen()));
          }, icon: Icon(Icons.category)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CarouselSlider(
                  items: imageList.map((images){
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: .circular(15),
                          image: DecorationImage(
                              image: NetworkImage(images),
                              fit: BoxFit.cover
                          )
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason){
                        setState(() {
                          selectedImage = index;
                        });
                      }
                  )),
              StreamProvider.value(
                value: ProductService().getAllProducts(),
                initialData: [ProductModel()],
                builder: (context, child){
                  List<ProductModel> productList = context.watch<List<ProductModel>>();
                  return  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomContainer(
                            stock: productList[index].productStock,
                            productID: productList[index].docId.toString(),
                            product: productList[index],
                            image: AppAssets.pepperImage,
                            title: productList[index].productName.toString(),
                            subTitle: productList[index].productDesc.toString(),
                            price: double.parse(productList[index].productPrice.toString()));
                      },),
                  );
                },
              )
        
            ],
          ),
        ),
      ),
    );
  }
}
