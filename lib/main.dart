import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
//import 'package:flutter/animation.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  late AnimationController _controller;
  late CurvedAnimation animation;
  @override
  void initState() {
    super.initState();
   animate();
  }
  
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  animate(){
    _controller = AnimationController(duration: Duration(seconds: 1),vsync: this );
     animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    //fore the move use this property
    animation.addListener(() {
      setState(() {

      });
     // print(_controller.value);
    });
    animation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setState(() {
          leftDiceNumber = Random().nextInt(6)+1;
          rightDiceNumber = Random().nextInt(6)+1;
        });
       // print("completed");
        _controller.reverse();
      }
    });
  }
  
  void roll(){
    _controller.forward();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        actions: [
          Container(
            height: 35,
            width: 35,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(CupertinoIcons.ellipsis_vertical,size: 23,color: Colors.black,),
          ),
        ],
        leading: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Icon(CupertinoIcons.left_chevron,size: 25,color: Colors.black45,),
        ),
        title: Text("Rolling Dice",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 27,
        ),),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(padding: 
        EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                        onTap: roll,
                          child: Image.asset("assets/images/dice-png-$leftDiceNumber.png",
                            height: 200- (animation.value)*100,
                          ))),
                  SizedBox(width: 10,),
                  Expanded(child: GestureDetector(
                    onTap: roll,
                      child: Image.asset("assets/images/dice-png-$rightDiceNumber.png",
                      height: 200- (animation.value)*100,
                      ))),
                ],
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: 300,
              height: 55,
              child: CupertinoButton(
                child: Text("Roll",style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),),
                onPressed: roll,
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
