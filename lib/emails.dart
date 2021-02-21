import 'dart:math';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flip_card/flip_card.dart';
import './colors.dart';

class EmailScreen extends StatefulWidget {
  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => print('pressed'),
          child: Icon(
            Icons.edit_outlined,
            color: Colors.red[800],
            size: 30,
          ),
        ),
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemBuilder: (context, index) => Email(index),
          itemCount: 24,
        ),

        // CustomScrollView(
        //   slivers: [
        //     // SliverPersistentHeader(
        //     //   floating: true,
        //     //   delegate: MySliverAppBar(expandedHeight: 60),
        //     // ),
        //     SliverList(
        //       delegate: SliverChildBuilderDelegate(
        //         (context, index) => Email(),
        //         childCount: 20,
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 70,
      width: 100,
      padding: EdgeInsets.all(10),
      color: Colors.black,
      child: Text('Custom app bar'),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class Email extends StatefulWidget {
  final int hour;

  const Email(this.hour, {Key key}) : super(key: key);
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  bool isFavorite = false;
  bool isSelected = false;
  String minutes = '${Random().nextInt(6)}${Random().nextInt(10)}';
  final color = random.element(colors);
  final info = {
    'name': faker.person.name(),
    'subject': faker.conference.name(),
    'message': faker.lorem.sentences(2).toString(),
  };

  FontWeight fontWeight = Random().nextInt(2) >= 1 ? FontWeight.bold : FontWeight.normal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (fontWeight == FontWeight.bold) {
            fontWeight = FontWeight.normal;
            return;
          }
          fontWeight = FontWeight.bold;
        });
      },
      //TODO ON LONG PRESS START
      onLongPress: () => setState(() => isSelected = !isSelected),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[100] : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.only(left: 4, top: 1, bottom: 1),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlipCard(
              onFlip: () => setState(() => isSelected = !isSelected),
              front: CircleAvatar(
                backgroundColor: color,
                child: Text(
                  info['name'][0],
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              back: CircleAvatar(
                backgroundColor: Colors.blue[900],
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          info['name'],
                          style: TextStyle(fontWeight: fontWeight, fontSize: 18),
                        ),
                      ),
                      Text(
                        '${widget.hour}:$minutes',
                        style: TextStyle(fontWeight: fontWeight),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      info['subject'],
                      style: TextStyle(fontWeight: fontWeight),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          info['message'],
                          //maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => isFavorite = !isFavorite),
                        child: isFavorite ? Icon(Icons.star, color: Colors.yellow[700]) : const Icon(Icons.star_border),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
