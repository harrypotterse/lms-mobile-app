// To parse this JSON data, do
//
//     final bookmarkListResponse = bookmarkListResponseFromJson(jsonString);

import 'dart:convert';

BookmarkListResponse bookmarkListResponseFromJson(String str) => BookmarkListResponse.fromJson(json.decode(str));

String bookmarkListResponseToJson(BookmarkListResponse data) => json.encode(data.toJson());

class BookmarkListResponse {
    bool? result;
    String? message;
    Data? data;

    BookmarkListResponse({
        this.result,
        this.message,
        this.data,
    });

    factory BookmarkListResponse.fromJson(Map<String, dynamic> json) => BookmarkListResponse(
        result: json["result"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    List<Bookmark>? bookmarks;

    Data({
        this.bookmarks,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookmarks: json["bookmarks"] == null ? [] : List<Bookmark>.from(json["bookmarks"]!.map((x) => Bookmark.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "bookmarks": bookmarks == null ? [] : List<dynamic>.from(bookmarks!.map((x) => x.toJson())),
    };
}

class Bookmark {
    int? id;
    String? title;
    int? price;
    int? discountPrice;
    String? image;
    int? rate;
    int? totalSales;
    bool? isPurchased;

    Bookmark({
        this.id,
        this.title,
        this.price,
        this.discountPrice,
        this.image,
        this.rate,
        this.totalSales,
        this.isPurchased,
    });

    factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        discountPrice: json["discount_price"],
        image: json["image"],
        rate: json["rate"],
        totalSales: json["total_sales"],
        isPurchased: json["is_purchased"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "discount_price": discountPrice,
        "image": image,
        "rate": rate,
        "total_sales": totalSales,
        "is_purchased": isPurchased,
    };
}
