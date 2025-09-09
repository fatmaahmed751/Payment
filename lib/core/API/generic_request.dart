// generic_request_dio.dart
import 'dart:typed_data';
import 'package:Payment/core/API/request_method.dart';
import '../../Utilities/git_it.dart';
import '../error/exceptions.dart';
import '../network/error_message_model.dart';
import 'package:dio/dio.dart';
abstract interface class ModelValidation {
  String? validate();
}

// class GenericRequest<T> {
//   final T Function(Map<String, dynamic>) fromMap;
//   final ApiClient client;
//   final String path;
//   final RequestMethod method;
//   final Map<String, dynamic>? query;
//   final dynamic body;
//   final Map<String, dynamic>? headers;
//   final bool useFormData; // هل نستخدم FormData؟
//   final void Function(int, int)? onSendProgress; // للرفع فقط
//
//   GenericRequest({
//     required this.fromMap,
//     required this.client,
//     required this.path,
//     this.method = RequestMethod.GET,
//     this.query,
//     this.body,
//     this.headers,
//     this.useFormData = false,
//     this.onSendProgress,
//   });
// // generic_request_dio.dart
//
//   import 'package:your_app/core/dependency_injection/git_it.dart'; // استيراد GitIt

  class GenericRequest<T> {
    final T Function(Map<String, dynamic>) fromMap;
    final ApiClient client; // هيبقى مخزن من GetIt إذا ما تم تمريره
    final String path;
    final RequestMethod method;
    final Map<String, dynamic>? query;
    final dynamic body;
    final bool useFormUrlEncoded;
    final Map<String, dynamic>? headers;
    final bool useFormData;
    final void Function(int, int)? onSendProgress;

    GenericRequest({
      required this.fromMap,
      ApiClient? client, // أصبح اختياري
      required this.path,
      this.method = RequestMethod.GET,
      this.query,
      this.useFormUrlEncoded = false,
      this.body,
      this.headers,
      this.useFormData = false,
      this.onSendProgress,
    }) : client = client ?? GitIt.instance<ApiClient>(); // ⬅️ هنا السحر!


    // دالة مساعدة لإنشاء خطأ
    ServerException errorModel(dynamic response,
        String message,
        ExpectType expectType,) {
      final requestInfo = {
        'method': method.name, // ممكن تجي من الـ GenericRequest لو حطيته
        'path': path,
        'data': body,
      };
      return ServerException(
        errorMessageModel: ErrorMessageModel.parsing(
          modelName: T.toString(),
          expectType: expectType,
          statusMessage: message,
          responseApi: response,
          requestInfo:requestInfo
        ),
      );
    }

    // جلب كائن واحد: response.data.data
    Future<T> getObject() async {
      try {
        final response = await _sendRequest();
        final data = response.data;

        // تحقق من وجود data
        if (data is! Map || !data.containsKey("data")) {
          throw errorModel(
              data, "البيانات غير متوفرة أو غير صحيحة", ExpectType.object);
        }

        final Map<String, dynamic> apiData = data["data"];
        final result = fromMap(apiData);

        if (result is ModelValidation) {
          final validateError = result.validate();
          if (validateError != null) {
            throw errorModel(data, validateError, ExpectType.object);
          }
        }

        return result;
      } on DioException catch (e) {
        // تم التعامل معه في Interceptor، لكن نعيد رمي الـ ServerException
        if (e.error is ServerException) rethrow;
        rethrow;
      } catch (e) {
        throw errorModel(null, e.toString(), ExpectType.object);
      }
    }

    // جلب قائمة
    Future<List<T>> getList() async {
      try {
        final response = await _sendRequest();
        final data = response.data;

        final List<dynamic>? list = () {
          if (data is Map && data.containsKey("data")) {
            if (data["data"] is List) return data["data"].cast();
            if (data["data"] is Map && data["data"]["data"] is List) {
              return data["data"]["data"].cast();
            }
          }
          return null;
        }();

        if (list == null) {
          throw errorModel(data, "البيانات ليست قائمة", ExpectType.list);
        }

        final resultList = list.map((e) => fromMap(e as Map<String, dynamic>))
            .toList();

        if (T is ModelValidation) {
          for (final item in resultList) {
            final error = (item as ModelValidation).validate();
            if (error != null) {
              throw errorModel(data, error, ExpectType.list);
            }
          }
        }

        return resultList;
      } on DioException catch (e) {
        if (e.error is ServerException) rethrow;
        rethrow;
      }
    }

    // جلب الرد كاملاً (مثلاً token)
    Future<T> getResponse() async {
      try {
        final response = await _sendRequest();
        final result = fromMap(response.data);
        if (result is ModelValidation) {
          final error = result.validate();
          if (error != null) {
            throw errorModel(response.data, error, ExpectType.other);
          }
        }
        return result;
      } on DioException catch (e) {
        if (e.error is ServerException) rethrow;
        rethrow;
      }
    }

    // جلب ملف كبايتات
    Future<Uint8List> getBytes() async {
      try {
        final options = Options(responseType: ResponseType.bytes);
        final response = await client.get(path, options: options);
        return Uint8List.fromList(response.data);
      } on DioException catch (e) {
        if (e.error is ServerException) rethrow;
        throw errorModel(
            null, e.message ?? "فشل تحميل الملف", ExpectType.other);
      }
    }

    // إرسال الطلب فعليًا
    Future<Response> _sendRequest() async {
      switch (method) {
        case RequestMethod.GET:
          return client.get(path, query: query);
        case RequestMethod.POST:
          if (useFormData && onSendProgress != null) {
            return client.postFormData(
                path, body ?? {}, onSendProgress: onSendProgress);
          } else if (useFormData) {
            return client.postFormData(path, body ?? {});
          } else if (useFormUrlEncoded) {
            return client.postFormUrlEncoded(path, data: body);
          } else {
            return client.post(path, data: body);
          }
        case RequestMethod.PUT:
          return client.put(path, data: body);
        case RequestMethod.DELETE:
          return client.delete(path);
      }
    }

  }
