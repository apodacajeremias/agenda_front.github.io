import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/colaborador.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ColaboradorProvider extends ChangeNotifier {
  List<Colaborador> colaboradores = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await ServerConection.httpGet('/colaboradores');
    List<Colaborador> colaboradoresResponse = List<Colaborador>.from(
        response.map((model) => Colaborador.fromJson(model)));
    colaboradores = [...colaboradoresResponse];
    notifyListeners();
  }

  Colaborador? buscar(String id) {
    return colaboradores.where((element) => element.id!.contains(id)).first;
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
      final json = await ServerConection.httpPost('/colaboradores', data);
      final colaborador = Colaborador.fromJson(json);
      colaboradores.add(colaborador);
      notifyListeners();
      NotificationService.showSnackbar('Agregado a colaboradores');
    } catch (e) {
      NotificationService.showSnackbarError('No agregado a colaboradores');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await ServerConection.httpPut('/colaboradores/$id', data);
      final colaborador = Colaborador.fromJson(json);
      // Buscamos el index en lista del ID Colaborador
      final index =
          colaboradores.indexWhere((element) => element.id!.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      colaboradores[index] = colaborador;
      notifyListeners();
      NotificationService.showSnackbar('Colaborador actualizado');
    } catch (e) {
      NotificationService.showSnackbarError('Colaborador no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await ServerConection.httpDelete('/colaboradores/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        colaboradores.removeWhere((colaborador) => colaborador.id == id);
        notifyListeners();
        NotificationService.showSnackbar('1 colaborador eliminado');
      }
    } catch (e) {
      NotificationService.showSnackbarError('Colaborador no eliminado');
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
