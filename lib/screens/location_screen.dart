import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/controllers/location_controller.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/widgets/vpn_card.dart';
// ignore: must_be_immutable
class LocationScreen extends StatelessWidget {
  LocationScreen({ Key? key });
    TextEditingController controller = TextEditingController();
    final _controller = LocationController();
  @override
  Widget build(BuildContext context) {     
    if(_controller.vpnList.isEmpty)  _controller.getVpnData();
    return Obx(() => Scaffold(
       appBar: AppBar(
       backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(137, 22, 21, 21)
            : Color.fromARGB(255, 100, 146, 148),
        
        iconTheme: IconThemeData(
            color:  Colors.white, // Change the color here
       ),    
          title: Text(' LOCATIONS',style: TextStyle(color: Color.fromARGB(255, 233, 232, 232),),),
          actions: [
            Text("[${_controller.vpnList.length}]\t\t\t",style: TextStyle(color: Color.fromARGB(255, 233, 232, 232),),),
          ],
        
        ),
        // Refresh Button
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10.0,right: 5.0),
          child: FloatingActionButton(
            onPressed: () {
                _controller.getVpnData();
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

        body: 
        _controller.isloading.value
        ?_loadingWidget(): _controller.vpnList.isEmpty
        ?_noVPNfound(context)
        :_vpnData(),
      ),
    );
  }
  _vpnData()=>ListView.builder( 

    itemCount: _controller.vpnList.length,

    physics: BouncingScrollPhysics(),
    padding: EdgeInsets.only(top: mq.height*.01,bottom: mq.height*.1,left: mq.width*.01,right: mq.width*.02),
    itemBuilder:((ctx, i) =>VpnCard(vpn:_controller.vpnList[i]) ) ,);
  _loadingWidget()=>SizedBox(
    width:double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        LottieBuilder.asset('assets/lottie/loading.json',width: mq.width*.5,),
        Text("Loading VPNs....😊",style: TextStyle(fontSize: 18,color: Colors.black54),)
      ],
    ),
  );
  _noVPNfound(BuildContext context)=>Center(child: Text("VPNs Not Found 😌",style: TextStyle(fontSize: 18,color:Theme.of(context).lightText),));
}