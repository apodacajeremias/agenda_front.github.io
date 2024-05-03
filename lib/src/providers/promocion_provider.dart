import 'package:agenda_front/services.dart';
import 'package:agenda_front/src/models/entities/promocion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PromocionProvider extends ChangeNotifier {
  List<Promocion> promociones = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await ServerConection.httpGet('/promociones');
    List<Promocion> promocionesResponse = List<Promocion>.from(
        response.map((model) => Promocion.fromJson(model)));
    promociones = [...promocionesResponse];
    notifyListeners();
  }

  Promocion? buscar(String id) {
    return promociones.where((element) => element.id.contains(id)).first;
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
      final json = await ServerConection.httpPost('/promociones', data);
      final promocion = Promocion.fromJson(json);
      promociones.add(promocion);
      notifyListeners();
      NotificationService.showSnackbar('Agregado a promociones');
    } catch (e) {
      NotificationService.showSnackbarError('No agregado a promociones');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await ServerConection.httpPut('/promociones/$id', data);
      final promocion = Promocion.fromJson(json);
      // Buscamos el index en lista del ID Promocion
      final index =
          promociones.indexWhere((element) => element.id.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      promociones[index] = promocion;
      notifyListeners();
      NotificationService.showSnackbar('Promocion actualizado');
    } catch (e) {
      NotificationService.showSnackbarError('Promocion no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await ServerConection.httpDelete('/promociones/$id', {});
      final confirmado = json as bool;
      if (confirmado) {
        promociones.removeWhere((promocion) => promocion.id == id);
        notifyListeners();
        NotificationService.showSnackbar('1 promocion eliminado');
      }
    } catch (e) {
      NotificationService.showSnackbarError('Promocion no eliminado');
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
