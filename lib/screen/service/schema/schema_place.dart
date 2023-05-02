import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PlaceSchema extends Equatable {
  const PlaceSchema({
    this.title,
    this.subtitle,
    this.position,
  });

  static const String titleKey = 'title';
  static const String subtitleKey = 'subtitle';
  static const String positionKey = 'position';

  final String? title;
  final String? subtitle;
  final GeoPoint? position;


  @override
  String toString() {
    return toMap().toString();
  }

  @override
  List<Object?> get props {
    return [
      title,
      subtitle,
      position,
    ];
  }

  PlaceSchema copyWith({
    String? title,
    String? subtitle,
    GeoPoint? position,
  }) {
    return PlaceSchema(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      position: position ?? this.position,
    );
  }

  PlaceSchema clone() {
    return copyWith(
      title: title,
      subtitle: subtitle,
      position: position,
    );
  }

  static PlaceSchema fromMap(Map<String, dynamic> data) {
    return PlaceSchema(
      title: data[titleKey],
      subtitle: data[subtitleKey],
      position: data[positionKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      titleKey: title,
      subtitleKey: subtitle,
      positionKey: position,
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
      final subtitles = Set.identity();
      final positions = Set.identity();
      final properties = e.properties!;
      if (properties.locality != null) subtitles.add(properties.locality!);
      if (properties.locality != null) positions.add(properties.locality!);
      if (properties.city != null) subtitles.add(properties.city!);
      if (properties.city != null) positions.add(properties.city!);
      if (properties.state != null) subtitles.add(properties.state!);
      if (properties.state != null) positions.add(properties.state!);
      if (properties.country != null) subtitles.add(properties.country!);
      if (properties.country != null) positions.add(properties.country!);

      return PlaceSchema(
        title: properties.name,
        subtitle: subtitles.join(', '),
        position: GeoPoint(
          e.geometry!.coordinates![1],
          e.geometry!.coordinates![0],
        ),
      );
    })));
  }
}

class _PlaceResult {
  _PlaceResult({
    required this.features,
  });
  final List<_PlaceFeature>? features;

  static const featuresKey = 'features';

  static _PlaceResult fromMap(Map<String, dynamic> value) {
    return _PlaceResult(
      features: List.of(value[featuresKey].map<_PlaceFeature>((e) {
        return _PlaceFeature.fromMap(e.cast<String, dynamic>());
      })),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      featuresKey: features?.map((e) => e.toMap()),
    };
  }

  static _PlaceResult fromJson(String value) {
    return _PlaceResult.fromMap(jsonDecode(value));
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class _PlaceFeature {
  _PlaceFeature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  final String? type;
  final _PlaceGeometry? geometry;
  final _PlaceProperties? properties;

  static const typeKey = 'type';
  static const geometryKey = 'geometry';
  static const propertiesKey = 'properties';

  static _PlaceFeature fromMap(Map<String, dynamic> value) {
    return _PlaceFeature(
      type: value[typeKey],
      geometry: _PlaceGeometry.fromMap(
        value[geometryKey].cast<String, dynamic>(),
      ),
      properties: _PlaceProperties.fromMap(
        value[propertiesKey].cast<String, dynamic>(),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      typeKey: type,
      geometryKey: geometry?.toMap(),
      propertiesKey: properties?.toMap(),
    };
  }
}

class _PlaceProperties {
  _PlaceProperties({
    required this.type,
    required this.name,
    required this.city,
    required this.osmId,
    required this.state,
    required this.extent,
    required this.street,
    required this.osmKey,
    required this.osmType,
    required this.country,
    required this.osmValue,
    required this.postcode,
    required this.district,
    required this.locality,
    required this.houseNumber,
    required this.countryCode,
  });

  final int? osmId;
  final String? osmKey;
  final String? osmType;
  final String? osmValue;

  final String? type;
  final String? name;
  final String? city;
  final String? state;
  final String? street;
  final String? postcode;
  final String? country;
  final String? locality;
  final String? district;

  final String? houseNumber;
  final String? countryCode;
  final List<double>? extent;

  static const osmIdKey = 'osm_id';
  static const osmKeyKey = 'osm_key';
  static const osmTypeKey = 'osm_type';
  static const osmValueKey = 'osm_value';

  static const typeKey = 'type';
  static const nameKey = 'name';
  static const cityKey = 'city';
  static const stateKey = 'state';
  static const streetKey = 'street';
  static const extentKey = 'extent';
  static const countryKey = 'country';
  static const postcodeKey = 'postcode';
  static const districtKey = 'district';
  static const localityKey = 'locality';
  static const houseNumberKey = 'housenumber';
  static const countryCodeKey = 'countrycode';

  static _PlaceProperties fromMap(Map<String, dynamic> value) {
    return _PlaceProperties(
      type: value[typeKey],
      name: value[nameKey],
      city: value[cityKey],
      osmId: value[osmIdKey],
      state: value[stateKey],
      osmKey: value[osmKeyKey],
      street: value[streetKey],
      country: value[countryKey],
      osmType: value[osmTypeKey],
      osmValue: value[osmValueKey],
      postcode: value[postcodeKey],
      district: value[districtKey],
      locality: value[localityKey],
      houseNumber: value[houseNumberKey],
      countryCode: value[countryCodeKey],
      extent: value[extentKey]?.cast<double>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      typeKey: type,
      nameKey: name,
      cityKey: city,
      osmIdKey: osmId,
      stateKey: state,
      osmKeyKey: osmKey,
      extentKey: extent,
      streetKey: street,
      osmTypeKey: osmType,
      countryKey: country,
      osmValueKey: osmValue,
      postcodeKey: postcode,
      districtKey: district,
      localityKey: locality,
      houseNumberKey: houseNumber,
      countryCodeKey: countryCode,
    };
  }
}

class _PlaceGeometry {
  _PlaceGeometry({
    required this.type,
    required this.coordinates,
  });

  final String? type;
  final List<double>? coordinates;

  static const typeKey = 'type';
  static const coordinatesKey = 'coordinates';

  static _PlaceGeometry fromMap(Map<String, dynamic> value) {
    return _PlaceGeometry(
      type: value[typeKey],
      coordinates: (value[coordinatesKey] as List?)?.map((e) => (e as num).toDouble()).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      typeKey: type,
      coordinatesKey: coordinates,
    };
  }
}
