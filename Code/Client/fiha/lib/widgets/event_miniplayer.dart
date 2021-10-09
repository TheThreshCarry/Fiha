import 'dart:ui';

import 'package:fiha/main.dart';
import 'package:fiha/modals/Event.dart';
import 'package:fiha/screens/eventPage.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';

class EventMiniPlayer extends StatefulWidget {
  final Event event;
  EventMiniPlayer({Key? key, required this.event}) : super(key: key);

  @override
  _EventMiniPlayerState createState() => _EventMiniPlayerState();
}

class _EventMiniPlayerState extends State<EventMiniPlayer> {
  @override
  Widget build(BuildContext context) {
    MiniplayerController controller = MiniplayerController();
    return Miniplayer(
        minHeight: 80.0,
        maxHeight: MediaQuery.of(context).size.height,
        controller: controller,
        /* onDismissed: () {
          providerContainer.read(selectedEventProvider).state = null;
        },*/
        builder: (h, p) {
          if (h < 80) {
            providerContainer.read(selectedEventProvider).state = null;
            return SizedBox();
          }
          if (p < 0.3) {
            return SizedBox(
              child: Container(
                height: h,
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(70, 200, 200, 200),
                child: Row(
                  children: [
                    Container(
                      height: 80.0,
                      width: 80.0,
                      padding: EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.event.imgs[0]),
                      ),
                    ),
                    Container(
                      height: h,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.event.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[900]),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            widget.event.description,
                            style: TextStyle(color: Colors.grey, fontSize: 8),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              launchURL(widget.event);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.05,
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
                                    size: MediaQuery.of(context).size.height *
                                        0.015,
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  Text(
                                    "Appeler",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.015,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFF1FAEE)),
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return EventPage(event: widget.event);
          }
        });
  }
}
