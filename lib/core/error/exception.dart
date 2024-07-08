import 'package:dio/dio.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/error/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}


void handelDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.sendTimeout:
        ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.receiveTimeout:
        ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.badCertificate:
        ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.cancel:
        ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.connectionError:
        ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.unknown:
        ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400: // bad request
    
          case 401: // unauthorized
            ServerException(
                errorModel: ErrorModel.fromJson(e.response!.data));
          case 403: // forbidden
            ServerException(
                errorModel: ErrorModel.fromJson(e.response!.data));
          case 404: // not found
            ServerException(
                errorModel: ErrorModel.fromJson(e.response!.data));
          case 409: // cofficient
            ServerException(
                errorModel: ErrorModel.fromJson(e.response!.data));
          case 422: // unprocessable
            ServerException(
                errorModel: ErrorModel.fromJson(e.response!.data));
          case 504: // server exception
            ServerException(
                errorModel: ErrorModel.fromJson(e.response!.data));
        }
    }
        
  }
