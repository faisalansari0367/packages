import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest() = UnauthorisedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound() = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions =
            const NetworkExceptions.unexpectedError();
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioErrorType.connectTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioErrorType.other:
              if (error.toString().contains("SocketException")) {
                networkExceptions =
                    const NetworkExceptions.noInternetConnection();
              } else {
                networkExceptions = const NetworkExceptions.unexpectedError();
              }

              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.response:
              // final Map<String, dynamic> errorModel = jsonDecode(error.response!.toString());
              // networkExceptions = NetworkExceptions.defaultError(error.response!.statusCode.toString());
              switch (error.response!.statusCode) {
                case 400:
                  final map = json.decode(error.response!.toString()) as Map;
                  if (map.containsKey('message')) {
                    networkExceptions =
                        NetworkExceptions.defaultError(map['message']);
                  } else {
                    networkExceptions =
                        const NetworkExceptions.unauthorisedRequest();
                  }
                  break;
                case 401:
                  networkExceptions =
                      const NetworkExceptions.unauthorisedRequest();
                  // if (error.response?.realUri.toString().contains(EndPoints.log_out_user) == false)
                  //   BaseModel().logout();
                  break;
                // case 403:
                //   networkExceptions = NetworkExceptions.unauthorisedRequest();
                // break;
                case 404:
                  networkExceptions = parseErrorMsg(error.response) ??
                      const NetworkExceptions.notFound();
                  break;
                case 409:
                  networkExceptions = const NetworkExceptions.conflict();
                  break;
                case 408:
                  networkExceptions = const NetworkExceptions.requestTimeout();
                  break;
                case 417:
                  try {
                    Map<String, dynamic> errorModel =
                        jsonDecode(error.response!.toString());

                    if (errorModel["message"] is String) {
                      networkExceptions =
                          NetworkExceptions.defaultError(errorModel["message"]);
                    } else if (errorModel["message"] is Map) {
                      networkExceptions = NetworkExceptions.defaultError(
                          errorModel["message"]["message"]);
                    }
                  } catch (e) {
                    networkExceptions = const NetworkExceptions.defaultError(
                        "Unexpected error occurred");
                  }
                  break;
                case 429:
                  networkExceptions = NetworkExceptions.defaultError(
                      error.response?.data ?? 'Too many requests');
                  break;
                case 422:
                  final map = error.response?.data as Map;
                  if (map.containsKey('errors')) {
                    final errors = map['errors'] as Map;
                    String error = '';
                    errors.forEach((key, value) {
                      if (value is List) {
                        for (var element in value) {
                          error += '$element\n';
                        }
                      } else if (value is String) {
                        error += '$value\n';
                      } else {
                        error += '${value.toString()}\n';
                      }
                    });
                    networkExceptions = NetworkExceptions.defaultError(error);
                  } else {
                    networkExceptions = NetworkExceptions.defaultError(
                        error.response?.data ?? 'Something went wrong');
                  }

                  break;
                case 444:
                  // EasyLoading.show(status:"Please wait...");
                  // BaseModel().logout();
                  try {
                    Map<String, dynamic> errorModel =
                        jsonDecode(error.response!.toString());
                    networkExceptions =
                        NetworkExceptions.defaultError(errorModel["message"]);
                  } catch (e) {
                    networkExceptions = const NetworkExceptions.defaultError(
                        "Unexpected error occurred");
                  }
                  break;

                case 500:
                  final map = error.response?.data as Map;
                  if (map.containsKey('message')) {
                    networkExceptions = NetworkExceptions.defaultError(
                        map['message'] ?? 'Something went wrong');
                  } else {
                    networkExceptions = const NetworkExceptions
                        .internalServerError(); //NetworkExceptions.defaultError(error.response?.data ?? 'Something went wrong');
                  }

                  break;
                case 503:
                  networkExceptions =
                      const NetworkExceptions.serviceUnavailable();
                  break;
                default:
                  // var responseCode = error.response!.statusCode;
                  // "JOJO s 1212:- " + error.response["message"]);
                  try {
                    Map<String, dynamic> errorModel =
                        jsonDecode(error.response!.toString());
                    networkExceptions =
                        NetworkExceptions.defaultError(errorModel["message"]);
                  } catch (e) {
                    networkExceptions = const NetworkExceptions.defaultError(
                        "Unexpected error occurred");
                  }
              }
              break;
            default:
              networkExceptions = const NetworkExceptions.defaultError(
                  "Unexpected error occurred");
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      // if (error is TypeError) {
      final logger = Logger();
      logger.wtf(error);
      logger.e(error.stackTrace);
      // }
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static NetworkExceptions? parseErrorMsg(Response? response) {
    NetworkExceptions? networkExceptions;
    final map = response?.data as Map;
    if (map.containsKey('message')) {
      networkExceptions = NetworkExceptions.defaultError(
          map['message'] ?? 'Something went wrong');
    }
    return networkExceptions;
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(notImplemented: () {
      errorMessage = "Not Implemented";
    }, requestCancelled: () {
      errorMessage = "Request Cancelled";
    }, internalServerError: () {
      errorMessage = "Internal Server Error";
    }, notFound: () {
      errorMessage = "Not found";
    }, serviceUnavailable: () {
      errorMessage = "Server maintainence underway\nPlease try again later.";
    }, methodNotAllowed: () {
      errorMessage = "Method Allowed";
    }, badRequest: () {
      errorMessage = "Bad request";
    }, unauthorisedRequest: () {
      errorMessage = "Unauthorised request";
    }, unexpectedError: () {
      errorMessage = "Unexpected error occurred";
    }, requestTimeout: () {
      errorMessage = "Connection request timeout";
    }, noInternetConnection: () {
      errorMessage = "No internet connection";
    }, conflict: () {
      errorMessage = "Error due to a conflict";
    }, sendTimeout: () {
      errorMessage = "Send timeout in connection with API server";
    }, unableToProcess: () {
      errorMessage = "Unable to process the data";
    }, defaultError: (String error) {
      errorMessage = error;
    }, formatException: () {
      errorMessage = "Unexpected error occurred";
    }, notAcceptable: () {
      errorMessage = "Not acceptable";
    });
    return errorMessage;
  }
}
