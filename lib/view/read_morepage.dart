import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:news_app/controller/provider.dart';
import 'package:news_app/view/details.dart';
import 'package:provider/provider.dart';

class ReadMore extends StatelessWidget {
  const ReadMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Latest News',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
      ),
      body: FutureBuilder(
          future: context
              .read<NewsAndBlogProvider>()
              .getNewsAndBlogList(1), // page no: 1
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DetailsScreen(id: newsBlog.id)));
                        },
                        child: Container(
                          height: 240,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Stack(children: [
                                    Positioned(
                                        bottom: 15,
                                        right: 14,
                                        child: Container(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(Icons.access_time_filled),
                                                Text(
                                                  '20 Min ',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black),
                                                )
                                              ]),
                                          height: 35,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                        ))
                                  ]),
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade200,
                                      borderRadius: BorderRadius.circular(10)),
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
                                // Text(
                                //   newsBlog.content,
                                //   maxLines: 2,
                                // ),
                              ]),
                        ));
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: snapshot.data!.length);
            }
            return Container();
          }),
    );
  }
}
