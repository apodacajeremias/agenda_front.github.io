import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/grupo.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class GrupoProvider extends ChangeNotifier {
  List<Grupo> grupos = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/grupos');
    List<Grupo> gruposResponse =
        List<Grupo>.from(response.map((model) => Grupo.fromJson(model)));
    grupos = [...gruposResponse];
    notifyListeners();
  }

  Grupo? buscar(String id) {
    return grupos.where((element) => element.id!.contains(id)).first;
  }

  registrar(Map<String, dynamic> data) async {
    // Si data tiene un campo ID y este tiene informacion
    if (data.containsKey('id') && data['id'] != null) {
      // Actualiza
      await _actualizar(data['id'], data);
    } else {
      await _guardar(data);
    }
  }

  _guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/grupos', data);
      final grupo = Grupo.fromJson(json);
      grupos.add(grupo);
      notifyListeners();
      NotificationsService.showSnackbar('Agregado a grupos');
    } catch (e) {
      NotificationsService.showSnackbarError('No agregado a grupos');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/grupos/$id', data);
      final grupo = Grupo.fromJson(json);
      // Buscamos el index en lista del ID Grupo
      final index = grupos.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      grupos[index] = grupo;
      notifyListeners();
      NotificationsService.showSnackbar('Grupo actualizado');
    } catch (e) {
      NotificationsService.showSnackbarError('Grupo no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/grupos/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        grupos.removeWhere((grupo) => grupo.id == id);
        notifyListeners();
        NotificationsService.showSnackbar('1 grupo eliminado');
      }
    } catch (e) {
      NotificationsService.showSnackbarError('Grupo no eliminado');
      rethrow;
    }
  }

  saveAndValidate() {
    return formKey.currentState!.saveAndValidate();
  }

  formData() {
    return formKey.currentState!.value;
  }
}
