
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
import '../services/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key});
  final _controller = Get.put(HomeController());
  // @override
  @override
  Widget build(BuildContext context) {
    Widget _vpnButton() => Column(
          children: [
            Semantics(
              button: true,
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  _controller.connectToVpn();
                },
                child: Material(
                  shape: const CircleBorder(),
                  elevation: 5,
                  color: Colors.transparent,
                  child: Container(
                    height: mq.height * 0.25,
                    width: mq.height * 0.25,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color.fromARGB(137, 83, 80, 80)
                          : Colors.white38,
                    ),
                     child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _controller.getButtonImage,
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              _controller.getButtonText,
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                   
                  ),
                ),
              ),
            ),
            //Connection Status Label
            Container(
              margin: EdgeInsets.only(
                  top: mq.height * 0.02, bottom: mq.height * 0.02),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 92, 108, 110)
                    : const Color(0Xff005a7d),
              ),
              child: Text(
                _controller.vpnState.value == VpnEngine.vpnDisconnected
                    ? "Not Connected"
                    : _controller.vpnState.value
                        .replaceAll("_", " ")
                        .toUpperCase(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            // Obx(() => CountDownTimer(
            //       startTimer:
            //           _controller.vpnState.value == VpnEngine.vpnConnected,
            //     )),
          ],
        );

    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 46, 42, 42)
          : const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(137, 22, 21, 21)
            : const Color.fromARGB(255, 100, 146, 148),
        leading: IconButton(
  onPressed: () {
    // Toggle between dark and light mode
    Get.changeThemeMode(Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    Pref.isDarkMode = !Pref.isDarkMode; // Update the isDarkMode preference
  },
  icon: Icon(
    // Toggle icon based on the current theme
    Pref.isDarkMode ? CupertinoIcons.moon_fill : CupertinoIcons.sun_max_fill,
    size: 30,
    color: Pref.isDarkMode ? Colors.yellow : const Color.fromARGB(255, 219, 210, 210),
  ),
),

        title: const Text(
          'APNA VPN',
          style: TextStyle(
            color: Color.fromARGB(255, 233, 232, 232),
          ),
        ),
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 8),
              onPressed: () => Get.to(() => NetworkTestScreen()),
              icon: const Icon(
                CupertinoIcons.info, //CupertinoIcons is For IOS
                size: 20,
                color: Color.fromARGB(255, 219, 210, 210),
              )),
        ],
        //backgroundColor: Color(0Xff005a7d),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                

                Obx(() => _vpnButton()),
                Obx(
                  () => Column(
                    children: [
                      SizedBox(height: 80),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: mq.height * 0.10,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 100, 146, 148),
                          borderRadius: BorderRadius.circular(50),),
                       
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          
                      
                      
                      
                                      // Custom Code
                            // 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                    radius: 20,
                                    child: _controller.vpn.value.countryLong.isEmpty
                                        ? const Icon(
                                            Icons.vpn_lock_rounded,
                                            size: 35,
                                          )
                                        : null,
                                    backgroundImage: _controller
                                            .vpn.value.countryLong.isEmpty
                                        ? null
                                        : AssetImage(
                                            "assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png"),
                                                              ),
                                  ],
                                ),
                              SizedBox(width: 20,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _controller.vpn.value.countryLong.isEmpty
                                          ? "Select Country"
                                          : _controller.vpn.value.countryLong,
                                      
                                      ),
                      
                                    Text(
                                      _controller.vpn.value.countryLong.isEmpty
                                          ? "IP - 127.123.21.12"
                                          : _controller.vpn.value.ip,
                                    )
                                    // Text(
                                    //   "IP:${_controller.vpn.value.ip}"),
                                  ],
                                ),
                              ],
                            ),
                      
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => LocationScreen());
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                )
        
                      
                      /////////////////////////////////////////////////////////////
                                      // Previus Code
                            // HomeCard(
                            //   title: _controller.vpn.value.countryLong.isEmpty
                            //       ? "Country"
                            //       : _controller.vpn.value.countryLong,
                            //   subtitle: "",
                            //   icon: CircleAvatar(
                            //     radius: 30,
                            //     child: _controller.vpn.value.countryLong.isEmpty
                            //         ? const Icon(
                            //             Icons.vpn_lock_rounded,
                            //             size: 30,
                            //           )
                            //         : null,
                            //     backgroundImage: _controller
                            //             .vpn.value.countryLong.isEmpty
                            //         ? null
                            //         : AssetImage(
                            //             "assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png"),
                            //   ),
                            //   onTap: '',
                            // ),
                            // const SizedBox(
                            //   width: 30,
                            // ),
                            // HomeCard(
                            //   title: _controller.vpn.value.countryLong.isEmpty
                            //       ? "0 kb/s"
                            //       : "${_controller.vpn.value.speed} ms",
                            //   subtitle: "Speed",
                              
                              //  CircleAvatar(
                      
                                // backgroundColor:
                                //     Theme.of(context).brightness == Brightness.dark
                                //         ? Colors.white
                                //         : const Color(0Xff005a7d),
                                // radius: 30,
                                // child: const Icon(
                                //   // Icons.equalizer_rounded,
                                //   // size: 30,
                                //   // color:
                                //       // Theme.of(context).brightness == Brightness.dark
                                //           // ? Colors.black54
                                //           // : Colors.white,
                                  
                                // ),
                              // ),
                            //   onTap: '',
                            // ),
                      /////////////////////////////////////////////////////////////
                      
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(() => CountDownTimer(
                  startTimer:
                      _controller.vpnState.value == VpnEngine.vpnConnected,
                )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<VpnStatus?>(
                  initialData: VpnStatus(),
                  stream: VpnEngine.vpnStatusSnapshot(),
                  builder: (context, snapshot) => const Row(
                  
       ///////////////////////////////////////////////////////////
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     HomeCard(
                  //       title: "${snapshot.data?.byteIn ?? "0 kbps"}",
                  //       subtitle: "DOWNLOAD",
                  //       icon: CircleAvatar(
                  //         backgroundColor:
                  //             Theme.of(context).brightness == Brightness.dark
                  //                 ? Colors.white
                  //                 : Color(0Xff005a7d),
                  //         radius: 30,
                  //         child: Icon(
                  //           Icons.arrow_downward_rounded,
                  //           size: 30,
                  //           color:
                  //               Theme.of(context).brightness == Brightness.dark
                  //                   ? Colors.black54
                  //                   : Colors.white,
                  //         ),
                  //       ),
                  //       onTap: '',
                  //     ),
                  //     SizedBox(
                  //       width: 30,
                  //     ),
                  //     HomeCard(
                  //       title: "${snapshot.data?.byteOut ?? "0 kbps"}",
                  //       subtitle: "ULPOAD",
                  //       icon: CircleAvatar(
                  //         backgroundColor:
                  //             Theme.of(context).brightness == Brightness.dark
                  //                 ? Colors.white
                  //                 : Color(0Xff005a7d),
                  //         radius: 30,
                  //         child: Icon(
                  //           Icons.arrow_upward_rounded,
                  //           size: 30,
                  //           color:
                  //               Theme.of(context).brightness == Brightness.dark
                  //                   ? Colors.black54
                  //                   : Colors.white,
                  //         ),
                  //       ),
                  //       onTap: '',
                  //     ),
                  //   ],
         
      /////////////////////////////////////////////////////////////         
                  ),
                ),
                
              ]),
        ),
      ),
     /////////////////////////////////////////////////////////////
              // bottomNavigationBar: _changeLocation(context),
    
    /////////////////////////////////////////////////////////////
    );

    // ignore: dead_code
  }

  // ignore: unused_element
  Widget _changeLocation(BuildContext context) => SafeArea(
        child: Semantics(
          child: InkWell(
            // onTap: (){Get.to(LocationScreen());},
            onTap: () => Get.to(() => LocationScreen()),
            child: Container(
              color: Theme.of(context).bottomNav,
              height: mq.height * 0.1,
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.04),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.globe,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Change Location",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Color.fromARGB(255, 100, 146, 148),
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