import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/constants/app_colors.dart';
import 'package:owais_project/models/product_model.dart';
import 'package:owais_project/services/product_service.dart';
import 'package:owais_project/utils/widgets/custom_appbar.dart';
import 'package:owais_project/utils/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class AdminCartScreen extends StatelessWidget {
  const AdminCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppbar(
            title: "My Cart",
          )),
      body:
      StreamProvider<List<ProductModel>>.value(
          value: ProductService().getMyCartProducts("101"),
          initialData: const [],
          builder: (context, child){
            List<ProductModel> productList = context.watch<List<ProductModel>>();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final img = productList[index].productImage;
                        return ListTile(
                          leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: (img != null && img.isNotEmpty && img.startsWith('http'))
                                ? Image.network(img, fit: BoxFit.cover, errorBuilder: (c, e, s) => Image.asset(AppAssets.pepperImage))
                                : (img != null && img.isNotEmpty && img != "null")
                                    ? Image.asset(img, fit: BoxFit.cover, errorBuilder: (c, e, s) => Image.asset(AppAssets.pepperImage))
                                    : Image.asset(AppAssets.pepperImage),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productList[index].productName.toString()),
                              Text("${productList[index].productDesc}, Price")
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: .circular(17),
                                      border: Border.all(
                                          color: Color(0xffE2E2E2),
                                          width: 1
                                      )
                                  ) ,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.remove),
                                  )),
                              SizedBox(width: 10,),
                              Text("1"),
                              SizedBox(width: 10,),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: .circular(17),
                                      border: Border.all(
                                          color: Color(0xffE2E2E2),
                                          width: 1
                                      )
                                  ) ,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.add),
                                  )),
                            ],
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(onPressed: ()async{
                                await ProductService().removeFromCart(
                                    userID: "101",
                                    productID: productList[index].docId.toString());
                              }, icon: Icon(Icons.close)),
                              Text("\$${productList[index].productPrice}")
                            ],
                          ),
                        );
                      },),
                  ),
                  CustomButton(btnLabel: "Go to Checkout", onPressed: (){
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Check out",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20
                                    ),),
                                  IconButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, icon: Icon(Icons.close))

                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Delivery",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16
                                    ),),
                                  Row(
                                    children: [
                                      Text("Select Method",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16
                                        ),),
                                      SizedBox(width: 10,),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Payment",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16
                                    ),),
                                  Row(
                                    children: [
                                      Icon(Icons.payment),
                                      SizedBox(width: 10,),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Promo Code",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16
                                    ),),
                                  Row(
                                    children: [
                                      Text("Pick Discount",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16
                                        ),),
                                      SizedBox(width: 10,),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total Cost",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16
                                    ),),
                                  Row(
                                    children: [
                                      Text("\$13.44",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16
                                        ),),
                                      SizedBox(width: 10,),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "By placing an order you agree to our ",
                                            style: TextStyle(
                                                color: Colors.grey
                                            )
                                        ),
                                        TextSpan(
                                            text: "Term ",
                                            style: TextStyle(
                                                color: Colors.black
                                            )
                                        ),
                                        TextSpan(
                                            text: "And ",
                                            style: TextStyle(
                                                color: Colors.grey
                                            )
                                        ),
                                        TextSpan(
                                            text: "Conditions ",
                                            style: TextStyle(
                                                color: Colors.black
                                            )
                                        ),
                                      ]
                                  )),
                              CustomButton(
                                  btnLabel: "Place Order",
                                  onPressed: (){})
                            ],
                          ),
                        );
                      },);
                  })
                ],
              ),
            );
          },
      )

    );
  }
}
