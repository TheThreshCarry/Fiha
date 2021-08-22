import 'package:fiha/main.dart';
import 'package:fiha/modals/Event.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Map<int, String> intToCategory = {
      0: "Music",
      1: "Sport",
      2: "Culture",
    };

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: size.height * 0.35,
                    width: double.infinity,
                    color: Colors.red,
                  ),
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
                                  fontWeight: FontWeight.bold, fontSize: 24.0),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              intToCategory[1]!,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 35, 35, 35),
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                              height: size.height * 0.4,
                              width: double.infinity,
                              child: Text(
                                event.description,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 20.0),
                                maxLines: 6,
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
              Positioned(
                bottom: 20.0,
                right: 0.0,
                left: 0.0,
                child: Container(
                  height: 75.0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _launchURL(event);
                      },
                      child: Container(
                        width: 200.0,
                        height: 75.0,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(10, 10, 10, 240),
                                blurRadius: 30.0,
                                spreadRadius: 10.0)
                          ],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                            child: Text(
                          "Call",
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  navigatorKey.currentState?.pop();
                },
              ))
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(Event event) async =>
      await canLaunch("tel:${event.phoneNumber}")
          ? await launch("tel:${event.phoneNumber}")
          : throw 'Could not launch tel:${event.phoneNumber}';
}
