import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/models/onBoardingModel.dart';
import 'package:owais_project/screens/auth_screen/login.dart';
import 'package:owais_project/utils/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  int currentPage = 0;
  PageController pageController = PageController();
  List<OnBoardingModel> onBoardingList = [
   OnBoardingModel(image: AppAssets.onBoarding1, title: "100% Echo Friendly"),
   OnBoardingModel(image: AppAssets.onBoarding2, title: "A Green Planet"),
   OnBoardingModel(image: AppAssets.onBoarding3, title: "Be Earth Wise"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                //scrollDirection: Axis.vertical,
                controller: pageController,
                itemCount: onBoardingList.length,
                onPageChanged: (index){
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Image.asset(onBoardingList[index].image.toString(),
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,),
                      Text(onBoardingList[index].title.toString(), style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30
                      ),),

                    ],
                  );
                },),
            ),
            SmoothPageIndicator(
                controller: pageController,  // PageController
                count:  onBoardingList.length,
                effect:  ExpandingDotsEffect(),  // your preferred effect
                onDotClicked: (index){
                }
            ),
            CustomButton(btnLabel: currentPage == onBoardingList.length - 1
                ? "Get Started" : "Next",
              onPressed: (){
              if(currentPage == onBoardingList.length - 1){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              }
              else{
                pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              }
            },)
          ],
        ),
      )

    );
  }
}
