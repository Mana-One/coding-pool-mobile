import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.blue.shade900,),
                onPressed: () { Navigator.pop(context); }
            ),
          ),
          body: Column(
            children: [
              Text('Name'),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Text('data : '),
                  Text('details')
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Text('data : '),
                  Text('details')
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Text('data : '),
                  Text('details')
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Text('data : '),
                  Text('details')
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        )
    );
  }
}
