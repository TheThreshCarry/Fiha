import 'package:fiha/main.dart';
import 'package:fiha/modals/Event.dart';
import 'package:fiha/screens/filterPage.dart';
import 'package:fiha/services/iconsHandeler.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                    height: size.height * 0.35,
                    width: double.infinity,
                    color: Colors.black,
                    child: CarouselSlider(
                      items: event.imgs
                          .map((e) => Image.network(
                                e,
                                fit: BoxFit.cover,
                                width: size.width,
                              ))
                          .toList(),
                      options: CarouselOptions(
                          height: size.height * 0.35,
                          enableInfiniteScroll: false,
                          viewportFraction: 1.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 5),
                          autoPlayCurve: Curves.easeIn,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 400)),
                    )),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.035),
                          ),
                          Text(
                            intToCategory[event.type]! +
                                " / " +
                                getDateString(event),
                            style: TextStyle(
                                color: Color.fromARGB(255, 175, 175, 175),
                                fontWeight: FontWeight.w300,
                                fontSize: size.height * 0.015),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            height: size.height * 0.4,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Container(
                                child: Text(
                                  event.description,
                                  style: TextStyle(
                                      //overflow: TextOverflow.ellipsis,
                                      fontSize: size.height * 0.025),
                                  //maxLines: 6,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
            //Bottom Row
            Positioned(
              bottom: 20.0,
              right: 0.0,
              left: 0.0,
              child: Row(
                children: [
                  Container(
                      width: size.width - 170,
                      height: 75.0,
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            event.price.toString() + "DA / Personnes",
                            style: TextStyle(
                                color: Color.fromRGBO(50, 50, 50, 1.0),
                                fontSize: size.height * 0.020),
                          ),
                          Text(
                            event.remainingPlaces.toString() +
                                "/" +
                                event.totalPlaces.toString() +
                                " Places Restantes",
                            style: TextStyle(
                                color: Color.fromRGBO(50, 50, 50, 1.0)),
                          ),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    height: 75.0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          launchURL(event);
                        },
                        child: Container(
                          width: 150.0,
                          height: 75.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFE63946),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(10, 10, 10, 240),
                                  blurRadius: 30.0,
                                  spreadRadius: 10.0)
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Color(0xFFF1FAEE),
                                size: size.height * 0.045,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Appeler",
                                style: TextStyle(
                                    fontSize: size.height * 0.025,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF1FAEE)),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /*Positioned(
                child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xFFF1FAEE),
              ),
              onPressed: () {
                //navigatorKey.currentState?.pop();
              },
            ))*/
          ],
        ),
      ),
    );
  }

  String getDateString(Event event) {
    if (event.endDate != null) {
      return "Du : " +
          event.startDate.toDate().toString().substring(0, 16) +
          " Au " +
          event.endDate!.toDate().toString().substring(0, 16);
    } else {
      return event.startDate.toDate().toString().substring(0, 16);
    }
  }
}

void launchURL(Event event) async => await canLaunch("tel:${event.phoneNumber}")
    ? await launch("tel:${event.phoneNumber}")
    : throw 'Could not launch tel:${event.phoneNumber}';
