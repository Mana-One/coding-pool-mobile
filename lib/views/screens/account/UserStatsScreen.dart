import 'package:coding_pool_v0/models/UserStats.dart';
import 'package:flutter/material.dart';

class UserStatsScreen extends StatefulWidget {
  const UserStatsScreen({Key? key, required this.userStats}) : super(key: key);

  final UserStats userStats;

  @override
  State<UserStatsScreen> createState() => _UserStatsScreenState(this.userStats);
}

class _UserStatsScreenState extends State<UserStatsScreen> {

  final UserStats userStats;
  _UserStatsScreenState(this.userStats);

  @override
  Widget build(BuildContext context) {

    print('user stats screen');

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
                Text(userStats.username, style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Text('Followers : ', style: TextStyle(color: Colors.blue.shade900, fontSize: 25, fontWeight: FontWeight.w500)),
                    Text(this.userStats.followers.toString(), style: TextStyle(color: Colors.orange.shade900, fontSize: 25, fontWeight: FontWeight.w500),)
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Text('Following : ', style: TextStyle(color: Colors.blue.shade900, fontSize: 25, fontWeight: FontWeight.w500),),
                    Text(this.userStats.following.toString(), style: TextStyle(color: Colors.orange.shade900, fontSize: 25, fontWeight: FontWeight.w500),)
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Text('Programs : ', style: TextStyle(color: Colors.blue.shade900, fontSize: 25, fontWeight: FontWeight.w500),),
                    Text(this.userStats.programs.toString(), style: TextStyle(color: Colors.orange.shade900, fontSize: 25, fontWeight: FontWeight.w500),)
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Text('Competitions entered : ', style: TextStyle(color: Colors.blue.shade900, fontSize: 25, fontWeight: FontWeight.w500),),
                    Text(this.userStats.competitions_entered.toString(), style: TextStyle(color: Colors.orange.shade900, fontSize: 25, fontWeight: FontWeight.w500),)
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Text('Competitions won : ', style: TextStyle(color: Colors.blue.shade900, fontSize: 25, fontWeight: FontWeight.w500),),
                    Text(this.userStats.competitions_won.toString(), style: TextStyle(color: Colors.orange.shade900, fontSize: 25, fontWeight: FontWeight.w500),)
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Text('Member since : ', style: TextStyle(color: Colors.blue.shade900, fontSize: 25, fontWeight: FontWeight.w500),),
                    Text(this.userStats.memberSince.substring(0,10), style: TextStyle(color: Colors.orange.shade900, fontSize: 25, fontWeight: FontWeight.w500),)
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}