import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/models/favorite_model.dart';
import 'package:owais_project/models/product_model.dart';
import 'package:owais_project/screens/admin_panel/products/product_details.dart';
import 'package:owais_project/services/product_service.dart';
import 'package:owais_project/utils/widgets/custom_appbar.dart';
import 'package:owais_project/utils/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class AdminFavoriteScreen extends StatefulWidget {
  const AdminFavoriteScreen({super.key});

  @override
  State<AdminFavoriteScreen> createState() => _AdminFavoriteScreenState();
}

class _AdminFavoriteScreenState extends State<AdminFavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppbar(
              title: "Favorite")),
      body:
      StreamProvider.value(
          value: ProductService().getFavoriteProducts("101"),
          initialData: [ProductModel()],
          builder: (context,child){
            List<ProductModel> favoriteList = context.watch<List<ProductModel>>();
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: favoriteList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.asset(AppAssets.product1Image
                             // favoriteList[index].productImage.toString()
                        ),
                          title: Text(favoriteList[index].productName.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w900
                            ),),
                          subtitle: Text("${favoriteList[index].productDesc.toString()}, Price"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("\$${favoriteList[index].productPrice.toString()}"),
                              InkWell(
                                  child: Icon(Icons.arrow_forward_ios_sharp),
                              onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailScreen(model: favoriteList[index])));
                              },)
                            ],
                          ),
                        );
                      },),
                  ),
                  CustomButton(btnLabel: "Add All to Cart", onPressed: (){
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Oop's Order Failed"),
                          content: Text("Something went wrong"),
                          actions: [
                            CustomButton(btnLabel: "Please Try Again", onPressed: (){}),
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("Back to home")),
                          ],
                        );
                      }, );
                  })
                ],
              ),
            );
          },
      )

    );
  }
}
