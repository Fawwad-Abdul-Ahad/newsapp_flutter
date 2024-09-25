// import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/contollers/category_change_controller.dart';
import 'package:newsapp/contollers/goto_category.dart';
import 'package:newsapp/contollers/newschannel_controller.dart';
import 'package:newsapp/contollers/theme_controller.dart';
import 'package:newsapp/model/news_category_model.dart';
import 'package:newsapp/screens/category_news_screen.dart';
import 'package:newsapp/screens/details_screen.dart';
// import 'package:newsapp/screens/category_news_screen.dart';
import 'package:newsapp/view_model/news_view_model.dart';

enum filteredList { bbcNews, aryNews, alJazeera }

NewsChannelController filterController = Get.put(NewsChannelController());
CategoryScreenController categoryScreenController =
    Get.put(CategoryScreenController());
CategoryChangeController categoryController = Get.put(CategoryChangeController());

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  bool yes = true; // State variable for switch
  NewsViewModel newsviewmodel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  ThemeController themeController = Get.put(ThemeController());
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      actions: [
        InkWell(
          onTap: () {
            categoryScreenController.gotoCategory();
          },
          child: const Icon(
            Icons.menu,
            size: 28,
            color: Colors.white,
          ),
        ),
        PopupMenuButton(
          onSelected: (filteredList item) {
            filterController.onSelected(item);
          },
          initialValue: filterController.selectedItems.value,
          color: Colors.white,
          icon: const Icon(
            Icons.more_vert_outlined,
            color: Colors.white,
          ),
          itemBuilder: (context) => <PopupMenuEntry<filteredList>>[
            const PopupMenuItem(
              value: filteredList.bbcNews,
              child: Text("BBC NEWS"),
            ),
            const PopupMenuItem(
              value: filteredList.aryNews,
              child: Text("ARY NEWS"),
            ),
            const PopupMenuItem(
              value: filteredList.alJazeera,
              child: Text("AL JAZEERA NEWS"),
            ),
          ],
        ),
      ],
      leading: Obx(() => Switch(
        value: themeController.isValue.value,
        onChanged: (value){
          themeController.changeVal(value);
        },
      )),
      title: const Text(
        "News",
        style: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.red,
    ),
    body: Obx(() {
      return SingleChildScrollView(
        child: Column(
          children: [
            // Wrapping the first ListView.builder in a SizedBox with a fixed height
            SizedBox(
              height: Get.height * 0.6, // Adjust the height as needed
              child: FutureBuilder(
                future: newsviewmodel.headlineAPI(filterController.name.value),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitFadingCircle(
                        color: Colors.red,
                        size: 80,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        final date = DateTime.parse(
                          snapshot.data!.articles![index].publishedAt
                              .toString(),
                        );
                        return Container(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 28),
                                height: Get.height * 1,
                                width: Get.width * 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) =>
                                        const SpinKitFadingCircle(
                                      color: Colors.red,
                                      size: 80,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const SpinKitFadingCircle(
                                      color: Colors.red,
                                      size: 80,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 40,
                                child: Card(
                                  elevation: 20,
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    height: Get.height * 0.22,
                                    width: Get.width * 0.8,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: SizedBox(
                                            width: Get.width * 0.9,
                                            child: Text(
                                              snapshot.data!.articles![index].title.toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  color: const Color.fromARGB(255, 0, 0, 0),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index].source!.name.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color.fromARGB(255, 107, 107, 107)),
                                              ),
                                              Text(
                                                format.format(date),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color.fromARGB(255, 69, 69, 69)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No data available'),
                    );
                  }
                },
              ),
            ),
            
            // Wrapping the second ListView.builder in a SizedBox with a fixed height
            SizedBox(
              height: Get.height * 0.4, // Adjust the height as needed
              child: FutureBuilder<CategoryNewsAPI>(
                future: categoryModel
                    .categoriesNewsFunc(categoryContoller.categoryName.value),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitCircle(color: Colors.red, size: 30));
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Error fetching data"));
                  }

                  if (snapshot.hasData && snapshot.data!.articles != null) {
                    var articles = snapshot.data!.articles!;

                    if (articles.isEmpty) {
                      return const Center(child: Text("No articles available"));
                    }

                    return ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        final date = DateTime.parse(
                            snapshot.data!.articles![index].publishedAt
                                .toString());
                        return InkWell(
                          onTap: () {
                            Get.to(DetailsScreen(
                                desc: snapshot.data!.articles![index].description
                                    .toString(),
                                title: snapshot.data!.articles![index].title
                                    .toString(),
                                date: format.format(date),
                                img: snapshot.data!.articles![index].urlToImage
                                    .toString(),
                                source: categoryContoller.categoryName.value,
                                tag: snapshot.data!.articles![index].title
                                    .toString()));
                          },
                          child: Container(
                            height: Get.height * 0.2,
                            width: Get.width * 1,
                            margin: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: article.urlToImage ?? '',
                                    placeholder: (context, url) =>
                                        const SpinKitCircle(
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    width: Get.width * 0.35,
                                    height: Get.height * 0.2,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title ?? "No title available",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        article.description ??
                                            "No description available",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              format.format(date),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    255, 71, 71, 71),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const Center(child: Text("No data available"));
                },
              ),
            ),
          ],
        ),
      );
    }),
  );
}


}
