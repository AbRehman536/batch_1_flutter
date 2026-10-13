import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String? selectedCourse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
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
                  color: Colors.blue,
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

          ],
        ),
      ),
    );
  }
}
