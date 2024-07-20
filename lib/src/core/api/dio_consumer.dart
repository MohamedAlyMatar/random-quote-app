import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:quotes/src/core/api/api_consumer.dart';
import 'package:quotes/src/core/api/app_interceptor.dart';
import 'package:quotes/src/core/api/endpoint.dart';
import 'package:quotes/src/core/api/status_codes.dart';
import 'package:quotes/injection_container.dart' as di;
import 'package:quotes/src/core/errors/exceptions.dart';
import 'package:quotes/src/features/random_quote/data/models/quote_model.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCodes.internalServerError;
      };

    client.interceptors.add(di.sl<AppInterceptor>());
    client.interceptors.add(di.sl<LogInterceptor>());
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    // final responseJson = jsonDecode(response.data.toString());
    // return responseJson;

    final List<dynamic> jsonList = json.decode(response.data.toString());
    final randomIndex = Random().nextInt(jsonList.length);
    final randomQuoteJson = jsonList[randomIndex];
    return randomQuoteJson;
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
        bool formDataIsEnabled = false,
        Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.post(path,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
        Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
      await client.put(path, queryParameters: queryParameters, data: body);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }


  dynamic _handleDioError(DioException error) {
    switch (DioExceptionType.badCertificate) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCodes.badRequest:
            throw const BadRequestException();
          case StatusCodes.unAuthorized:
          case StatusCodes.forbidden:
            throw const UnauthorizedException();
          case StatusCodes.notFound:
            throw const NotFoundException();
          case StatusCodes.conflict:
            throw const ConflictException();

          case StatusCodes.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
        throw const NoInternetConnectionException();
      case DioExceptionType.unknown:
        throw const NoInternetConnectionException();
      case DioExceptionType.badCertificate:
    }
  }
}
