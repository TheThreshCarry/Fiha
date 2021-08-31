import 'package:fiha/modals/Filter.dart';
import 'package:fiha/screens/eventPage.dart';
import 'package:fiha/services/dataHandeler.dart';
import 'package:flutter/material.dart';

import 'package:fiha/modals/Event.dart';

final filterResult = ValueNotifier<List<Event>>([]);
void getFilterResults(List<Event> results) {
  filterResult.value = results;
}

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
          child: SingleChildScrollView(
            child: ValueListenableBuilder(
              valueListenable: filterResult,
              builder:
                  (BuildContext context, List<Event> value, Widget? child) {
                return EventColumn(events: value);
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
              width: MediaQuery.of(context).size.width * 0.5,
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
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    event.description,
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 10.0,
                        color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
