  import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
  import 'package:get/get.dart';
  import 'package:google_fonts/google_fonts.dart';

  class DetailsScreen extends StatelessWidget {
  DetailsScreen({
    super.key,
    required this.desc,
    required this.title,
    required this.date,
    required this.img,
    this.source,
    this.tag, // Add tag as a parameter
  });

  String? desc;
  String? source;
  String? date;
  String? title;
  String? img;
  String? tag; // Ensure it's defined

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
              tag: tag ?? '', // Use the passed tag
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                child: SizedBox(
                  height: Get.height * 0.5,
                  width: Get.width * 1,
                  child: img.toString == null ? SpinKitFadingCircle():CachedNetworkImage(
                    imageUrl: img.toString(),
                    scale: 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: InkWell(
                onTap: (){
                  Get.back();
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Color.fromARGB(48, 255, 19, 3),
                  child: Center(child: Icon(Icons.arrow_back,size: 40,color: Color.fromARGB(255, 255, 17, 0),))),
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
            child: Text(
              title.toString(),
              style: GoogleFonts.poppins(
                  color: Color.fromARGB(255, 99, 99, 99),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(source.toString().toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
                Text(date.toString().toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 125, 125, 125),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 18),
            child: Text(desc.toString(),style: GoogleFonts.poppins(fontWeight:FontWeight.bold,fontSize:18,color:Color.fromARGB(255, 0, 0, 0)),)),
        ],
      ),
    );
  }
}

