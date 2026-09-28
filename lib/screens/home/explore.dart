import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/constants/app_colors.dart';
import 'package:owais_project/models/product_model.dart';
import 'package:owais_project/utils/widgets/custom_appbar.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<ProductModel> productList = [
    ProductModel(image: AppAssets.product1Image, title: "Fruits & Vegetables", color: Color(0xff53B175)),
    ProductModel(image: AppAssets.product1Image, title: "Cooking oil & Ghee", color: Color(0xffF8A44C)),
    ProductModel(image: AppAssets.product1Image, title: "Meat & Fish", color: Color(0xffF7A593)),
    ProductModel(image: AppAssets.product1Image, title: "Bakery & Snacks", color: Color(0xffD3B0E0)),
    ProductModel(image: AppAssets.product1Image, title: "Dairy & Eggs", color: Color(0xffFDE598)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppbar(
              title: "Find Product")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                fillColor: Color(0xffF2F3F2),
                filled: true,
                prefixIcon: Icon(Icons.search),
                hint: Text("Search Product"),
                border: OutlineInputBorder(
                  borderSide: .none,
                  borderRadius: .circular(15)
                )
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    mainAxisExtent: 189,
                  ),
                  itemCount: productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: .circular(18),
                        color: productList[index].color.withOpacity(0.2),
                        // border: Border.all(
                        //   color: Colors.black,
                        //   width: 1
                        // )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(productList[index].image.toString(),width: 111,height: 74,),
                          SizedBox(height: 20,),
                          Text(productList[index].title.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: Color(0xff181725)
                          ),)
                        ],
                      ),
                    );
                  },
                  ),
            )
          ],
        ),
      ),
    );
  }
}
