import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 100,),
            CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(AppAssets.personImage),
            ),
            Text("Morgan Mill"),
            Text("morgan@gmail.com"),
            SizedBox(
              height: 52,width: 150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(16)
                    )
                  ),
                  onPressed: (){}, child:
              Row(
                mainAxisAlignment: .spaceAround,
                children: [
                  Icon(Icons.edit),
                  Text("Edit Profile")
                ],
              )),
            ),
            ListTile(
              onTap: (){
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("You Push First Tile")));
              },
              leading: Image.asset(AppAssets.notificationIcon,width: 24,height: 24,),
              title: Text("Notifications"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(color: Color(0xffA2A2A2),thickness: 0.6,),
            ListTile(
              // dense: true,
              // contentPadding: EdgeInsets.zero,
              // horizontalTitleGap: 5,
              onTap: (){
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Tap Successfully")));
              },
              leading: Image.asset(AppAssets.notificationIcon,width: 24,height: 24,),
              title: Text("Notifications"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(color: Color(0xffA2A2A2),thickness: 0.6,),
            ListTile(
              leading: Image.asset(AppAssets.notificationIcon,width: 24,height: 24,),
              title: Text("Notifications"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(color: Color(0xffA2A2A2),thickness: 0.6,),
            ListTile(
              leading: Image.asset(AppAssets.notificationIcon,width: 24,height: 24,),
              title: Text("Notifications"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(color: Color(0xffA2A2A2),thickness: 0.6,),
            ListTile(
              leading: Image.asset(AppAssets.notificationIcon,width: 24,height: 24,),
              title: Text("Notifications"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(color: Color(0xffA2A2A2),thickness: 0.6,),
          ],
        ),
      ),
    );
  }
}
