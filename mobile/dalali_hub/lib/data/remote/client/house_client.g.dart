// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _HouseClient implements HouseClient {
  _HouseClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'api/v1/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<JSendResponse<HouseResponseDto>>> getHouses() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<JSendResponse<HouseResponseDto>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'houses',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = JSendResponse<HouseResponseDto>.fromJson(
      _result.data!,
      (json) => HouseResponseDto.fromJson(json as Map<String, dynamic>),
    );
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<JSendResponse<EmptyResponse>>> addHouse({
    required String title,
    required double minPrice,
    required double maxPrice,
    required double rooms,
    required double beds,
    required double baths,
    required double kitchens,
    required double size,
    required String sizeUnit,
    required List<String> otherFeatures,
    required String description,
    required bool isApproved,
    required String category,
    required LocationDto location,
    required List<File?> photos,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'title',
      title,
    ));
    _data.fields.add(MapEntry(
      'minPrice',
      minPrice.toString(),
    ));
    _data.fields.add(MapEntry(
      'maxPrice',
      maxPrice.toString(),
    ));
    _data.fields.add(MapEntry(
      'rooms',
      rooms.toString(),
    ));
    _data.fields.add(MapEntry(
      'beds',
      beds.toString(),
    ));
    _data.fields.add(MapEntry(
      'baths',
      baths.toString(),
    ));
    _data.fields.add(MapEntry(
      'kitchens',
      kitchens.toString(),
    ));
    _data.fields.add(MapEntry(
      'size',
      size.toString(),
    ));
    _data.fields.add(MapEntry(
      'sizeUnit',
      sizeUnit,
    ));
    otherFeatures.forEach((i) {
      _data.fields.add(MapEntry('otherFeatures', i));
    });
    _data.fields.add(MapEntry(
      'description',
      description,
    ));
    _data.fields.add(MapEntry(
      'isApproved',
      isApproved.toString(),
    ));
    _data.fields.add(MapEntry(
      'category',
      category,
    ));
    _data.fields.add(MapEntry(
      'location',
      jsonEncode(location),
    ));
    _data.files.addAll(photos.map((i) => MapEntry(
        'photos',
        MultipartFile.fromFileSync(
          i.path,
          filename: i.path.split(Platform.pathSeparator).last,
        ))));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<JSendResponse<EmptyResponse>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'houses',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = JSendResponse<EmptyResponse>.fromJson(
      _result.data!,
      (json) => EmptyResponse.fromJson(json as Map<String, dynamic>),
    );
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