enum RequestMethod { GET, POST, PUT, DELETE }
// import 'dart:typed_data';
//
// import '../API/request_method.dart';
// import '../error/exceptions.dart';
// import '../network/error_message_model.dart';
//
// abstract interface class ModelValidation{
//   String? validate();
// }
//
// class GenericRequest<T> {
//   T Function(Map<String, dynamic> json) fromMap;
//   RequestApi method;
//
//   GenericRequest({required this.fromMap, required this.method});
//
//   ServerException errorModel(dynamic response,String statusMessage,ExpectType expectType)=> ServerException(
//       errorMessageModel: ErrorMessageModel.parsing(
//         modelName: T.toString(),
//         expectType: expectType,
//         requestApi: method,
//         responseApi: response,
//         statusMessage: statusMessage,
//       )
//   );
//   Future<T> getObject({bool asFormUrlEncoded = false}) async {
//     dynamic response;
//
//     try {
//       // تحديد طريقة الإرسال
//       if (asFormUrlEncoded) {
//         response = await method.requestFormUrlEncoded();
//       } else {
//         response = method.bodyJson.isNotEmpty
//             ? await method.requestJson()
//             : await method.request();
//       }
//
//       // لو الرد فيه "Data"، خديه، غير كده سيبي الرد زي ما هو
//       if (response is Map && response.containsKey("Data")) {
//         response = response["Data"];
//       }
//
//       // تحقق إن الاستجابة عبارة عن Map
//       if (response is! Map) {
//         throw errorModel(response, "data is not compatible with expected data", ExpectType.object);
//       }
//
//       try {
//         T result = fromMap(Map<String, dynamic>.from(response));
//         if (result is ModelValidation) {
//           String? validateError = result.validate();
//           if (validateError != null) {
//             throw errorModel(response, validateError, ExpectType.object);
//           }
//         }
//
//         return result;
//       } catch (e) {
//         throw errorModel(response, e.toString(), ExpectType.object);
//       }
//
//     } catch (e) {
//       throw errorModel(response, e.toString(), ExpectType.object);
//     }
//   }
//
//
//
//
//
//   Future<List<T>> getList() async {
//     Map<String, dynamic> response;
//     if (method.body.isNotEmpty) {
//       response = await method.request();
//     } else {
//       response = await method.requestJson();
//     }
//     if (!(response["Data"] is List || response["Data"]["Data"] is List)) throw errorModel(response,"data is not compatible with expected data",ExpectType.list);
//     final responseList = (response["Data"] is List)? response["Data"] : response["Data"]["Data"];
//     try{
//       List<T> resultList =  List<T>.from(responseList.map((e) => fromMap(e)));
//       if(T is ModelValidation){
//         for (var item in resultList) {
//           String? validateError = (item as ModelValidation).validate();
//           if(validateError!=null) throw errorModel(response,validateError,ExpectType.list);
//         }
//       }
//       return resultList;
//     }catch(e){
//       throw errorModel(response,e.toString(),ExpectType.object);
//     }
//   }
//
//   Future<T> getResponse() async {
//     Map<String, dynamic> response;
//     if (method.body.isNotEmpty || method.files.isNotEmpty){
//       response = await method.request();
//     } else {
//       response = await method.requestJson();
//     }
//
//     try{
//       T result = fromMap(response);
//       if(T is ModelValidation){
//         String? validateError = (result as ModelValidation).validate();
//         if(validateError!=null) throw errorModel(response,validateError,ExpectType.other);
//       }
//       return result;
//     }catch(e){
//       throw errorModel(response,e.toString(),ExpectType.other);
//     }
//   }
//   Future<Uint8List> getResponseBytes() async {
//     dynamic response;
//     if (method.body.isNotEmpty  || method.files.isNotEmpty) {
//       response = await method.request(getResponseBytes: true);
//     } else {
//       response = await method.requestJson(getResponseBytes: true);
//     }
//     try{
//       return response;
//     }catch(e){
//       throw errorModel(response,e.toString(),ExpectType.other);
//     }
//   }
// }

// Future<T> getObject() async {
//   Map<String, dynamic> response;
//   if (method.body.isNotEmpty) {
//     response = await method.request();
//   } else {
//     response = await method.requestJson();
//   }
//   if (response["Data"] is! Map) {
//     throw errorModel(response,"data is not compatible with expected data",ExpectType.object);
//   }
//   try{
//     T result = fromMap(response["Data"]);
//     if(T is ModelValidation){
//       String? validateError = (result as ModelValidation).validate();
//       if(validateError!=null) throw errorModel(response,validateError,ExpectType.object);
//     }
//     return result;
//   }catch(e){
//     throw errorModel(response,e.toString(),ExpectType.object);
//   }
// }