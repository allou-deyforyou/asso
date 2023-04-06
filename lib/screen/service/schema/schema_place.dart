import 'dart:convert';

import 'package:equatable/equatable.dart';

part 'schema_place_raw.dart';

class PlaceSchema extends Equatable {
  const PlaceSchema({
    this.title,
    this.extent,
    this.subtitle,
    this.latitude,
    this.longitude,
  });

  static const String idKey = 'id';
  static const String titleKey = 'title';
  static const String extentKey = 'extent';
  static const String subtitleKey = 'subtitle';
  static const String latitudeKey = 'latitude';
  static const String longitudeKey = 'longitude';

  final String? title;
  final String? subtitle;
  final double? latitude;
  final double? longitude;
  final List<double>? extent;

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  List<Object?> get props {
    return [
      title,
      subtitle,
      latitude,
      longitude,
      extent,
    ];
  }

  PlaceSchema copyWith({
    String? title,
    String? subtitle,
    double? latitude,
    double? longitude,
    List<double>? extent,
  }) {
    return PlaceSchema(
      title: title ?? this.title,
      extent: extent ?? this.extent,
      subtitle: subtitle ?? this.subtitle,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  PlaceSchema clone() {
    return copyWith(
      title: title,
      extent: extent,
      subtitle: subtitle,
      latitude: latitude,
      longitude: longitude,
    );
  }

  static PlaceSchema fromMap(Map<String, dynamic> data) {
    return PlaceSchema(
      title: data[titleKey],
      subtitle: data[subtitleKey],
      latitude: data[latitudeKey],
      longitude: data[longitudeKey],
      extent: data[extentKey].cast<double>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      titleKey: title,
      extentKey: extent,
      subtitleKey: subtitle,
      latitudeKey: latitude,
      longitudeKey: longitude,
    }..removeWhere((key, value) => value == null);
  }

  static PlaceSchema fromJson(String source) {
    return fromMap(jsonDecode(source));
  }

  static List<PlaceSchema> fromListJson(String source) {
    return List.of((jsonDecode(source) as List).map((data) => fromMap(data)));
  }

  static String toListJson(List<PlaceSchema> values) {
    return jsonEncode(List.of(values.map((value) => value.toMap())));
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static List<PlaceSchema> fromRawJsonList(String value) {
    final result = _PlaceResult.fromJson(value);
    return List.of((result.features!.map((e) {
      final properties = e.properties!;
      List<String> subtitles = [];
      if (properties.locality != null) subtitles.add(properties.locality!);
      if (properties.city != null) subtitles.add(properties.city!);
      if (properties.state != null) subtitles.add(properties.state!);
      if (properties.country != null) subtitles.add(properties.country!);

      return PlaceSchema(
        title: properties.name,
        extent: properties.extent,
        subtitle: subtitles.join(', '),
        latitude: e.geometry?.coordinates?[1],
        longitude: e.geometry?.coordinates?[0],
      );
    })));
  }
}
