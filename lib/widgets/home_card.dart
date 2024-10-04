import 'package:flutter/material.dart';
// import 'package:get/get_utils/get_utils.dart';
import 'package:vpn_basic_project/main.dart';
// Card to represent status of home screen
// ignore: must_be_immutable
class HomeCard extends StatelessWidget {
  final String title, subtitle, onTap;
  Widget icon;
  HomeCard(
      {required this.title,
      required this.subtitle,
      required this.onTap,
      required this.icon});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mq.width * 0.4,
      child: Column(
        children: [
          icon,
          SizedBox(height: 5,),
          Text(title),
          SizedBox(height: 3,),
          Text(
            subtitle,
            style:TextStyle(
              color: Theme.of(context).lightText,
              ) ,
            ),
        ],
      ));
  }
}