// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'package:agenda_front/src/services/local_storage.dart';
import 'package:dio/dio.dart';

class ServerConnection {
  static final Dio _dio = Dio();

  static void configureDio() {
    // Base del url
    _dio.options.baseUrl = 'http://localhost:8080/api';
    // Configurar Headers

    // _dio.options.headers = {
    //   'Accept': 'application/json',
    //   'Content-Type': 'application/json',
    //   'Authorization': LocalStorage.prefs.containsKey('token') &&
    //           LocalStorage.prefs.getString('token') != null
    //       ? 'Bearer ${LocalStorage.prefs.getString('token')}'
    //       : null
    // };

    _dio.options.headers = {
      'Authorization': LocalStorage.prefs.containsKey('token') &&
              LocalStorage.prefs.getString('token') != null
          ? 'Bearer ${LocalStorage.prefs.getString('token')}'
          : null
    };
  }

  static Future httpGet(String path) async {
    configureDio();
    try {
      final resp = await _dio.get(path);
      return resp.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future httpPost(String path, Map<String, dynamic> data) async {
    configureDio();
    try {
      final response = await _dio.post(path, data: await _request(data));
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future httpPut(String path, Map<String, dynamic> data) async {
    configureDio();
    try {
      final response = await _dio.put(path, data: await _request(data));
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future httpDelete(String path, Map<String, dynamic> data) async {
    configureDio();
    final formData = FormData.fromMap(data);
    try {
      final response = await _dio.delete(path, data: formData);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static _request(Map<String, dynamic> data) async {
    FormData formData = FormData.fromMap(data);
    // Buscamos los archivos para enviar
    Future.forEach(data.entries, (e) async {
      // FormBuilderImagePicker retorna List<dynamic>
      if (e.value is List) {
        // Se recorre List<dynamic>
        // for (var val in e.value) {
        // Buscar Instance of XFile
        // if (val is XFileBase) {
        // ignore: list_remove_unrelated_type
        // formData.fields.removeWhere((element) => element.key == e.key);
        // MultipartFile file = await _getMultipartFile(val);
        // formData.files.add(MapEntry(e.key, file));
        // }
        // }
      }
    });
    return formData;
  }

  // ignore: unused_element
  static Future _getMultipartFile(file) async {
    return MultipartFile.fromBytes(await file.readAsBytes(),
        filename: file.name);
  }
}
