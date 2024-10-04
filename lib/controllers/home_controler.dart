import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:vpn_basic_project/helpers/my_dialogs.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/models/vpn_config.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';
class HomeController extends GetxController{
  final Rx<Vpn> vpn=Pref.vpn.obs ;
  final vpnState = VpnEngine.vpnDisconnected.obs;
    void connectToVpn() {
    if(vpn.value.openVPNConfigDataBase64.isEmpty)
      {
        MyDialogs.warning(msg: "Select a VPN server first");
        return;
        };
    if ( vpnState.value == VpnEngine.vpnDisconnected) {
     final data = Base64Codec().decode(vpn.value.openVPNConfigDataBase64);   
     final config=Utf8Codec().decode(data);
     final vpnConfig=VpnConfig(
      country:vpn.value.countryLong,
      username: "vpn",
      password: "vpn",
      config: config,
      );   
      ///Start if stage is disconnected
      VpnEngine.startVpn(vpnConfig);
      // startTimer.value=true;
    } else {
      ///Stop if stage is "not" disconnected
      // startTimer.value=false;
      VpnEngine.stopVpn();
    }
  }
  Color get getButtonColor{
    switch(vpnState.value){
      case VpnEngine.vpnConnected:
        return Color.fromARGB(255, 12, 82, 35);
      case VpnEngine.vpnDisconnected:
        return Color.fromARGB(255, 75, 21, 25);
      default:
        return Colors.grey;
    }
  }
  String get getButtonText{
    switch(vpnState.value){
      case VpnEngine.vpnConnected:
        return "Disconnect";
      case VpnEngine.vpnDisconnected:
        return "Connect";
      default:
        return "Connecting...";
    }
  }

}