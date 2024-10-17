
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/apis/apis.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/network_data.dart';
import 'package:vpn_basic_project/widgets/network_card.dart';

class NetworkTestScreen extends StatelessWidget {
 


  @override
  Widget build(BuildContext context) {
     final ipData=IPDetails.fromJson({}).obs;
     APIs.getIPDetails(ipData: ipData);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(137, 22, 21, 21)
            : Color.fromARGB(255, 100, 146, 148),
        iconTheme: IconThemeData(
            color:  Colors.white, // Change the color here
        ),
        title: Text('Network Test',style: TextStyle(color: Colors.white),),
      ),
     floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10.0,right: 5.0),
          child: FloatingActionButton(
            onPressed: (){
               ipData.value=IPDetails.fromJson({});
               APIs.getIPDetails(ipData: ipData);
            },
            child: Icon(
              CupertinoIcons.refresh,
              color:Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(137, 22, 21, 21)
            : Colors.white,
            ),
           backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 218, 205, 205)
            : Color.fromARGB(255, 100, 146, 148),
          ),
        ),


      body: Obx(() => 
      ListView(
          padding: EdgeInsets.only(top: mq.width*.04,bottom: mq.width*.04,left: mq.width*.015,right: mq.width*.015) ,
          physics: BouncingScrollPhysics(),
          children: [
            NetworkCard(
              data: NetworkData(
                title:"IP Address",
                subtitle:ipData.value.query,
                icon: Icon(CupertinoIcons.location_solid,color: Color(0Xff005a7d),),
                ),
                ),
             NetworkCard(
              data: NetworkData(
                title:"Internet Provider",
                subtitle:ipData.value.isp,
                icon: Icon(Icons.business,color: Colors.orange,),
                ),
                ),
             NetworkCard(
              data: NetworkData(
                title:"Location",
                subtitle:ipData.value.country.isEmpty?"Fetching . . ."
                :"${ipData.value.city}, ${ipData.value.regionName}, ${ipData.value.country}",
                icon: Icon(CupertinoIcons.location,color: Colors.pink,),
                ),
                ),   
             NetworkCard(
              data: NetworkData(
                title:"Pin-code",
                subtitle:ipData.value.zip,
                icon: Icon(CupertinoIcons.location_solid,color: Color(0Xff005a7d),),
                ),
                ),
             NetworkCard(
              data: NetworkData(
                title:"Time Zone",
                subtitle:ipData.value.timezone,
                icon: Icon(CupertinoIcons.time,color: Colors.green,),
                ),
                )
          ],
        ),
      ),
    );
  }
}