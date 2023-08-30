import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/empresa.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class EmpresaProvider extends ChangeNotifier {
  List<Empresa> empresas = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/empresas');
    List<Empresa> empresasResponse =
        List<Empresa>.from(response.map((model) => Empresa.fromJson(model)));
    empresas = [...empresasResponse];
    notifyListeners();
  }

  Empresa? buscar(String id) {
    return empresas.where((element) => element.id!.contains(id)).first;
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
      final json = await AgendaAPI.httpPost('/empresas', data);
      final empresa = Empresa.fromJson(json);
      empresas.add(empresa);
      notifyListeners();
      NotificationsService.showSnackbar('Agregado a empresas');
    } catch (e) {
      NotificationsService.showSnackbarError('No agregado a empresas');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/empresas/$id', data);
      final empresa = Empresa.fromJson(json);
      // Buscamos el index en lista del ID Empresa
      final index = empresas.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      empresas[index] = empresa;
      notifyListeners();
      NotificationsService.showSnackbar('Empresa actualizado');
    } catch (e) {
      NotificationsService.showSnackbarError('Empresa no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/empresas/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        empresas.removeWhere((empresa) => empresa.id == id);
        notifyListeners();
        NotificationsService.showSnackbar('1 empresa eliminado');
      }
    } catch (e) {
      NotificationsService.showSnackbarError('Empresa no eliminado');
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
