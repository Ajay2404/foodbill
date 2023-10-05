import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(MaterialApp(
    home: Menu(),
  ));
}

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _billState();
}

class _billState extends State<Menu> {
  List img = [
    'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80',
    'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1773&q=80',
    'https://greenbowl2soul.com/wp-content/uploads/2020/03/Veg-Manchurian-recipe.jpg',
    'https://images.pexels.com/photos/5560763/pexels-photo-5560763.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.lifestyleasia.com/wp-content/uploads/sites/7/2022/02/01171421/YFL-Pav-Bhaji-2.jpg?tr=w-1600',
    'https://as2.ftcdn.net/v2/jpg/01/77/40/41/1000_F_177404119_oH2uSPYmTqPqTfGNHJUEO7c7j4oHDghr.jpg',
    'https://static6.depositphotos.com/1039098/566/i/600/depositphotos_5661959-stock-photo-vegetarian-sizzler.jpg',
    'https://static.toiimg.com/thumb/79782927.cms?width=680&height=512&imgsize=258975',
  ];
  List price = [
    "70",
    "130",
    "170",
    "110",
    "150",
    "99",
    "530",
    "210",
  ];
  List name = [
    "Burger",
    "Sandwich",
    "Manchurian",
    "Dosa",
    "Pav Bhaji",
    "Garlic Bread",
    "Sizzler",
    "Pizza",
  ];

  // List burger = [
  //   "Aloo Tikki Burger",
  //   "Mexican Aloo Tikki Burger",
  //   "Triple Cheese Veg Burger",
  //   "Corn & Cheese Burger",
  //   "Cheese Burger",
  //   "Triple Cheese Veg Burger",
  //   "Premium Veg Burger",
  //   "Aloo Tikki + Fries",
  // ];
  List<dynamic> name1 = [
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
  ];
  List<String> itemss = [
    "1",
    "2",
    "3",
    "4",
    "5",
  ];
  List click = [false, false, false, false, false, false, false, false];
  String gender = '';
  int gender1 = 0;
  double Total = 0;
  List prices = [];
  String currentItem = "";
  double discount = 0;

  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? Bytes;

  @override
  void initState() {
    currentItem = itemss[0];
    super.initState();
    setState(() {
      permission();
      createFolder();
      deviceinfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Invoice Bill"),
      ),
      body: WidgetsToImage(
        controller: controller,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Enter Your Name",
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black),
                      )),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Text('Female'),
                          Radio(
                            value: 'female',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                                if (gender == "female") {
                                  gender1 = 10;
                                } else {
                                  gender1 = 5;
                                }
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Text('Male'),
                          Radio(
                            value: 'male',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                                if (gender == "male") {
                                  gender1 = 5;
                                } else {
                                  gender1 = 10;
                                }
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: name.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            // child: Image.network(
                            //   img[index],
                            //   height: 100,
                            //   width: 100,
                            // ),
                            ),
                        Text(name[index]),
                        Text(price[index]),
                        DropdownButton(
                          value: name1[index],
                          items: itemss
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              name1[index] = value.toString();
                            });
                          },
                        ),
                        Checkbox(
                          value: click[index],
                          onChanged: (value) {
                            setState(() {
                              click[index] = value!;
                            });
                            if (click[index] != null) {
                              click[index] = value;
                            }
                            double sum = double.parse(price[index]);
                            if (click[index] == true) {
                              Total = Total + (sum * int.parse(name1[index]));
                              price.add;
                            } else {
                              price.remove;
                              Total = Total - (sum * int.parse(name1[index]));
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      controller.capture().then((imageBytes) async {
                        DateTime mm = DateTime.now();
                        String imagename =
                            "IMAGE${mm.day}${mm.month}${mm.year}${mm.hour}${mm.minute}";
                        File file = File('$filepath/$imagename.jpg');
                        List<int> bytes = imageBytes as List<int>;
                        file.writeAsBytes(bytes);
                        await file.create();
                        Share.shareFiles(['${file.path}']);
                      });
                    },
                    icon: Icon(Icons.share),
                  ),
                  Text(
                    "Order Total:  ₹${Total}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Discount:  ₹${discount = Total * gender1 / 100}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pay Amount:  ₹${Total - discount}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  permission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
    } else {
      await Permission.storage.request();
    }
  }

  String filepath = '';

  createFolder() async {
    final folderName = "FoodMenu";
    final path = Directory("storage/emulated/0/Pictures/$folderName");
    if (await path.exists()) {
    } else {
      await path.create();
    }
    filepath = path.path;
  }

  deviceinfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo info = await deviceInfo.androidInfo;
  }
}
