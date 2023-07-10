import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/empresa.dart';
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

// Buscamos la empresa seleccionada en la lista, sin reconsultar el servidor C;
  Empresa? buscar(String id) {
    return empresas.isNotEmpty
        ? empresas.where((element) => element.id!.contains(id)).first
        : null;
  }

  Future guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/empresas', data);
      final empresaNueva = Empresa.fromJson(json);
      empresas.add(empresaNueva);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/empresas/$id', data);
      final empresaModificada = Empresa.fromJson(json);
      // Buscamos el index en lista del ID Empresa
      final index = empresas.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      empresas[index] = empresaModificada;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/empresas/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        empresas.removeWhere((empresa) => empresa.id == id);
      } else {
        throw Exception('No se ha eliminado el registro');
      }
      notifyListeners();
      return confirmado;
    } catch (e) {
      rethrow;
    }
  }

  validateForm() {
    return formKey.currentState!.validate();
  }

  saveForm() {
    formKey.currentState!.save();
  }
}
