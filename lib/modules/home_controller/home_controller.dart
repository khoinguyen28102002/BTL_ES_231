// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hsmarthome/util/smart_device_box.dart';

// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hsmarthome/data/provider/getDataAPI.dart';
import 'package:hsmarthome/data/models/adafruit_get.dart';
import 'dart:async';
import 'package:get/get.dart';
// import 'package:hsmarthome/pages/app/home_page/home_page.dart';
import 'package:rxdart/rxdart.dart';

import '../../pages/app/home_page/home_page.dart';
import '../../pages/app/notification_page/noti_page.dart';

class HomeController extends GetxController {
  // padding constants
  final double horizontalPadding = 30;
  final double verticalPadding = 25;

  final RxInt _currentIndex = 0.obs;
  get currentIndex => _currentIndex.value;

  // late StreamController<AdafruitGET> alarmStream =
  //     StreamController<AdafruitGET>.broadcast();
  // late StreamController<AdafruitGET> doorStream =
  //     StreamController<AdafruitGET>.broadcast();
  late StreamController<AdafruitGET> fanStream =
      StreamController<AdafruitGET>.broadcast();
  late StreamController<AdafruitGET> HumidStream =
      StreamController<AdafruitGET>.broadcast();
  // late StreamController<AdafruitGET> gasAlarmStream =
  //     StreamController<AdafruitGET>.broadcast();
  late StreamController<AdafruitGET> ledStream =
      StreamController<AdafruitGET>.broadcast();
  late StreamController<AdafruitGET> lightStream =
      StreamController<AdafruitGET>.broadcast();
  // late StreamController<AdafruitGET> lightLedStream =
  //     StreamController.broadcast();
  late StreamController<AdafruitGET> tempStream = StreamController.broadcast();
  // late StreamController<AdafruitGET> tempFanStream =
  //     StreamController.broadcast();

  // static String noti = "";
  // static String password = "";
  static double fanSpeed = 0.0;
  static double HumidValue = 0.0;
  // static String gasAlarm = "";
  static double ledValue = 0;
  static double lightValue = 0.0;
  //static String lightLed = "";
  static double tempValue = 0.0;
  static String tempFan = "";

  // ignore: non_constant_identifier_names
  static List energy_consume = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

  static List time_led = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  static String time_led_curr = "";

  static List time_fan = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  static String time_fan_curr = "";

  static double max_val = 1000000000.0;

  static String emailAccount = "abc";

  static double sum_energy_last_week = 1.0;

  static double sum_energy = 0;
  static double sum_energy_led = 0;
  static double sum_energy_fan = 0;

  static int energy_led = 3;
  static int energy_fan = 5;

  static int countOpenDoor = 0;

  // ignore: non_constant_identifier_names
  static List noti_list = [];
  String currTime = "";
  static bool wrong5times = false;

  static List mySmartDevices = [
    // [ smartDeviceName, iconPath , powerStatus ]
    ["Smart Light", "lib/images/light-bulb.png", false],
    ["Smart Fan", "lib/images/fan.png", false],
    ["Gas Detector", "lib/images/gas-detector.png", false],
    ["Camera Door", "lib/images/door-camera.png", false],
    ["Add", "lib/images/add.png", false],
  ];

  onSwitched(int index) {
    if (index == 0) {
      if (ledValue == 0) {
        ledControl(1);
      } else {
        HomePage.reset(0);
        ledControl(0);
      }
      // if (HomePage.autoLed == true) {
      //   HomePage.autoLed = false;
      //   lightLedControl("OFF");
      // }
    } else if (index == 1) {
      if (fanSpeed != 0) {
        HomePage.reset(1);
        fanControl(0);
      } else {
        fanControl(1);
      }
    }
  }
  // if (HomePage.autoFan == true) {
  //   HomePage.autoFan = false;
  //   tempFanControl("OFF");
  // }
  // } else if (index == 2) {
  //   if (gasAlarm == 'ON') {
  //     gasAlarmControl('OFF');
  //   } else {
  //     gasAlarmControl('ON');
  //   }
  //   } else if (index == 3) {
  //     if (password.length == 10) {
  //       // String a = password.substring(0, 3);
  //       String b = password.substring(4);
  //       passControl('ON-$b');
  //     } else {
  //       String b = password.substring(3);
  //       passControl('OFF-$b');
  //     }
  //   }
  // }

  // passControl(String value) async {
  //   // if (value.length == 6) password = value;
  //   // if (value == "OFF") password = 'OFF';
  //   // getDataAPI.updateDoorData(value);
  //   // if (value == 'ON') {
  //   //   AdafruitGET pass = await getDataAPI.getDoorData();
  //   //   password = pass.lastValue!;
  //   // }
  //   getDataAPI.updateDoorData(value);
  //   if (value[0] == 'C' || value[1] == 'P') {
  //     if (value[0] == 'C') {
  //       password = 'ON-${value.substring(7)}';
  //     } else {
  //       password = 'ON-${value.substring(5)}';
  //     }
  //   } else {
  //     password = value;
  //   }
  // }

  fanControl(double value) {
    fanSpeed = value;
    var k = value.round();
    getDataAPI.updateFanData(k.toString());
  }

  // gasAlarmControl(String value) {
  //   gasAlarm = value;
  //   getDataAPI.updateGasAlarmData(value);
  // }

  ledControl(double value) {
    ledValue = value;
    var k = value.round();
    getDataAPI.updateLedData(k.toString());
  }

