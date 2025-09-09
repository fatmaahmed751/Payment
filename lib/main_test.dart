import 'package:dio/dio.dart';

import 'core/API/request_method.dart';

void main() async {
  final client = ApiClient();

  try {
    final response = await client.get(
      "everything",
      query: {
        "q": "tesla",
        "from": "2024-08-09", // ⚠️ تاريخ في المستقبل! غيّره لـ تاريخ سابق
        "sortBy": "publishedAt",
        // apiKey هيتضاف تلقائيًا من الـ interceptor
      },
    );

    // ✅ طباعة الرد في الكونسول
    print("✅ Response Data:");
    print(response.data);

    // لو عاوزة تطبع عدد الأخبار مثلاً
    if (response.data is Map && response.data.containsKey('articles')) {
      final articles = response.data['articles'] as List;
      print('📰 عدد الأخبار: ${articles.length}');
    }

  } on DioException catch (e) {
    print("❌ Error: ${e.message}");
    if (e.response != null) {
      print("Status Code: ${e.response?.statusCode}");
      print("Response Data: ${e.response?.data}");
    }
  } catch (e) {
    print("❌ Unexpected Error: $e");
  }
}