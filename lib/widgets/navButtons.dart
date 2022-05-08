import 'package:flutter/material.dart';

class BottomNavButtons extends StatelessWidget {
  final Function nextPage;
  final Function prevPage;
  final double maxPages;
  const BottomNavButtons(
      {Key? key,
      required this.nextPage,
      required this.prevPage,
      required this.maxPages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          height: 30,
          color: Colors.blueAccent,
          child: TextButton(
              child: const Text(
                'Prev',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                prevPage();
              }),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          height: 30,
          color: Colors.blueAccent,
          child: TextButton(
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                nextPage(maxPages);
              }),
        )
      ],
    );
  }
}
