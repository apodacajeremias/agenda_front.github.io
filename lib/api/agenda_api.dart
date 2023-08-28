// ignore_for_file: depend_on_referenced_packages

import 'package:agenda_front/services/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:cross_file/src/types/base.dart';

class AgendaAPI {
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
      final response = await _dio.post(path, data: _request(data));
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future httpPut(String path, Map<String, dynamic> data) async {
    configureDio();
    try {
      final response = await _dio.put(path, data: _request(data));
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future httpDelete(String path, Map<String, dynamic> data) async {
    configureDio();
    final formData = FormData.fromMap(data);
    try {
      final resp = await _dio.delete(path, data: formData);
      return resp.data;
    } catch (e) {
      rethrow;
    }
  }

  static FormData _request(Map<String, dynamic> data) {
    // Buscar XFile
    data.forEach((key, value) {
      if (kDebugMode) {
        print('${key} ${value.runtimeType}');
      }
      if (value is List) {
        for (var e in value) {
          print(' ${e.runtimeType}');
          if (e is XFile) {
            print('  Hay XFile');
          } else if (e is XFileBase) {
            print('  Hay XFileBase');
          } else if (e is XFileImage) {
            print('  Hay XFileImage');
          } else {
            print('  No hay XFile o XFileImage o XFileBase');
          }
        }
      }
    });
    // Contar cuantos hay
    return FormData.fromMap(data);
  }
}
