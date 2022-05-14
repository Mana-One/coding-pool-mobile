import 'package:flutter/material.dart';

class UserStatsWidget extends StatefulWidget {
  const UserStatsWidget({Key? key}) : super(key: key);

  @override
  State<UserStatsWidget> createState() => _UserStatsWidgetState();
}

class _UserStatsWidgetState extends State<UserStatsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text('Programs'),
              Text('5')
            ],
          ),
          Row(
            children: [
              Text('Competition joined'),
              Text('2')
            ],
          ),
          Row(
            children: [
              Text('Competition won'),
              Text('1')
            ],
          ),
          
        ],
      ),
    );
  }
}

class ButtonShowStats extends StatefulWidget {
  const ButtonShowStats({Key? key}) : super(key: key);

  @override
  State<ButtonShowStats> createState() => _ButtonShowStatsState();
}

class _ButtonShowStatsState extends State<ButtonShowStats> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () =>
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Statistics'),
                  content: UserStatsWidget(),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
          ),
      child: const Text('Show Dialog'),
    );
  }
}

