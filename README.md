# hsmarthome
------------------------------
# SMART HOME SYSTEM PROJECT

-------------------------------
This project is made by a team of 4 people: Đậu Xuân Thành, Nguyễn Xuân Thắng, Nguyễn Lương Trọng, Nguyễn Huy Hoàng

Description: Developing a smart home system including device system (sensors, actuators,...), Gateway, ioT Server, Database and mobile application

System Architecture:

![MVC](https://user-images.githubusercontent.com/80350443/236884659-923835ac-85da-46ca-865b-0187c6b06155.png)

Device system:

![Device connect](https://user-images.githubusercontent.com/80350443/236883464-b12b7a7e-1f6c-47f0-bc74-f9d4aed31fa9.png)

- Using 4 sensors (DHT22, MQ2 sensor, light sensor and IR sensor) with a mini fan, LED, Servo, LCD 16x2 connecting to Yolo:Bit as Sensor node
- Sensor node uses Wifi and MQTT protocol to connect to Adafruit Server for sending and receiving data
- Python GateWay connects and sends data to database on Firebase

Details of all functions of this system are in the report

Report: [hsmarthome_project](https://github.com/huyhoang167/HSmartHome/files/11423433/DADN_222.pdf)

Slide and video demo for presentation: [Slide](https://www.canva.com/design/DAFhOgqgBv0/4waK5KRYRIVv9Qtve2bYsw/edit?utm_content=DAFhOgqgBv0&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)


