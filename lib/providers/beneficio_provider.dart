import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/beneficio.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BeneficioProvider extends ChangeNotifier {
  List<Beneficio> beneficios = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/beneficios');
    List<Beneficio> beneficiosResponse = List<Beneficio>.from(
        response.map((model) => Beneficio.fromJson(model)));
    beneficios = [...beneficiosResponse];
    notifyListeners();
  }

  Beneficio? buscar(String id) {
    return beneficios.where((element) => element.id!.contains(id)).first;
  }

  registrar(Map<String, dynamic> data) async {
    // Si data tiene un campo ID y este tiene informacion
    if (data.containsKey('ID') && data['ID'] != null) {
      // Actualiza
      await _actualizar(data['ID'], data);
    } else {
      await _guardar(data);
    }
  }

  _guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/beneficios', data);
      final beneficio = Beneficio.fromJson(json);
      beneficios.add(beneficio);
      notifyListeners();
      NotificationsService.showSnackbar('Agregado a beneficios');
    } catch (e) {
      NotificationsService.showSnackbarError('No agregado a beneficios');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/beneficios/$id', data);
      final beneficio = Beneficio.fromJson(json);
      // Buscamos el index en lista del ID Beneficio
      final index =
          beneficios.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      beneficios[index] = beneficio;
      notifyListeners();
      NotificationsService.showSnackbar('Beneficio actualizado');
    } catch (e) {
      NotificationsService.showSnackbarError('Beneficio no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/beneficios/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        beneficios.removeWhere((beneficio) => beneficio.id == id);
        notifyListeners();
        NotificationsService.showSnackbar('1 beneficio eliminado');
      }
    } catch (e) {
      NotificationsService.showSnackbarError('Beneficio no eliminado');
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
