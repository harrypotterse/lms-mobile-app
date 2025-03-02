// To parse this JSON data, do
//
//     final featuredCategoryResponse = featuredCategoryResponseFromJson(jsonString);

import 'dart:convert';

FeaturedCategoryResponse featuredCategoryResponseFromJson(String str) => FeaturedCategoryResponse.fromJson(json.decode(str));

String featuredCategoryResponseToJson(FeaturedCategoryResponse data) => json.encode(data.toJson());

class FeaturedCategoryResponse {
    FeaturedCategoryResponse({
        required this.result,
        required this.message,
        required this.data,
    });

    final bool? result;
    final String? message;
    final List<Category> data;

    factory FeaturedCategoryResponse.fromJson(Map<String, dynamic> json){
        return FeaturedCategoryResponse(
            result: json["result"],
            message: json["message"],
            data: json["data"] == null ? [] : List<Category>.from(json["data"]!.map((x) => Category.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
    };

}

class Category {
    Category({
        required this.id,
        required this.title,
        required this.slug,
        required this.icon,
        required this.categories,
        required this.parentId,
    });

    final int? id;
    final String? title;
    final String? slug;
    final String? icon;
    final List<Category> categories;
    final int? parentId;

    factory Category.fromJson(Map<String, dynamic> json){
        return Category(
            id: json["id"],
            title: json["title"],
            slug: json["slug"],
            icon: json["icon"],
            categories: json["subcategories"] == null ? [] : List<Category>.from(json["subcategories"]!.map((x) => Category.fromJson(x))),
            parentId: json["parent_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "icon": icon,
        "subcategories": categories.map((x) => x.toJson()).toList(),
        "parent_id": parentId,
    };

}
