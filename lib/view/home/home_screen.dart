import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart' as ds;
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference sensorValueRef =
  FirebaseDatabase.instance.ref('test');
  DatabaseReference humidifier_ref = FirebaseDatabase.instance.ref("humidifier");
  String sensorTemperature = "--";
  String sensorHumidity = "--";

  @override
  void initState() {
    // TODO: implement initState
    sensorValueRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot;
      setState(() {
        sensorTemperature = data.child("sensor_temperature").value.toString();
        sensorHumidity = data.child("sensor_humidity").value.toString();
      });
      print(data);
    });
  }

  bool isPressed = false;
  @override


//Offset(-13.6, -13.6)
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFFE7ECEF);
    double blur = 30.0;
    double button_blur = isPressed? 5:30;
    Offset bottom_distance = Offset(15, 20);
    Offset top_distance = Offset(-20, -15);
    Offset button_distance = isPressed? Offset(10, 10) : Offset(13.6, 13.6);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Text(
                    "Parameters",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              decoration: ds.BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: backgroundColor,
                boxShadow: [
                  ds.BoxShadow(
                    blurRadius: blur,
                    offset: top_distance,
                    color: Colors.white,
                    inset: false,
                  ),
                  ds.BoxShadow(
                    blurRadius: blur,
                    offset: bottom_distance,
                    color: Color(0xFFA7A9AF),
                      inset: false,
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),

              width: MediaQuery.of(context).size.width-50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Temperature",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Current Room temperature: $sensorTemperature C"),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: ds.BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: backgroundColor,
                boxShadow: [
                  ds.BoxShadow(
                    blurRadius: blur,
                    offset: top_distance,
                    color: Colors.white,
                    inset: false,
                  ),
                  ds.BoxShadow(
                    blurRadius: blur,
                    offset: bottom_distance,
                    color: Color(0xFFA7A9AF),
                    inset: false,
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),

              width: MediaQuery.of(context).size.width-50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Humidity",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Current Room humidity: $sensorHumidity %"),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Humidifier status: "),
                      isPressed? Text("ON", style: TextStyle(color: Colors.green),) : Text("OFF", style: TextStyle(color: Colors.red),),

                    ],
                  ),


                ],
              ),
            ),
            SizedBox(height: 100,),
            GestureDetector(
              onTap: () => setState(()  {
                isPressed = !isPressed;
                print(isPressed);
                 humidifier_ref.set({
                  "status": isPressed,
                });

              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                child: Container(
                  width: 160,
                  height: 160,
                  child: Icon(
                    Icons.power_settings_new_outlined,
                    size: 53,
                    color: isPressed? Colors.green : Colors.red,
                  ),
                  decoration: ds.BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(31),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        backgroundColor,
                        backgroundColor,
                      ],
                    ),
                    boxShadow: [
                      ds.BoxShadow(
                        color: Colors.white,
                        offset: -button_distance,
                        blurRadius: button_blur,
                        spreadRadius: 0.0,
                        inset: isPressed,
                      ),
                      ds.BoxShadow(
                        color: Color(0xFFA7A9AF),
                        offset: button_distance,
                        blurRadius: button_blur,
                        spreadRadius: 0.0,
                        inset: isPressed,
                      ),
                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
