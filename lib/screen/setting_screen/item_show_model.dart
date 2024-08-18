import 'package:flutter/material.dart';

class ItemShowModel extends StatelessWidget {
  const ItemShowModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              selectedTheme();
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Dark', style: Theme.of(context).textTheme.bodyLarge),
                  const Icon(Icons.check),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              selectedTheme();
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Light', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectedTheme() {}
}
