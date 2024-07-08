import 'package:dio/dio.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/api/api_consumer.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/error/exception.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio});
  @override
  Future<dynamic> delete(
      String path, Object? data, Map<String, String>? queryParameters) async {
    try {
      final response =
          await dio.delete(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future<dynamic> get(
      String path, Object? data, Map<String, String>? queryParameters) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<dynamic> patch(
      String path, Object? data, Map<String, String>? queryParameters) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<dynamic> post(
      String path, Object? data, Map<String, String>? queryParameters) {
    // TODO: implement post
    throw UnimplementedError();
  }
}
