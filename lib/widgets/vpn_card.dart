import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controllers/home_controler.dart';
import 'package:vpn_basic_project/helpers/my_dialogs.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';
class VpnCard extends StatelessWidget {
  final Vpn vpn;
  VpnCard({ required this.vpn});
  @override
  Widget build(BuildContext context) {
    final controller=Get.find<HomeController>();
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(top: 8,bottom: 9.9),
          child: ListTile(
            onTap: (){
              controller.vpn.value=vpn;
              Pref.vpn=vpn;
              Get.back();
              MyDialogs.sucess(msg: "VPN server selected");
              if(controller.vpnState.value==VpnEngine.vpnConnected){
                VpnEngine.stopVpn();
                Future.delayed(Duration(seconds: 1),(){
                  controller.connectToVpn();
                });
              }
              else{
              controller.connectToVpn();
            }
            },
          
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          leading: Container(
            padding: EdgeInsets.all(.1),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12,),
              borderRadius: BorderRadius.circular(15),
              ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),

              child: Image.asset("assets/flags/${vpn.countryShort.toLowerCase()}.png",
              fit: BoxFit.cover,
              height:mq.height*.20,
              width: mq.width*.20,
              ),
              ),
              ),
            title: Text(vpn.countryLong),
            subtitle: Row(
              children: [
              Icon(Icons.speed_rounded,size: 20,), 
              SizedBox(width: 5,),
              Text(_formatBytes(vpn.speed, 2)),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(vpn.numVpnSessions.toString()),
                 SizedBox(width: 5,),
                Icon(CupertinoIcons.person_3_fill,size: 20,), 
              ],
            ),
            ),
        ),
      )

    );
  }
   String  _formatBytes(int bytes, int decimals) {
      if (bytes <= 0) return "0 B";
      const suffixes = ["Bps", "Kbps", "Mbps", "Gbps", "Tbps"];
      var i = (log(bytes) / log(1024)).floor();
      return  "${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}"; 
    }
}