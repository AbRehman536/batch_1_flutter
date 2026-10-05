import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_colors.dart';

class CustomGrid extends StatelessWidget {
  final String image;
  final String title;
  final String ml;
  final int price;
  const CustomGrid({
    super.key, required this.image, required this.title, required this.ml, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 248,
        width: 170,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: .circular(18),
        border: Border.all(
          color: Color(0xffE2E2E2),
          width: 1
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
         // crossAxisAlignment: .start,
          children: [
            Image.asset(image,width: 80,height: 80,),
            Text(title, style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black
            ),),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(ml, style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff7C7C7C)
              ),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${price}"),
                FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  onPressed: (){},child: Icon(Icons.add),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
