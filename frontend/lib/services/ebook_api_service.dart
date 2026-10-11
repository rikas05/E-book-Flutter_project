import 'package:dio/dio.dart';
import '../models/ebook.dart';

class EbookApiService {
  static const String baseUrl = 'http://192.168.137.1';
  late Dio _dio;

  EbookApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: 'application/json',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }

  // GET all ebooks with optional filtering
  Future<List<Ebook>> getEbooks({String? title, String? author}) async {
    try {
      final params = <String, dynamic>{};
      if (title != null && title.isNotEmpty) params['title'] = title;
      if (author != null && author.isNotEmpty) params['author'] = author;

      final response = await _dio.get(
        '/ebooks',
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((e) => Ebook.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load ebooks');
      }
    } on DioException catch (e) {
      throw Exception('Error fetching ebooks: ${e.message}');
    }
  }

  // GET single ebook by id
  Future<Ebook> getEbook(int id) async {
    try {
      final response = await _dio.get('/ebooks/$id');

      if (response.statusCode == 200) {
        return Ebook.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load ebook');
      }
    } on DioException catch (e) {
      throw Exception('Error fetching ebook: ${e.message}');
    }
  }

  // POST create new ebook with file upload
  Future<Ebook> createEbook(Ebook ebook, String filePath) async {
    try {
      FormData formData = FormData.fromMap({
        'ebook': {
          'title': ebook.title,
          'author': ebook.author,
          'description': ebook.description,
          'file': await MultipartFile.fromFile(filePath, filename: ebook.title + '.pdf'),
        },
      });

      final response = await _dio.post(
        '/ebooks',
        data: formData,
      );

      if (response.statusCode == 201) {
        return Ebook.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to create ebook');
      }
    } on DioException catch (e) {
      throw Exception('Error creating ebook: ${e.message}');
    }
  }

  // PATCH/PUT update ebook
  Future<Ebook> updateEbook(int id, Ebook ebook) async {
    try {
      final response = await _dio.patch(
        '/ebooks/$id',
        data: ebook.toJson(),
      );

      if (response.statusCode == 200) {
        return Ebook.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to update ebook');
      }
    } on DioException catch (e) {
      throw Exception('Error updating ebook: ${e.message}');
    }
  }

  // DELETE ebook
  Future<void> deleteEbook(int id) async {
    try {
      final response = await _dio.delete('/ebooks/$id');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete ebook');
      }
    } on DioException catch (e) {
      throw Exception('Error deleting ebook: ${e.message}');
    }
  }

  // Search ebooks
  Future<List<Ebook>> searchEbooks({String? title, String? author}) async {
    try {
      final params = <String, dynamic>{};
      if (title != null && title.isNotEmpty) params['title'] = title;
      if (author != null && author.isNotEmpty) params['author'] = author;

      final response = await _dio.get(
        '/ebooks/search',
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((e) => Ebook.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to search ebooks');
      }
    } on DioException catch (e) {
      throw Exception('Error searching ebooks: ${e.message}');
    }
  }

  // Download ebook
  Future<void> downloadEbook(int id, String savePath) async {
    try {
      await _dio.download(
        '/ebooks/$id/download',
        savePath,
      );
    } on DioException catch (e) {
      throw Exception('Error downloading ebook: ${e.message}');
    }
  }
}
