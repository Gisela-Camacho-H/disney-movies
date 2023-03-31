import 'dart:convert';

List<Movie> movieFromJson(String str) => List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));

String movieToJson(List<Movie> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movie {
    Movie({
        required this.id,
        required this.title,
        required this.promoImage,
        required this.year,
        required this.era,
        required this.length,
        required this.trailerLink,
        required this.trivia,
        required this.category,
    });

    String id;
    String title;
    String promoImage;
    String year;
    String era;
    String length;
    String trailerLink;
    String trivia;
    String category;

    factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["_id"],
        title: json["title"],
        promoImage: json["promoImage"],
        year: json["year"],
        era: json["era"],
        length: json["length"],
        trailerLink: json["trailerLink"],
        trivia: json["trivia"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "promoImage": promoImage,
        "year": year,
        "era": era,
        "length": length,
        "trailerLink": trailerLink,
        "trivia": trivia,
        "category": category,
    };
}
