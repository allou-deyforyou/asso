import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_less/flutter_less.dart';

import '_service.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();
  @override
  List<Object?> get props => List.empty();
}

class InitialPlaceState extends PlaceState {
  const InitialPlaceState();
}

class PendingPlaceState extends PlaceState {
  const PendingPlaceState();
}

class FailurePlaceState extends PlaceState {
  const FailurePlaceState({
    required this.message,
  });
  final String message;
  @override
  List<Object?> get props => [message];
}

class ItemPlaceState extends PlaceState {
  const ItemPlaceState({required this.data});
  final PlaceSchema data;
  @override
  List<Object?> get props => [data];
}

class ItemListPlaceState extends PlaceState {
  const ItemListPlaceState({required this.data});
  final List<PlaceSchema> data;
  @override
  List<Object?> get props => [data];
}

class PlaceService extends LessService<PlaceState> {
  PlaceService([super.value = const InitialPlaceState()]);

  static CancelToken? _cancelToken;
  Future<void> queryPlaces({
    bool isGeocoding = true,
    // Expected format is minLon,minLat,maxLon,maxLat.
    List<double>? boundingBox,
    // Expected values are house , street, locality, district, city, county, state, country
    List<String>? layers,
    List<String>? queryStringFilter,
    double? locationBiasScale,
    bool? debug = kDebugMode,
    List<String>? osmTags,
    bool? distanceSort,
    double? longitude,
    double? latitude,
    String? language,
    double? radius,
    String? query,
    int? limit,
    int? zoom,
  }) async {
    final List<String> values = List<String>.empty(growable: true);
    if (isGeocoding) {
      values.add('lang=$language');
    }
    if (query != null) {
      values.add('q=$query');
    }
    if (zoom != null) {
      values.add('zoom=$zoom');
    }
    if (debug != null) {
      values.add('debug=$debug');
    }
    if (limit != null) {
      values.add('limit=$limit');
    }
    if (radius != null) {
      values.add('radius=$radius');
    }
    if (distanceSort != null) {
      values.add('distance_sort=$distanceSort');
    }
    if (longitude != null && latitude != null) {
      values.add('lat=$latitude&lon=$longitude');
    }
    if (isGeocoding) {
      values.add("bbox=${boundingBox?.join(',')}");
    }
    if (layers != null) {
      values.add(layers.map((e) => 'layer=$e').join('&'));
    }
    if (locationBiasScale != null) {
      values.add('location_bias_scale=$locationBiasScale');
    }
    if (osmTags != null) {
      values.add(osmTags.map((e) => 'osm_tag=$e').join('&'));
    }
    if (queryStringFilter != null) {
      values.add(queryStringFilter.map((e) => 'query_string_filter=$e').join('&'));
    }
    final String params = values.join('&');
    final String path = isGeocoding ? 'api' : 'reverse';
    final String url = 'https://photon.komoot.io/$path?$params';
    try {
      emit(const PendingPlaceState());
      if (isGeocoding) _cancelToken?.cancel();
      final CancelToken? cancelToken = isGeocoding ? _cancelToken = CancelToken() : null;
      final Response<String> response = await Dio().get<String>(url, cancelToken: cancelToken);
      final List<PlaceSchema> data = await compute(PlaceSchema.fromRawJsonList, response.data!);
      emit(ItemListPlaceState(data: data));
    } on DioError catch (error) {
      switch (error.type) {
        case DioErrorType.cancel:
          emit(const PendingPlaceState());
          break;
        case DioErrorType.connectionError:
        case DioErrorType.connectionTimeout:
          emit(FailurePlaceState(message: error.toString()));
          break;
        default:
          emit(FailurePlaceState(message: error.toString()));
      }
    } catch (error) {
      emit(FailurePlaceState(message: error.toString()));
    }
  }
}
