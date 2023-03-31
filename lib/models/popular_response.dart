import 'dart:convert';

List<Character> characterFromJson(String str) => List<Character>.from(json.decode(str).map((x) => Character.fromJson(x)));

String characterToJson(List<Character> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Character {
    Character({
        required this.id,
        required this.name,
        required this.role,
        required this.description,
        required this.trivia,
    });

    String id;
    String name;
    String role;
    String description;
    String trivia;

    factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["_id"],
        name: json["name"],
        role: json["role"],
        description: json["description"],
        trivia: json["trivia"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "role": role,
        "description": description,
        "trivia": trivia,
    };
}
