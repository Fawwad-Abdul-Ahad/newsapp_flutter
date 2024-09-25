import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/contollers/category_change_controller.dart';
import 'package:newsapp/model/news_category_model.dart';
import 'package:newsapp/screens/details_screen.dart';
import 'package:newsapp/services/categories_news_api.dart';
// import 'package:newsapp/controllers/category_change_controller.dart';
import 'package:newsapp/view_model/news_view_model.dart';

class CategoryNewsScreen extends StatelessWidget {
  const CategoryNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            "Category News",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 42, 27),
      ),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.09,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryContoller.categoryList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      categoryContoller.changeCategory(index);
                    },
                    child: Obx(
                      () => Container(
                        width: Get.width * 0.4,
                        decoration: BoxDecoration(
                          color: categoryContoller.categoryName.value ==
                                  categoryContoller.categoryList[index]
                              ? Colors.red
                              : const Color.fromARGB(146, 233, 16, 1),
                          borderRadius: BorderRadius.circular(90),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          categoryContoller.categoryList[index].toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: Obx(
            () => FutureBuilder<CategoryNewsAPI>(
              future: categoryModel
                  .categoriesNewsFunc(categoryContoller.categoryName.value),
              builder: (context, snapshot) {
                // Handle loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: SpinKitCircle(color: Colors.red, size: 30));
                }

                // Handle error state
                if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching data"));
                }

                // Handle data rendering
                if (snapshot.hasData && snapshot.data!.articles != null) {
                  var articles = snapshot.data!.articles!;

                  if (articles.isEmpty) {
                    return const Center(child: Text("No articles available"));
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        final date = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return InkWell(
                          onTap: (){
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                          Text(format.format(date),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color.fromARGB(
                                                      255, 71, 71, 71))),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                return const Center(child: Text("No data available"));
              },
            ),
          )),
        ],
      ),
    );
  }
}

CategoryNewsViewModel categoryModel = CategoryNewsViewModel();
final format = DateFormat('MMMM dd, yyyy');
CategoryChangeController categoryContoller =
    Get.put(CategoryChangeController());
