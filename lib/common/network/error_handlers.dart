import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hele_app/common/flavors/build_config.dart';
import 'package:hele_app/common/network/exceptions/api_exception.dart';
import 'package:hele_app/common/network/exceptions/app_exception.dart';
import 'package:hele_app/common/network/exceptions/network_exception.dart';
import 'package:hele_app/common/network/exceptions/not_found_exception.dart';
import 'package:hele_app/common/network/exceptions/service_unavailable_exception.dart';

Exception handleError(String error) {
  final logger = BuildConfig.instance.config.logger;
  logger.e("Generic exception: $error");

  return AppException(message: error);
}

Exception handleDioError(DioException dioError) {
  switch (dioError.type) {
    case DioExceptionType.cancel:
      return AppException(message: "对 API 服务器的请求已取消");
    case DioExceptionType.connectionTimeout:
      return AppException(message: "与 API 服务器的连接超时");
    case DioExceptionType.connectionError:
      return NetworkException("没有互联网连接");
    case DioExceptionType.receiveTimeout:
      return TimeoutException("与 API 服务器连接的接收超时");
    case DioExceptionType.sendTimeout:
      return TimeoutException("与 API 服务器连接的发送超时");
    case DioExceptionType.badResponse:
      return _parseDioErrorResponse(dioError);
    case DioExceptionType.badCertificate:
      return AppException(message: '证书错误');
    case DioExceptionType.unknown:
      return NetworkException("没有互联网连接");
  }
}

Exception _parseDioErrorResponse(DioException dioError) {
  final logger = BuildConfig.instance.config.logger;

  int statusCode = dioError.response?.statusCode ?? -1;
  String? status;
  String? serverMessage;

  try {
    if (statusCode == -1 || statusCode == HttpStatus.ok) {
      statusCode = dioError.response?.data["statusCode"];
    }
    status = dioError.response?.data["status"];
    serverMessage = dioError.response?.data["message"];
  } catch (e, s) {
    logger.i("$e");
    logger.i(s.toString());

    serverMessage = "Something went wrong. Please try again later.";
  }

  switch (statusCode) {
    case HttpStatus.serviceUnavailable:
      return ServiceUnavailableException("Service Temporarily Unavailable");
    case HttpStatus.notFound:
      return NotFoundException(serverMessage ?? "", status ?? "");
    default:
      return ApiException(
          httpCode: statusCode,
          status: status ?? "",
          message: serverMessage ?? "");
  }
}
