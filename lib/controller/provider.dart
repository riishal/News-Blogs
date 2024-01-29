import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/models/details_response.dart';
import 'package:news_app/models/list_response.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/endpoints.dart';
import 'package:news_app/view/homepage.dart';

class NewsAndBlogProvider extends ChangeNotifier {
  int selectedCategory = 0;

  updateSelectedCategory(category) {
    selectedCategory = category;
    getNewsAndBlogList(1);
    notifyListeners();
  }

  Future<List<BlogsCategory>?> getCategories() async {
    String uri = '${Endpoints.baseUrl}/${Endpoints.categories}';
    Response response = await get(Uri.parse(uri));
    if (response.statusCode == 202) {
      var categoriesResponse = newAndBlogResponseFromJson(response.body);
      // logger('categories response', categoriesResponse.blogsCategory);
      selectedCategory = categoriesResponse.blogsCategory.first.id;
      return categoriesResponse.blogsCategory;
    }
    return null;
  }

  Future<List<Result>?> getNewsAndBlogList(int page) async {
    String uri = '${Endpoints.baseUrl}/${Endpoints.newsBlogList}?page=$page';
    logger('cate', selectedCategory);
    Map<String, dynamic> body = {
      'category': selectedCategory.toString(),
    };
    Response response = await post(Uri.parse(uri), body: body);
    // logger('list response', response.body);
    if (response.statusCode == 200) {
      var listResponse = newsAndBlogListResponseFromJson(response.body);
      return listResponse.results;
    }
    return null;
  }

  Future<Blog?> getDetails(int id) async {
    String uri = '${Endpoints.baseUrl}/${Endpoints.details}/$id';
    Response response = await get(Uri.parse(uri));
    if (response.statusCode == 202) {
      var detailsResponse = detailsResponseFromJson(response.body);
      logger('details response', response.body);
      return detailsResponse.blog;
    }
    return null;
  }

  void setIndex(int index) {
    buttonindex = index;
    notifyListeners();
  }
}
