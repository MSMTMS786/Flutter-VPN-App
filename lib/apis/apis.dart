import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/helpers/my_dialogs.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/vpn.dart';
class APIs{
  static Future<List<Vpn>>getVPNServers()async {
    final List<Vpn>vpnList=[];
    try {
  final res=await get(Uri.parse("https://www.vpngate.net/api/iphone/"));
  // CSV To List
  final csvtoString=res.body.split("#")[1].replaceAll("*","");
  List<List<dynamic>> list = const CsvToListConverter().convert(csvtoString);
  final header=list[0];
  for(int i=1;i<list.length ;i++){
       Map<String, dynamic> temJson={};
      for(int j=0;j<header.length ;j++){
        temJson.addAll({header[j].toString():list[i][j]});
  }
      vpnList.add(Vpn.fromJson(temJson));
  }
  print(vpnList.first.hostname);
} catch (e) {
  MyDialogs.error(msg: "Error in getting VPN Server");
  print("\ngetVPNServers: $e");
}
vpnList.shuffle();
if(vpnList.isNotEmpty){
  Pref.vpnList=vpnList;
}
return vpnList;
  }

  static Future<void>getIPDetails({required Rx<IPDetails>ipData})async {
   
    try {
  final res=await get(Uri.parse("http://ip-api.com/json/"));
  // CSV To List
  final data=jsonDecode(res.body);
  print(data);
  ipData.value=IPDetails.fromJson(data);

} catch (e) {
  MyDialogs.error(msg: e.toString());
  print("\ngetIPDetailsE: $e");}
  }
}