import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'About Us',
            style: TextStyle(
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.blue.shade900,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Who are we ?',
                  style: TextStyle(
                      color: Colors.deepOrange.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Text(
                    'A groupe of fellow students from the ESGI school, in class 4AL1, working on the annual project of Sir Raynal. The objective is to create a social network able to execute programs, with a "game" aspect that is up to the students !',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'The members !',
                  style: TextStyle(
                      color: Colors.deepOrange.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            'Paolo',
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: Image(
                                image:
                                    AssetImage('lib/assets/images/paolo.jpeg')),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 80,
                      child: Text(
                          'The back master of this elite team. He seems to never stop working, a dragon (or a monster some may say) among men. If you need something, just ask. He can do it quicker than Aladin\'s genius !',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            'Wissam',
                            style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: Image(
                                image: AssetImage(
                                    'lib/assets/images/wissam.jpeg')),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 80,
                      child: Text(
                          'The only girl of the group, seems like feminism has a long way to go, but she will surely show you how you can surf on our platform in mobile mode with an app ! Also she has skills as a designer.',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            'Redha',
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: Image(
                                image:
                                    AssetImage('lib/assets/images/redha.jpg')),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 80,
                      child: Text(
                          'The twisted guy in charge of the front part (the one writing these texts !). He said that he would "do his utmost for the front part", a sentence that sounds quite disturbing ...',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Where ?',
                  style: TextStyle(
                      color: Colors.deepOrange.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        'School : ',
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold),
                      ),
                      Text('ESGI, École Supérieure de Génie Informatique',
                          style: TextStyle(fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        'Address : ',
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold),
                      ),
                      Text('242 Rue du Faubourg Saint-Antoine, 75012 Paris',
                          style: TextStyle(fontWeight: FontWeight.w500))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
