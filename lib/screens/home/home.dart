import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/utils/widgets/custom_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imageList = [
    "https://cdn.pixabay.com/photo/2016/11/21/06/53/beautiful-natural-image-1844362_1280.jpg",
    "https://cdn.pixabay.com/photo/2019/10/05/11/36/switzerland-4527757_640.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdsDUznDIrzbJWrMGhfdVSZ0LTs_Nhtxpr1MZvHvvPM6AN2LxiFUgk9mfP&s=10",
  ];
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                return CustomGrid(
                    image: AppAssets.pepperImage,
                    title: "Bell Pepper Red",
                    ml: "2Kg",
                    price: 650);
              },),
            )
          ],
        ),
      ),
    );
  }
}
