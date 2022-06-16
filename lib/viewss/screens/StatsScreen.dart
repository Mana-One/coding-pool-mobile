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
          body: Center(
            child: Column(
              children: [
                Text('Name', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Text('Followers : ', style: TextStyle(color: Colors.blue.shade900, fontSize: 25, fontWeight: FontWeight.w500)),
                    Text('0', style: TextStyle(color: Colors.orange.shade900, fontSize: 25, fontWeight: FontWeight.w500),)
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Text('Following : ', style: TextStyle(color: Colors.blue.shade900, fontSize: 25, fontWeight: FontWeight.w500),),
                    Text('0', style: TextStyle(color: Colors.orange.shade900, fontSize: 25, fontWeight: FontWeight.w500),)
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Text('Programs : ', style: TextStyle(color: Colors.blue.shade900, fontSize: 25, fontWeight: FontWeight.w500),),
                    Text('0', style: TextStyle(color: Colors.orange.shade900, fontSize: 25, fontWeight: FontWeight.w500),)
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Text('Competitions entered : ', style: TextStyle(color: Colors.blue.shade900, fontSize: 25, fontWeight: FontWeight.w500),),
                    Text('0', style: TextStyle(color: Colors.orange.shade900, fontSize: 25, fontWeight: FontWeight.w500),)
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Text('Competitions won : ', style: TextStyle(color: Colors.blue.shade900, fontSize: 25, fontWeight: FontWeight.w500),),
                    Text('0', style: TextStyle(color: Colors.orange.shade900, fontSize: 25, fontWeight: FontWeight.w500),)
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Text('Member since : ', style: TextStyle(color: Colors.blue.shade900, fontSize: 25, fontWeight: FontWeight.w500),),
                    Text('0', style: TextStyle(color: Colors.orange.shade900, fontSize: 25, fontWeight: FontWeight.w500),)
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
