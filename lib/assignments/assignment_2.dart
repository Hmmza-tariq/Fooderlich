import 'package:flutter/material.dart';

class Assignment2 extends StatefulWidget {
  const Assignment2({super.key});

  @override
  State<Assignment2> createState() => _Assignment2State();
}

class _Assignment2State extends State<Assignment2> {
  ScrollPhysics selectedPhysics = const AlwaysScrollableScrollPhysics();
  String selectedPhysicsName = 'AlwaysScrollableScrollPhysics';

  final Map<String, ScrollPhysics> physicsOptions = {
    'AlwaysScrollableScrollPhysics': const AlwaysScrollableScrollPhysics(),
    'BouncingScrollPhysics': const BouncingScrollPhysics(),
    'ClampingScrollPhysics': const ClampingScrollPhysics(),
    'FixedExtentScrollPhysics': const FixedExtentScrollPhysics(),
    'NeverScrollableScrollPhysics': const NeverScrollableScrollPhysics(),
    'PageScrollPhysics': const PageScrollPhysics(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView Physics Assignment'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text('Select Physics: '),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: selectedPhysicsName,
                    items: physicsOptions.keys
                        .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPhysicsName = value!;
                        selectedPhysics = physicsOptions[value]!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey),
                    ),
                child: ListView.builder(
                  physics: selectedPhysics,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      color: index % 3 == 0
                          ? Colors.red
                          : index % 3 == 1
                              ? Colors.green
                              : Colors.blue,
                      child: ListTile(
                        title: Text('Item $index',
                            style: const TextStyle(color: Colors.white)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
