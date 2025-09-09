//
//
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:ansicolor/ansicolor.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../../Utilities/shared_preferences.dart';
// import '../error/exceptions.dart';
// import '../network/error_message_model.dart';
//
// class RequestApi {
//   final Uri uri;
//   final Map<String, String> body;
//   final Map<String, dynamic> bodyJson;
//   final List<http.MultipartFile> files;
//   final Map<String, String>? headers;
//   final String method;
//
//   RequestApi.post({
//     required String url,
//     required this.body,
//     this.files = const [],
//     this.headers,
//   })  : method = "POST",
//         uri = Uri.parse(url),
//         bodyJson = {};
//   RequestApi.postJson({
//     required String url,
//     required this.bodyJson,
//     this.headers,
//   })  : method = "POST",
//         uri = Uri.parse(url),
//         files = [],
//         body = {};
//
//   RequestApi.postUri({
//     required this.uri,
//     this.bodyJson = const {},
//     this.body = const {},
//     this.files = const [],
//     this.headers,
//   })  : method = "POST" ;
//
//   RequestApi.put({
//     required String url,
//     required this.body,
//     this.files = const [],
//     this.headers,
//   })  : method = "PUT",
//         uri = Uri.parse(url),
//         bodyJson = {};
//   RequestApi.putJson({
//     required String url,
//     required this.bodyJson,
//     this.headers,
//   })  : method = "PUT",
//         uri = Uri.parse(url),
//         files = [],
//         body = {};
//
//   RequestApi.get({
//     required String url,
//     this.headers,
//   })  : method = "GET",
//         body = {},
//         files = [],
//         uri = Uri.parse(url),
//         bodyJson = {};
//   RequestApi.getUri({
//     required this.uri,
//     this.headers,
//   })  : method = "GET",
//         body = {},
//         files = [],
//         bodyJson = {};
//
//   RequestApi.delete({
//     required String url,
//     this.headers,
//   })  : method = "DELETE",
//         body = {},
//         files = [],
//         uri = Uri.parse(url),
//         bodyJson = {};
//   RequestApi.deleteUri({
//     required this.uri,
//     this.headers,
//   })  : method = "DELETE",
//         body = {},
//         files = [],
//         bodyJson = {};
//
//   RequestApi.customMethod({
//     required this.method,
//     this.bodyJson = const {},
//     required String url,
//     this.headers,
//     this.files = const [],
//     this.body = const {},
//   }) : uri = Uri.parse(url);
//   RequestApi.customMethodUri({
//     required this.method,
//     required this.uri,
//     this.bodyJson = const {},
//     this.headers,
//     this.files = const [],
//     this.body = const {},
//   });
//
//   Future<dynamic> requestFormUrlEncoded() async {
//     var request = http.Request(method, uri);
//
//     // الـ bodyFields مش body
//     request.bodyFields = body;
//
//     if (headers != null) request.headers.addAll(headers!);
//
//     return await _ApiBaseHelper.httpSendRequest(request, this);
//   }
//
//   Future<dynamic> request({bool getResponseBytes = false}) async {
//     debugPrint(uri.toString());
//     debugPrint(json.encode(body));
//     var request = http.MultipartRequest(method, uri);
//     if(body.isNotEmpty) request.fields.addAll(body);
//     request.files.addAll(files);
//     if (headers != null) request.headers.addAll(headers!);
//     return await _ApiBaseHelper.httpSendRequest(request,this,getResponseBytes: getResponseBytes);
//   }
//
//   Future<dynamic> requestJson({bool getResponseBytes = false}) async {
//     debugPrint(uri.toString());
//     debugPrint(json.encode(bodyJson));
//     var request = http.Request(method, uri);
//     request.body = json.encode(bodyJson);
//     if (headers != null) request.headers.addAll(headers!);
//     return await _ApiBaseHelper.httpSendRequest(request,this,getResponseBytes: getResponseBytes);
//   }
// }
//
// class _ApiBaseHelper {
//   static Future<dynamic> httpSendRequest(http.BaseRequest request,RequestApi requestApi,{bool getResponseBytes = false}) async {
//     http.StreamedResponse response;
//     try {
// // استخدم headers من request نفسه، لو مش موجودة ضيف الإفتراضي
//       request.headers.addAll({
//         if (!request.headers.containsKey('content-type'))
//           'content-type': 'application/json',
//
//         if (!request.headers.containsKey('Authorization'))
//          // "Authorization": 'Bearer ${SharedPref.getCurrentUser()?.token ?? ""}',
//
//         if (!request.headers.containsKey('access-language'))
//           "access-language": SharedPref.getLanguage() ?? "en",
//       });
//
//       // request.headers.addAll({
//       //   // 'Accept': '*/*',
//       //   'content-type': 'application/json',
//       //   "access-language": SharedPref.getLanguage() ?? "en",
//       //   "Authorization": 'sk_test_51RlIE8GaB6re3GlpFytquseARIby7iSRadWluakO7V0DQyfAsOh1vvX30td8hjie71UL9lxrpepdB3pKr470dYPp00mqdAMFDG'
//       //   //'Bearer ${SharedPref.getCurrentUser()?.token.toString()}',
//       // });
//
//       response = await request.send().timeout(const Duration(seconds: 180));
//       AnsiPen pen = AnsiPen()..green(bold: true);
//       debugPrint(pen("statusCode: ${response.statusCode}"));
//     } on SocketException {
//       throw ServerException(
//         errorMessageModel: ErrorMessageModel(
//           statusCode: 500,
//           statusMessage: "No Internet Connection",
//           requestApi: requestApi,
//         ),
//       );
//     } on FormatException {
//       throw ServerException(
//         errorMessageModel: ErrorMessageModel(
//           statusCode: 500,
//           statusMessage: "Bad Format",
//           requestApi: requestApi,
//         ),
//       );
//     } on Exception {
//       throw ServerException(
//         errorMessageModel: ErrorMessageModel(
//           statusCode: 500,
//           statusMessage: 'Unexpected error 😢',
//           requestApi: requestApi,
//         ),
//       );
//     }
//     if(getResponseBytes) return await response.stream.toBytes();
//     return _returnResponse(response,requestApi);
//   }
//
//   static Future<dynamic> _returnResponse(http.StreamedResponse response,RequestApi requestApi) async {
//     String resStream = await response.stream.bytesToString();
//     Map<String,dynamic> jsonResponse = {};
//
//     ServerException serverException({String? message}) => ServerException(
//       errorMessageModel: ErrorMessageModel(
//           statusCode: response.statusCode,
//           statusMessage: message,
//           requestApi: requestApi,
//           responseApi: jsonResponse
//       ),
//     );
//
//     try{
//       jsonResponse = jsonDecode(resStream) as Map<String,dynamic>;
//     }catch(e){
//       throw ServerException(
//         errorMessageModel: ErrorMessageModel(
//             statusCode: response.statusCode,
//             requestApi: requestApi,
//             responseApi: {"_THIS_KEY_FROM_APP_THERE_IS_NO_KEY_GETTING_":resStream}
//         ),
//       );
//     }
//     AnsiPen pen = AnsiPen()..green(bold: true);
//     debugPrint(pen("$jsonResponse"));
//
//     switch (response.statusCode) {
//       case 200:{
//         if (jsonResponse["success"] == false) {
//           throw serverException(message: jsonResponse["message"]);
//         }
//         return jsonResponse;
//       }
//       default: throw serverException(message: jsonResponse["message"]);
//     }
//   }
// }

