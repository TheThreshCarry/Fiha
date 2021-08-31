import 'dart:ui';
import 'package:fiha/main.dart';
import 'package:fiha/modals/Filter.dart';
import 'package:fiha/screens/filterPage.dart';
import 'package:fiha/services/dataHandeler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';

class GlassDrawer extends StatefulWidget {
  GlassDrawer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _GlassDrawerState createState() => _GlassDrawerState();
}

class _GlassDrawerState extends State<GlassDrawer> {
  DateTime startDate = new DateTime.now();

  DateTime? endDate;

  double radius = 20;

  int minPrice = 0;

  double maxPrice = 5000;

  double price = 1000;

  String category = "Musique";
  String inputText = '';

  void setRadius(double radius) {
    radius = radius;
  }

  void setCategory(int category) {
    category = category;
  }

  void setPrice(int minPrice, int maxPrice) {
    minPrice = minPrice;
    maxPrice = maxPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height,
      width: widget.size.width * 0.6,
      decoration: BoxDecoration(
        color: Color.fromARGB(70, 200, 200, 200),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0)),
        boxShadow: [],
      ),
      child: Stack(
        children: [
          SizedBox(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                    boxShadow: [],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40.0,
                  width: widget.size.width * 0.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFFF1FAEE)),
                  child: Row(
                    children: [
                      Container(
                        width: widget.size.width * 0.5 - 20,
                        padding: EdgeInsets.only(left: 10.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search For An Event...",
                            filled: false,
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            inputText = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),

                //Filter Text
                Container(
                  width: widget.size.width * 0.6,
                  child: Text(
                    "Filtres",
                    style: TextStyle(
                        fontSize: 34.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF1FAEE)),
                  ),
                ),

                //Date Filters
                Container(
                  width: widget.size.width * 0.6,
                  child: Text(
                    "Date",
                    style: TextStyle(
                        fontSize: 26.0,
                        //fontWeight: FontWeight.w700,
                        color: Color(0xFFF1FAEE)),
                  ),
                ),
                Container(
                  height: 130.0,
                  width: widget.size.width * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ChoosingPad(
                              text: "Début",
                              onTapFunc: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime: DateTime(2025, 6, 7),
                                    onConfirm: (date) {
                                  startDate = date;
                                  setState(() {});
                                  print(date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.fr);
                              }),
                          startDate != null
                              ? Text(
                                  startDate.toString().substring(0, 10),
                                  style: TextStyle(color: Color(0xFFF1FAEE)),
                                )
                              : SizedBox(),
                        ],
                      ),
                      Column(
                        children: [
                          ChoosingPad(
                              text: "Fin",
                              onTapFunc: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime: DateTime(2025, 6, 7),
                                    onConfirm: (date) {
                                  endDate = date;
                                  print(endDate);
                                  setState(() {});
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.fr);
                              }),
                          endDate != null
                              ? Text(
                                  endDate.toString().substring(0, 10),
                                  style: TextStyle(color: Color(0xFFF1FAEE)),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
                //Price Slider
                Container(
                    height: widget.size.height * 0.15,
                    width: widget.size.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Prix",
                          style: TextStyle(
                              color: Color(0xFFF1FAEE), fontSize: 26.0),
                        ),
                        Text(
                          "Prix Selectioné : ${price.toStringAsFixed(0)} DA",
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xFFF1FAEE)),
                        ),
                        Container(
                          child: Stack(
                            children: [
                              Positioned(
                                top: 30.0,
                                child: Text(
                                  "Gratuit",
                                  style: TextStyle(
                                      fontSize: 10.0, color: Color(0xFFF1FAEE)),
                                ),
                              ),
                              Positioned(
                                top: 30.0,
                                right: 10.0,
                                child: Text(
                                  "5000 DA",
                                  style: TextStyle(
                                      fontSize: 10.0, color: Color(0xFFF1FAEE)),
                                ),
                              ),
                              Slider(
                                value: price,
                                onChanged: (value) {
                                  setState(() {
                                    price = value;
                                  });
                                },
                                max: 5000.0,
                                min: 0.0,
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                //Category Chooser
                Container(
                  height: widget.size.height * 0.15,
                  width: widget.size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Catégorie",
                        style:
                            TextStyle(color: Color(0xFFF1FAEE), fontSize: 26.0),
                      ),
                      Container(
                          child: DropdownButton(
                        dropdownColor: Color(0xFF070c13),
                        onChanged: (value) {
                          setState(() {
                            category = value.toString();
                          });
                        },
                        value: category,
                        items: categories.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Row(
                              children: [
                                Container(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Image.asset(
                                    categoriesIcons[value]!,
                                  ),
                                ),
                                Text(
                                  value,
                                  style: TextStyle(color: Color(0xFFF1FAEE)),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                GestureDetector(
                  onTap: () {
                    double radius = 5000;
                    Filter options = Filter(startDate, endDate!, price,
                        category, radius, inputText);
                    DataHandeler().getFilterEvents(options);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FilterPage(options: options);
                    }));
                  },
                  child: Container(
                    height: 50.0,
                    width: widget.size.width * 0.5,
                    decoration: BoxDecoration(
                        color: Color(0xFFE63946),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Center(
                        child: Text(
                      "Filtrez",
                      style: TextStyle(
                          color: Color(0xFFF1FAEE),
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChoosingPad extends StatelessWidget {
  final String text;
  final Function onTapFunc;
  const ChoosingPad({Key? key, required this.text, required this.onTapFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapFunc();
      },
      child: Column(
        children: [
          Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), color: Colors.grey),
            child: Icon(
              Icons.calendar_today,
              size: 50.0,
              color: Color(0xFFF1FAEE),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            text,
            style: TextStyle(color: Color(0xFFF1FAEE)),
          )
        ],
      ),
    );
  }
}
