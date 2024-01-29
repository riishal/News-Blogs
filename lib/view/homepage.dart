import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/provider.dart';
import 'package:news_app/utils/endpoints.dart';
import 'package:news_app/view/details.dart';
import 'package:news_app/view/read_morepage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

int buttonindex = 0;

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'News & Blogs',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Consumer<NewsAndBlogProvider>(builder: (context, getdata, child) {
        return FutureBuilder(
            future: context.read<NewsAndBlogProvider>().getCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return Column(
                  children: [
                    SizedBox(
                      height: 30,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final category = snapshot.data![index];
                            return category.name != null
                                ? GestureDetector(
                                    onTap: () {
                                      context
                                          .read<NewsAndBlogProvider>()
                                          .updateSelectedCategory(category.id);
                                      getdata.setIndex(index);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        category.name.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: buttonindex == index
                                                ? Colors.green.shade700
                                                : Colors.black),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 8,
                              ),
                          itemCount: snapshot.data!.length),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      child: CarouselSlider(
                        items: <Widget>[
                          // for (var i = 0;
                          //     i < getdata.data.blogsCategory.length;
                          //     i++)
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6KFQOGmDyU5LSqLu2F8KFwvOIrx7y6k75aQ&usqp=CAU'),
                                  fit: BoxFit.contain),
                            ),
                          )
                        ],
                        options: CarouselOptions(
                          aspectRatio: 4 / 4,
                          height: double.infinity,
                          viewportFraction: 0.9,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1000),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Latest News",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 19),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReadMore()));
                              },
                              child: Text(
                                'Read More',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: FutureBuilder(
                          future: context
                              .read<NewsAndBlogProvider>()
                              .getNewsAndBlogList(1), // page no: 1
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasData) {
                              return ListView.separated(
                                  padding: const EdgeInsets.all(10),
                                  itemBuilder: (context, index) {
                                    final newsBlog = snapshot.data![index];
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsScreen(
                                                          id: newsBlog.id)));
                                        },
                                        child: Container(
                                          height: 240,
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Stack(children: [
                                                    Positioned(
                                                        bottom: 15,
                                                        right: 14,
                                                        child: Container(
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Icon(Icons
                                                                    .access_time_filled),
                                                                Text(
                                                                  '20 Min ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black),
                                                                )
                                                              ]),
                                                          height: 35,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color:
                                                                  Colors.white),
                                                        ))
                                                  ]),
                                                  height: 100,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              'https://image.cnbcfm.com/api/v1/image/106928219-1629130755312-gettyimages-1234311531-sindeyev-notitle210729_np12K.jpeg?v=1689638667&w=929&h=523&vtcrop=y'),
                                                          fit: BoxFit.fill),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  newsBlog.title,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Expanded(
                                                    child: HtmlWidget(
                                                  newsBlog.content,
                                                ))
                                              ]),
                                        ));
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 10,
                                      ),
                                  itemCount: snapshot.data!.length);
                            }
                            return Container();
                          }),
                    ),
                  ],
                );
              }
              return Container();
            });
      }),
    );
  }
}
