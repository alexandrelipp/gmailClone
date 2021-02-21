import 'package:flutter/material.dart';
import './emails.dart';
import './meetScreen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  final _pages = [
    {
      'page': EmailScreen(),
      'title': 'Emails',
    },
    {
      'page': MeetScreen(),
      'title': 'Meets',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex]['page'] as Widget,
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 80,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (_currentIndex == 1) {
                    setState(() {
                      _currentIndex = 0;
                    });
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmailIcon(_currentIndex == 0 ? Colors.red[800] : Colors.grey),
                    Text(
                      'Email',
                      style: TextStyle(color: _currentIndex == 0 ? Colors.red[800] : Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (_currentIndex == 0) {
                  setState(() {
                    _currentIndex = 1;
                  });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.video_call,
                    color: _currentIndex == 1 ? Colors.red[800] : Colors.grey,
                  ),
                  Text(
                    'Meets',
                    style: TextStyle(color: _currentIndex == 1 ? Colors.red[800] : Colors.grey),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),

      //BottomNavigationBar(
      //   selectedItemColor: Colors.red[800],
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: EmailIcon(),
      //       label: 'Email',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.camera),
      //       label: 'Meet',
      //     ),
      //   ],
      // ),
    );
  }
}

class EmailIcon extends StatelessWidget {
  final Color color;
  const EmailIcon(this.color);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.email,
            color: color,
          ),
          Positioned(
            top: -8,
            left: 14,
            child: Container(
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red[800],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 1,
              ),
              child: const Text(
                '24',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
