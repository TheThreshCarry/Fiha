import 'package:fiha/modals/Filter.dart';
import 'package:fiha/screens/eventPage.dart';
import 'package:fiha/services/dataHandeler.dart';
import 'package:flutter/material.dart';

import 'package:fiha/modals/Event.dart';

final filterResult = ValueNotifier<List<Event>>([]);
void getFilterResults(List<Event> results) {
  filterResult.value = results;
}

final Map<int, String> intToCategory = {
  0: "Music",
  1: "Sport",
  2: "Culture",
};

class FilterPage extends StatefulWidget {
  final Filter options;

  FilterPage({
    Key? key,
    required this.options,
  }) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Résultat Filtre"),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: ValueListenableBuilder(
              valueListenable: filterResult,
              builder:
                  (BuildContext context, List<Event> value, Widget? child) {
                if (value.isNotEmpty) {
                  return EventColumn(events: value);
                } else {
                  return Center(
                    child: Text(
                      "Pas De Résultat...",
                      style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 20.0,
                          color: Colors.grey[400]),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class EventColumn extends StatelessWidget {
  final List<Event> events;
  const EventColumn({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: events
          .map(
            (e) => Column(
              children: [EventCard(event: e), SizedBox(height: 20.0)],
            ),
          )
          .toList(),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EventPage(event: event)));
      },
      child: Container(
        height: 100.0,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(color: Colors.red, width: 2.0)),
              child: CircleAvatar(
                backgroundImage: NetworkImage(event.imgs[0]),
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    event.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height * 0.020),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    intToCategory[1]! + " / " + getDateString(event),
                    style: TextStyle(
                        color: Color.fromARGB(255, 175, 175, 175),
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.height * 0.010),
                  ),
                  Text(
                    event.description,
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width * 0.55 - 150,
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Text(
                    "${event.price == 0 ? "Gratuit" : event.price.toStringAsFixed(0) + " DA"}",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        color: Colors.grey[600]),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      launchURL(event);
                    },
                    child: Container(
                      height: 30.0,
                      width: 90.0,
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
                            size: MediaQuery.of(context).size.height * 0.020,
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            "Call",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.020,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF1FAEE)),
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getDateString(Event event) {
    if (event.endDate != null) {
      return "Du : " +
          event.startDate.toDate().toString().substring(0, 10) +
          " Au " +
          event.endDate!.toDate().toString().substring(0, 10);
    } else {
      return event.startDate.toDate().toString().substring(0, 10);
    }
  }
}
