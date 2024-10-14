import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../widgets/health_card.dart';
import '../widgets/simple_background.dart';
import '../widgets/image_slider.dart'; // Thêm phần import widget mới
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Khởi tạo các biến observable
var nhietdo = "0".obs;
var nhiptim = "0".obs;
var spo2 = "0".obs;

// Đặt healthData sau khi các giá trị observable đã được khởi tạo
Map<String, dynamic> healthData = {
  'temperature': nhietdo.value,
  'heartRate': nhiptim.value,
  'spo2': spo2.value,
};

class _HomeScreenState extends State<HomeScreen> {
  var ref = FirebaseDatabase.instance.ref().child("sensor");

  // Hàm lấy dữ liệu từ Firebase
  getData() async {
    ref.onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.value != null) {
        Object? data = snapshot.value;
        Map<dynamic, dynamic> map = data as Map<dynamic, dynamic>;
        nhietdo.value = map["temperature"].toString();
        nhiptim.value = map["heartRate"].toString();
        spo2.value = map["spo2"].toString();
      }
    });
  }

  // Sửa lỗi dấu nháy trong danh sách myElementt
  List myElementt = [
    ["temperature", "true", nhietdo],
    ["heartRate", "true", nhiptim],
    ["spo2", "true", spo2],
  ];

  @override
  void initState() {
    super.initState();
    getData(); // Gọi hàm lấy dữ liệu khi khởi tạo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: SimpleBackground()), // Nền trắng đơn giản
          Column(
            children: [
              // Phần tiêu đề đặt trên cùng
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'CÁC CHỈ SỐ SỨC KHOẺ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Phần hiển thị hình ảnh với slider tự động, đặt ngay dưới tiêu đề
              Container(
                height: 200, // Chiều cao khung hình vuông
                width: double.infinity,
                child: ImageSlider(), // Slider hình ảnh chuyển động
              ),

              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => HealthCard(
                            title: 'Body Temperature',
                            value: '${nhietdo.value} °C',
                            icon: Icons.thermostat,
                            color: Colors.orange,
                          )),
                      Obx(() => HealthCard(
                            title: 'Heart Rate',
                            value: '${nhiptim.value} BPM',
                            icon: Icons.favorite,
                            color: Colors.redAccent,
                          )),
                      Obx(() => HealthCard(
                            title: 'SpO2 Level',
                            value: '${spo2.value} %',
                            icon: Icons.bloodtype,
                            color: const Color.fromARGB(255, 8, 207, 194),
                          )),
                    ],
                  ),
                ),
              ),

              // Phần chân trang
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Design by TKT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
