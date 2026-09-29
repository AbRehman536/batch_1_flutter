import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/models/favorite_model.dart';
import 'package:owais_project/utils/widgets/custom_appbar.dart';
import 'package:owais_project/utils/widgets/custom_button.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<FavoriteModel> favoriteList = [
    FavoriteModel(
        image: AppAssets.can1Image,
        title: "Sprite Can",
        ml: "325ml",
        price: 1.50),
    FavoriteModel(
        image: AppAssets.can1Image,
        title: "Diet Coke",
        ml: "300ml",
        price: 1.99),
    FavoriteModel(
        image: AppAssets.can1Image,
        title: "Pepsi Can",
        ml: "325ml",
        price: 1.05),
    FavoriteModel(
        image: AppAssets.can1Image,
        title: "Apple Juice Can",
        ml: "2L",
        price: 5.50),
    FavoriteModel(
        image: AppAssets.can1Image,
        title: "Coca Cola Can",
        ml: "325ml",
        price: 1.50),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppbar(
              title: "Favorite")),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: favoriteList.length,
                  itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.asset(favoriteList[index].image.toString()),
                    title: Text(favoriteList[index].title.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900
                    ),),
                    subtitle: Text("${favoriteList[index].ml.toString()}, Price"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("\$${favoriteList[index].price.toString()}"),
                        Icon(Icons.arrow_forward_ios_sharp)
                      ],
                    ),
                  );
                },),
              ),
              CustomButton(btnLabel: "Add All to Cart", onPressed: (){})
            ],
          ),
        ),
    );
  }
}
