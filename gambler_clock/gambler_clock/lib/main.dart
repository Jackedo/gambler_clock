import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gambler Clock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DigitalClock(),
    );
  }
}


class DigitalClock extends StatefulWidget {


  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {

  
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      // _timer = Timer(
      //   Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final hour =
        DateFormat('HH').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    
    return Stack(
      children: <Widget>[
        Center(
          child: Image.asset(
            'assets/background.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget> [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.12,
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(
                      24/360
                    ),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.01)
                        ..rotateY(0.152)
                        ..rotateX(-0.045)
                        ..rotateZ(-0.1),
                      alignment: FractionalOffset.center,
                      child: Text(
                        hour,
                        style: TextStyle(
                          fontFamily: "PressStart2P",
                          fontSize: 215,
                          color: Colors.yellow[100].withOpacity(0.92),
                          
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.085,
                    left: MediaQuery.of(context).size.width * 0.42,
                  ),
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(
                      30/360
                    ),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.01)
                        ..rotateY(0.12)
                        ..rotateX(-0.045)
                        ..rotateZ(-0.1),
                      alignment: FractionalOffset.center,
                      child: Text(
                        minute,
                        style: TextStyle(
                          fontFamily: "PressStart2P",
                          fontSize: 225,
                          color: Colors.yellow[100].withOpacity(0.92),
                          
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
