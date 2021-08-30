import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  final Object options;
  const FilterPage({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            options.toString(),
            style: TextStyle(color: Colors.grey, fontSize: 40.0),
          ),
        ),
      ),
    );
  }
}
