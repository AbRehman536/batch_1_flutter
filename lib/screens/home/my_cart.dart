import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/constants/app_colors.dart';
import 'package:owais_project/utils/widgets/custom_appbar.dart';
import 'package:owais_project/utils/widgets/custom_button.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppbar(
            title: "My Cart",
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.asset(AppAssets.pepperImage),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bell Pepper Red"),
                        Text("1Kg, Price")
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
                        Icon(Icons.close),
                        Text("\$4.99")
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
      ),
    );
  }
}