// api_client.dart
import 'package:dio/dio.dart';
//import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../Utilities/shared_preferences.dart';
import '../error/exceptions.dart';
import '../network/error_message_model.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  late Dio _dio;

  ApiClient._internal() {
    _dio = Dio();
    _dio.options.baseUrl = "https://newsapi.org/v2/";
      //  "everything?q=tesla&from=2025-08-09&sortBy=publishedAt&apiKey=77ef2ede7d4c4255a48ef0c8ce9d93a7";
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );

    // اختياري: تسجيل الطلبات في الكونسول
    //  _dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));
  }

  // إضافة التوكن واللغة تلقائيًا
  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    final token = SharedPref.getCurrentUser()?.token;
    final lang = SharedPref.getCurrentLanguage() ?? "en";

    options.headers['Authorization'] = token != null ? 'Bearer $token' : null;
    options.headers['locale'] = lang;
    options.headers['Accept'] = 'application/json';

    // تأكد أن content-type يُحدد تلقائيًا (لا تجبره)
    // dio يحدد نوعه تلقائيًا حسب body

    handler.next(options);
  }
  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        if (data.containsKey("success") && data["success"] == false) {
          final requestInfo = {
            'method': response.requestOptions.method,
            'url': response.requestOptions.uri.toString(),
            'path': response.requestOptions.path,
            'queryParameters': response.requestOptions.queryParameters,
            'data': response.requestOptions.data,
          };

          final message = data["message"]?.toString() ?? "عملية فاشلة";

          handler.reject(
            DioException(
              error: ServerException(
                errorMessageModel: ErrorMessageModel(
                  statusCode: response.statusCode ?? 500,
                  statusMessage: message,
                  requestInfo: requestInfo,
                  responseApi: data,
                ),
              ),
              requestOptions: response.requestOptions,
            ),
          );
          return;
        }
      }
      handler.next(response);
    } on Exception {
      final requestInfo = {
        'method': response.requestOptions.method,
        'url': response.requestOptions.uri.toString(),
        'path': response.requestOptions.path,
        'data': response.requestOptions.data,
      };

      handler.reject(
        DioException(
          error: ServerException(
            errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode ?? 500,
              statusMessage: "فشل في تحليل الاستجابة",
              requestInfo: requestInfo,
              responseApi: response.data,
            ),
          ),
          requestOptions: response.requestOptions,
        ),
      );
    }
  }
  void _onError(DioException error, ErrorInterceptorHandler handler) {
    // ✅ إنشاء requestInfo يحتوي على كل المعلومات المهمة
    final requestInfo = {
      'method': error.requestOptions.method,
      'url': error.requestOptions.uri.toString(),
      'path': error.requestOptions.path,
      'queryParameters': error.requestOptions.queryParameters,
      'headers': error.requestOptions.headers,
      'data': error.requestOptions.data,
    };

    final responseApi = error.response?.data;
    final statusCode = error.response?.statusCode ?? 500;

    String statusMessage;

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      statusMessage = "انتهت مدة الاتصال";
    } else if (error.type == DioExceptionType.connectionError) {
      statusMessage = "لا يوجد اتصال بالإنترنت";
    } else {
      if (responseApi is Map) {
        statusMessage = (responseApi["message"] ?? responseApi["error"]?.toString())
            ?? ErrorMessageModel.getStatusCodeName(statusCode);
      } else {
        statusMessage = ErrorMessageModel.getStatusCodeName(statusCode);
      }
    }

    handler.reject(
      DioException(
        error: ServerException(
          errorMessageModel: ErrorMessageModel(
            statusCode: statusCode,
            statusMessage: statusMessage,
            requestInfo: requestInfo, // ✅ هنا
            responseApi: responseApi,
          ),
        ),
        requestOptions: error.requestOptions,
      ),
    );
  }
  // void _onResponse(Response response, ResponseInterceptorHandler handler) {
  //   // يمكنك تسجيل الاستجابة أو التعديل عليها
  //   handler.next(response);
  // }
  //
  // void _onError(DioException error, ErrorInterceptorHandler handler) {
  //   // توحيد التعامل مع الأخطاء
  //   if (error.type == DioExceptionType.connectionTimeout ||
  //       error.type == DioExceptionType.receiveTimeout) {
  //     handler.reject(
  //       DioException(
  //         error: ServerException(
  //           errorMessageModel: ErrorMessageModel(
  //             statusCode: 500,
  //             statusMessage: "انتهت مدة الاتصال",
  //           ),
  //         ),
  //         requestOptions: error.requestOptions,
  //       ),
  //     );
  //   } else if (error.type == DioExceptionType.connectionError) {
  //     handler.reject(
  //       DioException(
  //         error: ServerException(
  //           errorMessageModel: ErrorMessageModel(
  //             statusCode: 500,
  //             statusMessage: "لا يوجد اتصال بالإنترنت",
  //           ),
  //         ),
  //         requestOptions: error.requestOptions,
  //       ),
  //     );
  //   } else {
  //     // خطأ من السيرفر
  //     final statusCode = error.response?.statusCode ?? 500;
  //     final message = (error.response?.data as Map<String, dynamic>?)?["message"]?.toString()
  //         ?? "حدث خطأ غير متوقع";
  //
  //     handler.reject(
  //       DioException(
  //         error: ServerException(
  //           errorMessageModel: ErrorMessageModel(
  //             statusCode: statusCode,
  //             statusMessage: message,
  //             responseApi: error.response?.data,
  //           ),
  //         ),
  //         requestOptions: error.requestOptions,
  //       ),
  //     );
  //   }
  // }


  // Future<Response> postFormUrlEncoded(String path, {Map<String, dynamic>? data}) {
  //   return _dio.post(
  //     path,
  //     data,
  //     options: Options(contentType: 'application/x-www-form-urlencoded'),
  //   );
  // }
  // طرق الاختصار
  Future<Response> get(String path, {Map<String, dynamic>? query, Options? options}) {
    return _dio.get(path, queryParameters: query, options: options);
  }

  Future<Response> post(String path, {dynamic data, Options? options}) {
    return _dio.post(path,
        data: data,
        options: options);
  }

  Future<Response> put(String path, {dynamic data, Options? options}) {
    return _dio.put(path,
        data:data, options: options);
  }
// في api_client.dart
  Future<Response> postFormUrlEncoded(String path, {Map<String, dynamic>? data}) {
    return _dio.post(
      path,
      data: data,
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );
  }

  Future<Response> delete(String path, {Options? options}) {
    return _dio.delete(path, options: options);
  }

  // للرفع مع تقدم
  Future<Response> postFormData(
      String path,
      Map<String, dynamic> formData, {
        void Function(int sent, int total)? onSendProgress,
      }) async {
    final formDataDio = FormData.fromMap(formData);
    return _dio.post(
      path,
      data:formDataDio,
      onSendProgress: onSendProgress,
    );
  }
}