  // lightLedControl(String value) {
  //   // lightLed = value;
  //   getDataAPI.updateLightLedData(value);
  // }

  // tempFanControl(String value) {
  //   // tempFan = value;
  //   getDataAPI.updateTempFanData(value);
  // }

  // setTimerLed(String hour, String minute) {
  //   String ans = "";
  //   if (hour.length == 1) ans += "0";
  //   ans += hour;
  //   if (minute.length == 1) ans += "0";
  //   ans += minute;
  //   getDataAPI.updateLedData(ans);
  // }

  // setTimerFan(String hour, String minute) {
  //   String ans = "";
  //   if (hour.length == 1) ans += "0";
  //   ans += hour;
  //   if (minute.length == 1) ans += "0";
  //   ans += minute;
  //   getDataAPI.updateFanData(ans);
  // }

  // fanSpeedControl(double valueChange) {
  //   fanSpeed = valueChange;
  //   getDataAPI.updateFanSpeedData(valueChange.toString());
  // }

  retreveSensorData() async {
    //AdafruitGET led = await getDataAPI.getLedData();
    //AdafruitGET ledColor = await getDataAPI.getLedColorData();
    // AdafruitGET fanSwitch = await getDataAPI.getFanSwitchData();
    //AdafruitGET fanSpeed = await getDataAPI.getFanSpeedData();
    // AdafruitGET pass = await getDataAPI.getPassData();
    // print(led.lastValue);
    //ledStream.add(led);
    // ledColorStream.add(ledColor);
    // fanSwitchStream.add(fanSwitch);
    // fanSpeedStream.add(fanSpeed);
    // passStream.add(pass);
    // AdafruitGET alarm = await getDataAPI.getAlarmData();
    AdafruitGET light = await getDataAPI.getLightData();
    AdafruitGET temp = await getDataAPI.getTempData();

    AdafruitGET humid = await getDataAPI.getHumidData();
    //noti = alarm.lastValue!;
    lightValue = double.parse(light.lastValue!);
    tempValue = double.parse(temp.lastValue!);
    HumidValue = double.parse(humid.lastValue!);
    //alarmStream.add(alarm);
    lightStream.add(light);
    tempStream.add(temp);
    HumidStream.add(humid);
  }

  getSmartSystemStatus() async {
    // var fanSpeedData = await getDataAPI.getFanData();
    //var doorData = await getDataAPI.getDoorData();
    //var gasAlarmData = await getDataAPI.getGasAlarmData();
    // var ledData = await getDataAPI.getLedData();
    var humidData = await getDataAPI.getHumidData();
    var lightLedData = await getDataAPI.getLightLedData();
    //var tempFanData = await getDataAPI.getTempFanData();

    //fanSpeed = double.parse(fanSpeedData.lastValue!);
    // password = doorData.lastValue!;
    // gasAlarm = gasAlarmData.lastValue!;
    // ledValue = double.parse(ledData.lastValue!);
    // lightLed = lightLedData.lastValue!;
    // tempFan = tempFanData.lastValue!;

    // var valueLed = int.parse(ledData.lastValue!);
    // led.value = ledData.lastValue!;

    // var valueFanSwitch = int.parse(fanSwitchData.lastValue!);
    // var valueFanSpeed = double.parse(fanSpeedData.lastValue!);
    // var valueAlarm = int.parse(alarmData.lastValue!);
    // var valueDoor = int.parse(doorData.lastValue!);
    // var valuePass = passData.lastValue!;

    // if (valueLed == 1) {
    //   isToggled[0] = true;
    // } else if (valueLed == 0) {
    //   isToggled[0] = false;
    // }
    // if (valueFanSwitch == 1) {
    //   isToggled[1] = true;
    // } else if (valueFanSwitch == 0) {
    //   isToggled[1] = false;
    // }
    // if (valueAlarm == 1) {
    //   isToggled[2] = true;
    // } else if (valueAlarm == 0) {
    //   isToggled[2] = false;
    // }
    // if (valueDoor == 1) {
    //   isToggled[3] = true;
    // } else if (valueDoor == 0) {
    //   isToggled[3] = false;
    // }

    // fanSpeed = valueFanSpeed;
    // password = valuePass;
  }

  streamInit() {
    // alarmStream = BehaviorSubject();
    // doorStream = BehaviorSubject();
    fanStream = BehaviorSubject();
    HumidStream = BehaviorSubject();
    // gasAlarmStream = BehaviorSubject();
    ledStream = BehaviorSubject();
    lightStream = BehaviorSubject();
    //lightLedStream = BehaviorSubject();
    tempStream = BehaviorSubject();
    //tempFanStream = BehaviorSubject();
    getSmartSystemStatus();
    Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        // getSmartSystemStatus();
        retreveSensorData();
      },
    );
  }

  @override
  void onInit() {
    streamInit();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // tempStream.close();
    // gasStream.close();
    // ledStream.close();
    // ledColorStream.close();
    // fanSwitchStream.close();
    // fanSpeedStream.close();
    // alarmStream.close();
    // doorStream.close();
    // passStream.close();
    //alarmStream.close();
    //doorStream.close();
    fanStream.close();
    HumidStream.close();
    //gasAlarmStream.close();
    ledStream.close();
    lightStream.close();
    //lightLedStream.close();
    tempStream.close();
    //tempFanStream.close();
    super.onClose();
  }
}
