import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn_basic_project/models/network_data.dart';
class NetworkCard extends StatelessWidget {
  final NetworkData data;
  NetworkCard({ required this.data});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
          onTap: (){}, 
          child: ListTile(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          leading:Icon(data.icon.icon,color: data.icon.color,size: data.icon.size??28,),
          title: Text(data.title),
          subtitle: Text(data.subtitle),

            ),
      
      )

    );
  }
}