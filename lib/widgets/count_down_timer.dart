import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  final bool startTimer;
  CountDownTimer({required this.startTimer});
  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Duration _duration=Duration();
  Timer? _timer;

_startTimer(){
  _timer=Timer.periodic(Duration(seconds: 1), (timer) { 
    setState(() {
      _duration=Duration(seconds: _duration.inSeconds+1);
    });
  });
}

_stopTimer(){
  setState(() {
  _timer?.cancel();
  _timer=null;
  _duration=Duration();
  });
}


  @override
  Widget build(BuildContext context) {
   if(_timer==null || !widget.startTimer)
   widget.startTimer?_startTimer():_stopTimer();
    // if(widget.startTimer){
    //   _startTimer();
    // }else{
    //   _stopTimer();
    // }
   String twoDigits(int n)=>n.toString().padLeft(2,"0");
   final minutes=twoDigits(_duration.inMinutes.remainder(60));
   final seconds=twoDigits(_duration.inSeconds.remainder(60));
   final hours=twoDigits(_duration.inHours.remainder(60));

    return Text("$hours: $minutes: $seconds",style: TextStyle(fontSize: 50),);
  }
}