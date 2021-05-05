import 'package:flutter/material.dart';
import 'package:flutter_animation_floating_button/widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CfloatingButton(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              child: Icon(
                Icons.home,
                size: 30.0,
                color: Colors.white,
              ),
              onPressed: () => print('taylan'),
              actions: [
                ActionIcon(
                  icon: Icons.person,
                  onPressed: () => print('first action'),
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                ),
                ActionIcon(
                  icon: Icons.settings,
                  onPressed: () => print('second action'),
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.orange,
                ),
                ActionIcon(
                  icon: Icons.cached,
                  onPressed: () => print('third action'),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
