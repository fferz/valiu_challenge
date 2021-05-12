import 'dart:convert';

import 'package:flutter/material.dart';

List<TagModel> tagModelFromJson(String str) =>
    List<TagModel>.from(json.decode(str).map((x) => TagModel.fromJson(x)));

String tagModelToJson(TagModel data) => json.encode(data.toJson());

List<TagModel> fromJsonList(List<dynamic> list) {
  List<TagModel> tags = [];

  if (list != null) {
    list.forEach((item) {
      final tag = TagModel.fromJson(item);
      tags.add(tag);
    });
  }
  return tags;
}

List<TagModel> fromMapToList(Map<String, dynamic> obj) {
  List<TagModel> tags = [];
  TagModel tag = new TagModel();

  if (obj != null) {
    tag.id = obj.containsKey('_id') ? obj['_id'] : 'no-id';
    tag.title = obj.containsKey('title') ? obj['title'] : 'no-title';
    tag.color = obj.containsKey('color') ? obj['color'] : '#FFFFFF';
    tag.createdAt = obj.containsKey('created_at')
        ? DateTime.parse(obj['created_at'])
        : new DateTime.now();
    tag.updatedAt = obj.containsKey('updated_at')
        ? DateTime.parse(obj['updated_at'])
        : new DateTime.now();
  }
  tags.add(tag);
  return tags;
}

class TagModel {
  TagModel({
    this.id,
    this.title,
    this.color,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String title;
  String color;
  DateTime createdAt;
  DateTime updatedAt;

  TagModel.create({@required this.title, @required this.color});

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
        id: json["_id"],
        title: json["title"],
        color: json["color"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {"title": title, "color": color};

  TagModel copyWith(
          {String id,
          String title,
          String color,
          DateTime createdAt,
          DateTime updatedAt}) =>
      TagModel(
          id: id ?? this.id,
          title: title ?? this.title,
          color: color ?? this.color,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt);
}
