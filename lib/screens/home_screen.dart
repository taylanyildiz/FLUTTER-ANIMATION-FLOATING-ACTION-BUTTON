import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController controllerIcon;
  Animation<double> opacity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerIcon = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    opacity = Tween<double>(begin: 0.0, end: 0.7)
        .animate(CurvedAnimation(parent: controllerIcon, curve: Curves.linear));
    opacity.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        Center(
          child: Container(
            height: 200.0,
            width: 400.0,
            color: Colors.black.withOpacity(.6),
            child: Center(
              child: Text(
                'HEY THERE',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: opacity,
          child: Container(
            color: Colors.white,
          ),
        ),
      ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
              animation: controllerIcon,
              builder: (context, child) {
                return Transform.scale(
                  scale: Tween<double>(begin: 0.0, end: 1.0)
                      .animate(CurvedAnimation(
                          parent: controllerIcon, curve: Curves.elasticOut))
                      .value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 50,
                        child: Center(
                            child: Text(
                          'Eat something',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      SizedBox(width: 6.0),
                      FloatingActionButton(
                        backgroundColor: Colors.white,
                        clipBehavior: Clip.antiAlias,
                        onPressed: () {},
                        child: Icon(
                          Icons.east,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              }),
          SizedBox(height: 6.0),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                size: 30.0,
                progress: controllerIcon,
              ),
              onPressed: () {
                if (controllerIcon.isCompleted) {
                  controllerIcon.reverse();
                } else {
                  controllerIcon.forward();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
