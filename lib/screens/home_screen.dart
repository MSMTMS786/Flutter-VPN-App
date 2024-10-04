import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controllers/home_controler.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/vpn_status.dart';
import 'package:vpn_basic_project/screens/location_screen.dart';
import 'package:vpn_basic_project/screens/network_test_screen.dart';
import 'package:vpn_basic_project/widgets/count_down_timer.dart';
import 'package:vpn_basic_project/widgets/home_card.dart';
import '../services/vpn_engine.dart';
class HomeScreen extends StatelessWidget {
   HomeScreen({ Key? key });
  final _controller=Get.put(HomeController());
  // @override
  @override
  Widget build(BuildContext context) {
        ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
       _controller.vpnState.value = event;
    });
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home,color: Color.fromARGB(255, 219, 210, 210),),
        title: Text('VPN MASTER',style: TextStyle(color: Color.fromARGB(255, 233, 232, 232),),),
        actions: [
          IconButton(
          onPressed: (){
            Get.changeThemeMode(Pref.isDarkMode? ThemeMode.light: ThemeMode.dark);
            Pref.isDarkMode=!Pref.isDarkMode;
          }, 
          icon:Icon(
            CupertinoIcons.brightness,
            size: 20,
            color: Color.fromARGB(255, 219, 210, 210),
            )),
          IconButton(
            padding: EdgeInsets.only(right: 8),
          onPressed: ()=>Get.to(()=>NetworkTestScreen()), 
          icon:Icon(
          CupertinoIcons.info,//CupertinoIcons is For IOS
          size: 20,
          color: Color.fromARGB(255, 219, 210, 210),
          )),
          ],
      //backgroundColor: Color(0Xff005a7d),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          physics: BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(()=> _vpnButton()),
               Obx(
                 ()=> Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeCard(
                    title:_controller.vpn.value.countryLong.isEmpty 
                    ? "Country":_controller.vpn.value.countryLong,
                    subtitle: "FREE", 
                    icon: CircleAvatar(
                      radius: 30, 
                      child:_controller.vpn.value.countryLong.isEmpty 
                      ?Icon(Icons.vpn_lock_rounded,size: 30,)
                      :null,
                      backgroundImage:_controller.vpn.value.countryLong.isEmpty
                      ? null
                      : AssetImage("assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png"),
                      ),
                     onTap: '',
                     ),
                      SizedBox(width: 30,),
                     HomeCard(
                    title:_controller.vpn.value.countryLong.isEmpty 
                    ? "100 ms"
                    : "${_controller.vpn.value.ping} ms",
                    subtitle: "PING", 
                    icon: CircleAvatar(
                      radius: 30, 
                      child: Icon(Icons.equalizer_rounded,size: 30,),
                      ),
                     onTap: '',
                     ),
                  ],
                 ),
               ),
               SizedBox(height: 20,),
               StreamBuilder<VpnStatus?>(
                  initialData: VpnStatus(),
                  stream: VpnEngine.vpnStatusSnapshot(),
                  builder: (context, snapshot) => 
                   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeCard( 
                  title: "${snapshot.data?.byteIn ?? "0 kbps"}",
                  subtitle: "DOWNLOAD", 
                  icon: CircleAvatar(
                    radius: 30, 
                    child: Icon(Icons.arrow_downward_rounded,size: 30,),
                    ),
                   onTap: '',
                   ),
                   SizedBox(width: 30,),
                   HomeCard(
                  title: "${snapshot.data?.byteOut ?? "0 kbps"}",
                  subtitle: "ULPOAD", 
                  icon: CircleAvatar(
                    radius: 30, 
                    child: Icon(Icons.arrow_upward_rounded,size: 30,),
                    ),
                   onTap: '',
                   ),
                ],
               ),
                ), 
              ]),
        ),
      ),
      bottomNavigationBar: _changeLocation(context),
    );
  }
  Widget _vpnButton()=>Column(
    children: [
      Semantics(
        button: true,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: (){
            _controller.connectToVpn();
          },
          child: Container(
             padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _controller.getButtonColor.withOpacity(.1),
              ),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:_controller.getButtonColor.withOpacity(.2),
                ),
              child: Container(
                width:mq.height*0.14,
                height: mq.height*0.14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _controller.getButtonColor.withOpacity(.3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.power_settings_new_rounded,size: 30,color: Colors.white,),
                    Text(_controller.getButtonText,style: TextStyle(color: Colors.white,fontSize: 15),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      //Connection Status Label
      Container(
        margin: EdgeInsets.only(top: mq.height*0.02,bottom: mq.height*0.02),
        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
        decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0Xff005a7d),
          ),
        child: Text(
          _controller.vpnState.value==VpnEngine.vpnDisconnected?"Not Connected"
          :_controller.vpnState.value.replaceAll("_", " ").toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
 Obx(()=> CountDownTimer(startTimer:  _controller.vpnState.value==VpnEngine.vpnConnected,)),
    ],
  );
Widget _changeLocation(BuildContext context)=>SafeArea(
  child: Semantics(
    child: InkWell(
      // onTap: (){Get.to(LocationScreen());},
      onTap: () => Get.to(() =>LocationScreen()),
      child: Container(
        color:Theme.of(context).bottomNav,
        height: mq.height*0.1,
        padding: EdgeInsets.symmetric(horizontal: mq.width*0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.globe,color: Colors.white,size: 30,),
            SizedBox(width: 10,),
            Text(
              "Change Location",
              style:TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
            ),
            Spacer(),
           CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.keyboard_arrow_right_rounded ,color:  Color.fromARGB(255, 100, 146, 148),
            ),
            ),
          ],
        ),
      ),
    ),
  ),
);
}

// Center(

//                   child: TextButton(
//                     style: TextButton.styleFrom(
//                       shape: StadiumBorder(),
//                       backgroundColor: Theme.of(context).primaryColor,
//                     ),
//                     child: Text(
//                        _controller.vpnState.value == VpnEngine.vpnDisconnected
//                           ? 'Connect VPN'
//                           :  _controller.vpnState.value.replaceAll("_", " ").toUpperCase(),
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     onPressed: _connectClick,
//                   ),
//                 ),
//                 StreamBuilder<VpnStatus?>(
//                   initialData: VpnStatus(),
//                   stream: VpnEngine.vpnStatusSnapshot(),
                  
//                   builder: (context, snapshot) => Text(
                
//                       "${snapshot.data?.byteIn ?? ""}, ${snapshot.data?.byteOut ?? ""}",
                    
//                       textAlign: TextAlign.center),
              
//                 ),
              
//                 //sample vpn list
//                 Column(
//                     children: _listVpn
//                         .map(
//                           (e) => ListTile(
//                             title: Text(e.country),
//                             leading: SizedBox(
//                               height: 20,
//                               width: 20,
//                               child: Center(
//                                   child: _selectedVpn == e
//                                       ? CircleAvatar(
//                                           backgroundColor: Colors.green)
//                                       : CircleAvatar(
//                                           backgroundColor: Colors.grey)),
//                             ),
//                             onTap: () {
//                               log("${e.country} is selected");
//                               setState(() => _selectedVpn = e);
//                             },
//                           ),
//                         )
//                         .toList()
//                       )