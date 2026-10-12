import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owais_project/constants/app_colors.dart';
import 'package:owais_project/utils/widgets/custom_appbar.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
      child: CustomAppbar(title: "Create Event")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date",style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 25
            ),),
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: .circular(6),
                border: Border.all(
                  color: Color(0xff838383),
                  width: 0.4
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat.yMMMMEEEEd().format(selectedDate),style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),),
                    IconButton(onPressed: (){
                      showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100))
                          .then((value){
                            setState(() {
                              selectedDate = value!;
                            });
                      });
                    }, icon: Icon(Icons.calendar_month)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text("Time",style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25
            ),),
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: .circular(6),
                border: Border.all(
                    color: Color(0xff838383),
                    width: 0.4
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if(selectedTime != null)
                      Text(selectedTime!.format(context).toString(),style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),)
                    else
                      Text("Select Time",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),),
                    IconButton(onPressed: (){
                      showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now())
                          .then((val){
                            setState(() {
                              selectedTime = val;
                            });
                      });
                    }, icon: Icon(Icons.timelapse)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
