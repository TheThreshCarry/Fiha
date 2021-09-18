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
        onDismissed: () {
          providerContainer.read(selectedEventProvider).state = null;
        },
        builder: (h, p) {
          if (p < 0.3) {
            return Container(
              height: h,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    height: 80.0,
                    width: 80.0,
                    padding: EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.event.imgs[0]),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Column(
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
                      ),
                      Text(
                        widget.event.description,
                        style: TextStyle(color: Colors.grey, fontSize: 8),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            controller.animateToHeight(state: PanelState.MAX);
            return EventPage(event: widget.event);
          }
        });
  }
}
