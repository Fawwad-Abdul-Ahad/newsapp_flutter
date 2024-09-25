import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/contollers/initState_controller.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
  GoToNewScreen controllerToNewScreen = Get.put(GoToNewScreen());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.08,
            ),
            SizedBox(
                height: Get.height * 0.5,
                width: Get.width * 1,
                child: Image.asset(
                  'images/splash_pic.jpg',
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Text(
              "Top Headlines News",
              style: GoogleFonts.anton(color: Colors.red, fontSize: 18),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            const SpinKitChasingDots(
              color: Colors.red,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
