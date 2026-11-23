import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/models/product_model.dart';
import 'package:owais_project/screens/admin_panel/products/create_product.dart';
import 'package:owais_project/services/product_service.dart';
import 'package:owais_project/utils/widgets/custom_grid.dart';
import 'package:provider/provider.dart';

class OutStockScreen extends StatefulWidget {
  const OutStockScreen({super.key});

  @override
  State<OutStockScreen> createState() => _OutStockScreenState();
}

class _OutStockScreenState extends State<OutStockScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateProduct()));
      },child: Icon(Icons.add),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            StreamProvider.value(
              value: ProductService().getOutStockProducts(),
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
                          image: productList[index].productImage ?? "",
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
    );
  }
}
