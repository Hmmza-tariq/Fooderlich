import 'package:flutter/material.dart';

class Assignment extends StatefulWidget {
  const Assignment({super.key});

  @override
  State<Assignment> createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  CrossAxisAlignment selectedAlignment = CrossAxisAlignment.start;
  MainAxisAlignment selectedMainAxisAlignment = MainAxisAlignment.start;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Text('MainAxisAlignment:'),
                DropdownButton<MainAxisAlignment>(
                  value: selectedMainAxisAlignment,
                  items: MainAxisAlignment.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMainAxisAlignment = value!;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('CrossAxisAlignment:'),
                DropdownButton<CrossAxisAlignment>(
                  value: selectedAlignment,
                  items: CrossAxisAlignment.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedAlignment = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: selectedAlignment,
                mainAxisAlignment: selectedMainAxisAlignment,
                textBaseline: selectedAlignment == CrossAxisAlignment.baseline
                    ? TextBaseline.alphabetic
                    : null,
                children: [
                  Container(
                    color: Colors.red,
                    height: 100,
                    width: 100,
                  ),
                  Container(
                    color: Colors.green,
                    height: 100,
                    width: 100,
                  ),
                  Container(
                    color: Colors.blue,
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
