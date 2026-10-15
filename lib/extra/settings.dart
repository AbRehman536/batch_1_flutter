import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/constants/app_colors.dart';
import 'package:owais_project/extra/drawerModel.dart';
import 'package:owais_project/screens/home/favorite.dart';
import 'package:pinput/pinput.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ///Switch
  bool isSwitchON = false;
  ///Slider
  double currentValue = 20;
  ///DropDown
  List<String> courseList = [
    "Flutter",
    "Web",
    "Graphics",
    "Marketing"
  ];
  ///Check box Egg
  bool checkEgg = false;
  bool checkPasta = false;
  String? selectedCourse;
  ///Drawer List
  List<Drawermodel> drawerList = [
    Drawermodel(title: "My Files", icon: Icons.file_copy),
    Drawermodel(title: "Starred", icon: Icons.star),
    Drawermodel(title: "Recent", icon: Icons.history),
    Drawermodel(title: "Offline", icon: Icons.offline_bolt),
    Drawermodel(title: "Upload", icon: Icons.upload_outlined),
    Drawermodel(title: "Trash", icon: Icons.delete),
  ];
  ///Single Selection
  int selectedIndex = -1;
  ///Multi Selection
  List<int> indexList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton(itemBuilder: (BuildContext context) { 
            return [
              PopupMenuItem(child: ListTile(
                leading: Icon(Icons.new_releases_rounded),
                title: Text("Warning"),
                trailing: Icon(Icons.arrow_forward_ios),
              )),
              PopupMenuItem(child: ListTile(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context)=> FavoriteScreen()));
                },
                leading: Icon(Icons.history),
                title: Text("History"),
                trailing: Icon(Icons.arrow_forward_ios),
              )),
              PopupMenuItem(child: ListTile(
                leading: Icon(Icons.upload),
                title: Text("Downloads"),
                trailing: Icon(Icons.arrow_forward_ios),
              )),
              PopupMenuItem(child: ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                trailing: Icon(Icons.arrow_forward_ios),
              )),
            ];
          },)
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              leading: Icon(isSwitchON ? Icons.wifi : Icons.wifi_off_sharp),
              title: Text("WIFI"),
              subtitle: Text(isSwitchON ? "ON" : "OFF"),
              trailing: CupertinoSwitch(
                  value: isSwitchON,
                  onChanged: (val){
                    setState(() {
                      isSwitchON = val;
                    });
                  }),
            ),
            if(isSwitchON == true)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.red,
                ),
              ),
            Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value){
                print(value);
              },
              defaultPinTheme: PinTheme(
                width: 50,height: 50,
                decoration: BoxDecoration(
                  borderRadius: .circular(14),
                  color: Colors.red,
                  border: Border.all(
                    color: Colors.black,
                    width: 1
                  )
                ),
                textStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w900
                )
              ),
            ),
            Slider(
                value: currentValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: currentValue.round().toString(),
                onChanged: (value){
                  setState(() {
                    currentValue = value;
                  });
                }),
            DropdownButton(
              hint: Text("Select Course"),
                value: selectedCourse,
                items: courseList.map((courses){
                  return DropdownMenuItem(
                    value: courses,
                      child: Text(courses.toString()));
                }).toList(),
                onChanged: (val){
                  setState(() {
                    selectedCourse = val;
                  });
                }),

            CheckboxListTile(
              title: Text("Eggs"),
                value: checkEgg,
                onChanged: (val){
                  setState(() {
                    checkEgg = val!;
                  });
                }),
            Row(
              children: [
                Checkbox(
                    value: checkPasta,
                    onChanged: (val){
                      setState(() {
                        checkPasta = val!;
                      });
                    }),
                Text("Noodles & Pasta",
                style: TextStyle(
                  color: checkPasta ? AppColors.primaryColor : Colors.black
                ),)
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: drawerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: (){
                      setState(() {
                       if(indexList.contains(index)){
                         indexList.remove(index);
                       }
                       else{
                         indexList.add(index);
                       }
                      });
                    },
                   tileColor: indexList.contains(index) ? Colors.blue.withOpacity(0.2) : Colors.white,
                   textColor: indexList.contains(index) ? Colors.blueAccent : Colors.black,
                   iconColor: indexList.contains(index) ? Colors.blueAccent : Colors.black,
                    leading: Text("$index"),
                    title: Text(drawerList[index].title.toString()),
                    subtitle: Text("$indexList"),
                  );
                },),
            )

          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(AppAssets.personImage),
                    ),
                    Text("Abdullah Rehman"),
                    Text("abdullahrehman@gmail.com")
                  ],
                )),
            Expanded(
              child: ListView.builder(
                itemCount: drawerList.length,
                itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: (){
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  selected: selectedIndex == index,
                  selectedColor: CupertinoColors.activeBlue,
                  selectedTileColor: Colors.lightBlueAccent.withOpacity(0.1),
                  leading: Icon(drawerList[index].icon),
                  title: Text(drawerList[index].title.toString()),
                );
              },),
            )
          ],
        ),
      ),
    );
  }
}
