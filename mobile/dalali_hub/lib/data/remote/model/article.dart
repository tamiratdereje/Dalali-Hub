
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  final String title;
  final String url;

  Article({
    required this.title,
    required this.url,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

}

@JsonSerializable()
class AllArticles {
  final List<Article> results;

  AllArticles({required this.results});

  factory AllArticles.fromJson(Map<String, dynamic> json) =>
      _$AllArticlesFromJson(json);
}
