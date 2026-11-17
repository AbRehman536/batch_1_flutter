import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/constants/app_colors.dart';
import 'package:owais_project/models/Category_model.dart';
import 'package:owais_project/models/product_model.dart';
import 'package:owais_project/screens/admin_panel/category/create_category.dart';
import 'package:owais_project/screens/admin_panel/category/update_category.dart';
import 'package:owais_project/services/Category_service.dart';
import 'package:owais_project/utils/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class AdminExploreScreen extends StatefulWidget {
  const AdminExploreScreen({super.key});

  @override
  State<AdminExploreScreen> createState() => _AdminExploreScreenState();
}

class _AdminExploreScreenState extends State<AdminExploreScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: CustomAppbar(
              title: "Find Product")),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateCategory()));
      },child: Icon(Icons.add),),
      body: Padding(
        padding:  EdgeInsets.all(15.sp),
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
                  borderRadius: .circular(15.r)
                )
              ),
            ),
            SizedBox(height: 20.h
              ,),
            StreamProvider.value(
                value: CategoryService().getAllCategory(),
                initialData: [CategoryModel()],
                builder: (context, child){
                  List<CategoryModel> categoryList = context.watch<List<CategoryModel>>();
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h,
                        mainAxisExtent: 189.h,
                      ),
                      itemCount: categoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: .circular(18.r),
                           // color: productList[index].color.withOpacity(0.2),
                            border: Border.all(
                              color: Colors.black,
                              width: 1
                            )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(categoryList[index].categoryImage.toString(),width: 111.w,height: 74.h,),
                              SizedBox(height: 20.h,),
                              Text(categoryList[index].categoryName.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16.sp,
                                    color: Color(0xff181725)
                                ),),

                              Row(children: [
                                IconButton(onPressed: ()async{
                                  try{
                                    await CategoryService().deleteCategory(
                                      categoryList[index].docId.toString()
                                    );
                                  }catch(e){
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(content: Text(e.toString())));
                                  }
                                }, icon: Icon(Icons.delete,color: Colors.red,)),
                                IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateCategory(model: categoryList[index])));
                                }, icon: Icon(Icons.edit,color: Colors.green,)),
                              ],)
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
            )
          ],
        ),
      ),
    );
  }
}
